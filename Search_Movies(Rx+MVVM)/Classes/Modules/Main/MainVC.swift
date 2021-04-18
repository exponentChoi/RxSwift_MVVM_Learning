//
//  ViewController.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/04.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MainVC: BaseViewController {
    
    var viewModel: MainViewModel = MainViewModel()
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setNavigationBar() // todo: 공통으로 변경할 예정
        bindingViewModel()
    }
    
    private func setupUI() {
        let movieCell = UINib(nibName: "MovieCell", bundle: nil)
        moviesCollectionView.register(movieCell, forCellWithReuseIdentifier: MovieCell.identifier)
        
        moviesCollectionView.rx.setDelegate(self)
        moviesCollectionView.collectionViewLayout = setCollectionViewLayout()
        moviesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    }
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        flowLayout.estimatedItemSize = CGSize(width: (width / 3) - 4, height: (width / 3) + 20)
        flowLayout.minimumLineSpacing = 5 // 위아래 공간
        flowLayout.minimumInteritemSpacing = 1 // 좌우 공간
        return flowLayout
    }
    
    private func setNavigationBar() {
        title = "검색"
        let searchController: UISearchController = {
            
            let sb = UIStoryboard(name: "SearchHistory", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SearchHistoryVC")
            
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.placeholder = "영화제목 검색"
            searchController.obscuresBackgroundDuringPresentation = false // 검색 시 흐림설정
            searchController.definesPresentationContext = true
            searchController.searchResultsUpdater = self // 입력 시 마당 조회
            searchController.searchBar.delegate = self
            if #available(iOS 13.0, *) {
                
            } else {
                // Fallback on earlier versions
            }
            
            return searchController
        }()
        
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.searchController = searchController
    }
    
    // MARK: - Binding
    private func bindingViewModel() {
        viewModel.movies.bind(to: moviesCollectionView.rx.items(cellIdentifier: MovieCell.identifier, cellType: MovieCell.self)) {
            row, data, cell in
            cell.setItem(imageURL: data.image)
        }.disposed(by: disposeBag)
        
        moviesCollectionView.rx.modelSelected(MovieModel.self)
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return}

                Log.d("item: \(data)")
                
                let vc = MovieDetailVC.instantiate(storyboard: "MovieDetail")
                vc.movieItem = data
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
        
        
        _ = viewModel.transform(req: .init(query: "리틀 포레스트"))
    }
}

// MARK: - 검색어 자동완성을 위한 준비
extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Apply the filtered results to the search results table.
        if let searchHistoryController = searchController.searchResultsController as? SearchHistoryVC {
            if let histories = myUserDefault.array(forKey: "searchHistories") as? [String] {
                searchHistoryController.histories.accept(histories)
            }
        }
        
        _  = viewModel.transform(req: .init(query: searchController.searchBar.text!))
    }
    
}

// MARK: - 검색
extension MainVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Log.d("searchBarSearchButtonClicked")
        searchBar.resignFirstResponder()
        _  = viewModel.transform(req: .init(query: searchBar.text!))
        
        if var histories = myUserDefault.array(forKey: "searchHistories") as? [String] {
            histories.append(searchBar.text!)
            myUserDefault.setValue(histories, forKey: "searchHistories")
        } else {
            myUserDefault.setValue([searchBar.text!], forKey: "searchHistories")
        }
        
        searchBar.showsScopeBar = false
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        Log.d("searchBarResultsListButtonClicked")
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        Log.d("searchBarBookmarkButtonClicked")
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
}


// MARK: - collectionView Delegate
extension MainVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: (width / 3) - 4, height: (width / 3) + 20)
    }
}

let myUserDefault = UserDefaults.standard
