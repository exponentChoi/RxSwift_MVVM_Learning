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
    
    static func instantiate(storyboard: String) -> Self {
        let uiStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        
        // 임의 타입의 값으로부터 생성
        let identifier = String(describing: self)
        // 유니코드 UTF-8 문자열로 변환
        let utf8String = String(utf8String: identifier)
        
        // Storyboard 생성 후 Casting
        return uiStoryboard.instantiateViewController(withIdentifier: utf8String!) as! Self
    }
}
