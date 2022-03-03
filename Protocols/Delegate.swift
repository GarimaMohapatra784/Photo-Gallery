//
//  ServiceStateDelegate.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 2/12/20.
//

import Foundation

protocol Delegate: AnyObject {

    func didLoading<T: ViewConfigurable>(_ viewModel: T)
    func didSucceed<T: ViewConfigurable>(_ viewModel: T)
    func didFail<T: ViewConfigurable, E: Error>(_ viewModel: T, errorModel: E)
}

protocol ViewConfigurable {
    
    associatedtype CellViewModel: Equatable
    associatedtype Model: Equatable

    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    var state: State<Model, Error> { get }
    var cellViewModels: [CellViewModel] { get }
}
