//
//  CellConfigurable.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 5/12/20.
//

import Foundation

protocol CellConfigurable: AnyObject {
    
    associatedtype CellViewModel: Equatable
    
    func configure(with viewModel: CellViewModel)
}
