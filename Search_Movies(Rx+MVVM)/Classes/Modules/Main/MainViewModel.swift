//
//  MainViewModel.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import RxSwift

class MainViewModel: ViewModelType {
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MainViewModel

    // MARK: - Propertis
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        return Output()
    }
}
