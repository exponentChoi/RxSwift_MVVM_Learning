//
//  BaseNavigationController.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController: UISearchController = {

           let searchController = UISearchController(searchResultsController: nil)
           searchController.searchBar.placeholder = "New Search"
           searchController.searchBar.searchBarStyle = .minimal
           searchController.dimsBackgroundDuringPresentation = false
           searchController.definesPresentationContext = true

          return searchController
       }()
        
        navigationItem.searchController = searchController
    }
}
