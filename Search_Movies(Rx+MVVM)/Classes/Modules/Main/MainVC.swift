//
//  ViewController.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/04.
//

import UIKit
import RxSwift
import RxCocoa

class MainVC: BaseViewController {
    
    var viewModel: MainViewModel = MainViewModel()
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar() // todo: 공통으로 변경할 예정
        bindingViewModel()
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
        viewModel.movies.bind(to: moviesTableView.rx.items(cellIdentifier: "cell", cellType: MovieCell.self)) { row, data, cell in
            cell.textLabel?.text = data.title
        }.disposed(by: disposeBag)
        
        _ = viewModel.transform(req: .init(query: "starwards"))
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

let myUserDefault = UserDefaults.standard
