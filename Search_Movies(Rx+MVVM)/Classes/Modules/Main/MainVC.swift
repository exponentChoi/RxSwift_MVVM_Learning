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
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.placeholder = "영화제목 검색"
            searchController.obscuresBackgroundDuringPresentation = false // 검색 시 흐림설정
            searchController.definesPresentationContext = true
            searchController.searchResultsUpdater = self // 입력 시 마당 조회
            searchController.searchBar.delegate = self
            
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
        
        _ = viewModel.transform(req: .init())
    }
}

// MARK: -
extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        Log.d(searchController.searchBar.text)
    }
}

extension MainVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        _  = viewModel.testTransform(req: .init())
    }
}
