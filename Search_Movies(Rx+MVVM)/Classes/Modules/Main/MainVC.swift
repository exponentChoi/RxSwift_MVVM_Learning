//
//  ViewController.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/04.
//

import UIKit
import RxSwift

class MainVC: BaseViewController {
    
    var viewModel: MainViewModel = MainViewModel()
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params:[String: Any] = ["quer": "starwars"]
        
        Network().request(parameters: params,
                          responseType: MovieModel.self,
                          successHandler: {
                            guard let items = $0.items else { return }
                          }, failureHandler: {
                            Log.d($0.message)
                          })
    }
}

