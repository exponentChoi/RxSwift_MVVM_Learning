//
//  MainViewModel.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import RxSwift
import RxCocoa

class MainViewModel: ViewModelType {
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MainViewModel

    // MARK: - Propertis
    struct Input {
        let query: String
    }
    
    struct Output {
        let movies: BehaviorRelay<[MovieModel]>
    }
    
    let movies = BehaviorRelay<[MovieModel]>(value: [])
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        
        let params:[String: Any] = ["query": req.query]
        
        Network().request(parameters: params,
                          responseType: MovieModel.self,
                          successHandler: {
                            guard let items = $0.items else { return }
                            self.movies.accept(items)
                          }, failureHandler: { _ in
                            
                          })
        
        return Output(movies: movies)
    }
}
