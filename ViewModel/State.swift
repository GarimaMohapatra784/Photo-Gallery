//
//  State.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 2/12/20.
//

import Foundation

enum State<T: Equatable, E: Error> {
    case loading
    case success(model: T)
    case failure(error: E)
}

extension State: Equatable {
    static func == (lhs: State, rhs: State) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.failure, .failure):
            return true
        case (.success(let lhsModel), .success(let rhsModel)):
            return lhsModel == rhsModel
        default:
            return false
        }
    }
}
