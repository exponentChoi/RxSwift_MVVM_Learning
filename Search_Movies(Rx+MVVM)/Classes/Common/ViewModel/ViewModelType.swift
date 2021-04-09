//
//  ViewModelType.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import Foundation

protocol ViewModelType: ViewModel {
    // ViewModel
    associatedtype ViewModel: ViewModelType

    // Input
    associatedtype Input

    // Output
    associatedtype Output

    func transform(req: ViewModel.Input) -> ViewModel.Output
}
