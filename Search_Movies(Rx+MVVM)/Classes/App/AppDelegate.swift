//
//  AppDelegate.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        let nvc = BaseNavigationController(rootViewController: vc)
        
        let searchController: UISearchController = {
           let searchController = UISearchController(searchResultsController: nil)
            
           searchController.searchBar.placeholder = "New Search"
           searchController.searchBar.searchBarStyle = .minimal
           searchController.dimsBackgroundDuringPresentation = false
           searchController.definesPresentationContext = true

          return searchController
       }()
        
        nvc.navigationItem.searchController = searchController
//        navigationItem.searchController = searchController
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        
        return true
    }

}
