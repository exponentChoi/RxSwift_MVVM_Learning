//
//  MainViewModel.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import RxSwift
import RxCocoa

class MainViewModel: Network, ViewModelType {
    // MARK: - ViewModelType Protocol
    typealias ViewModel = MainViewModel
    
    var disposeBag = DisposeBag()

    // MARK: - Propertis
    struct Input {
        let query: String
    }
    
    struct Output {
        //let movies: BehaviorRelay<[MovieModel]>
    }
    
    let movies = BehaviorRelay<[MovieModel]>(value: [])
    var query = ""
    
    func transform(req: ViewModel.Input) -> ViewModel.Output {
        let params:[String: Any] = ["query": req.query,
                                    "display": 30,
                                    "start": 1]
        
        query = req.query
        
        rxRequest(parameters: params, responseType: MovieModel.self)
            .subscribe { result in

                switch result {
                case .success(let reqResult):

                    switch reqResult {
                    case .success(let reqItem):
                        if let item = reqItem.items {
                            self.movies.accept(item)
                            
                            var search_titles = item.compactMap { $0.title?.htmlEscaped }
                            
                            if let titles = myUserDefault.array(forKey: Constants.UserDefaults.search_titles) as? [String] {
                                titles.forEach { search_titles.append($0) }
                            }
                            
                            let setTitles = Set(search_titles).sorted(by: <)
                            myUserDefault.setValue(Array(setTitles), forKey: Constants.UserDefaults.search_titles)
                        }
                    case .error(let reqError):
                        Log.d("네이버 API 발생!!(\(reqError.code)): \(reqError.message)")
                    }

                case .failure(let error):
                    Log.d("Network Error 발생: \(error.localizedDescription)")
                }
            }.disposed(by: disposeBag)
        
        // 기존 사용하던 request
//        request(parameters: params,
//                          responseType: MovieModel.self,
//                          successHandler: {
//                            guard let items = $0.items else { return }
//                            self.movies.accept(items)
//                          }, failureHandler: { _ in
//
//                          })
        
        return Output()
    }
}


