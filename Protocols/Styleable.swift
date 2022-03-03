//
//  Styleable.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 5/12/20.
//

import Foundation

protocol Styleable: AnyObject {
    
    associatedtype Style: Equatable
    
    func applyStyle(_ style: Style)
}
