//
//  MovieDetailViewModel.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/18.
//

import RxSwift
import RxCocoa

class MovieDetailViewModel: ViewModelType {
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MovieDetailViewModel

    // MARK: - Propertis
    struct Input {
    }
    
    struct Output {
    }
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        return Output()
    }
}
