//
//  SearchHistoryViewModel.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/14.
//

import RxSwift
import RxCocoa

class SearchHistoryViewModel: ViewModelType {
    // MARK: - ViewModelType Protocol
    typealias ViewModel = SearchHistoryViewModel

    // MARK: - Propertis
    struct Input {
        let query: String
    }
    
    struct Output {
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        return Output()
    }
}
