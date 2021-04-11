//
//  BaseViewController.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import UIKit

class BaseViewController: UIViewController {

    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화제목 검색"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.hidesSearchBarWhenScrolling = false
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.searchController = searchController
    }
}
