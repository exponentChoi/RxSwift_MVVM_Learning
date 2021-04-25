//
//  SearchHistoryVC.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/14.
//

import UIKit
import RxCocoa
import RxSwift

class SearchHistoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = SearchHistoryViewModel()
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    
    var histories = BehaviorRelay<[String]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindingViewModel()
    }
    
    // MARK: - Binding
    private func bindingViewModel() {
        histories.bind(to: tableView.rx.items(cellIdentifier: "cell")) { row, data, cell in
            cell.textLabel?.text = data
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe { str in
                self.dismiss(animated: true, completion: nil)
                Log.d("selected search word: \(str.element)")
            }.disposed(by: disposeBag)
    }
}
