//
//  CellViewModel.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 2/12/20.
//

import Foundation

struct CellViewModel: Equatable {
    let authorName: String
    private let photoURLString: String

    init(authorName: String, photoURLString: String) {
        self.authorName = authorName
        self.photoURLString = photoURLString
    }
    
    var photoURL: URL? {
        guard let url = URL(string: photoURLString) else {
            return nil
        }
        return url
    }
    
    var shouldDownloadPhoto: Bool {
        return photoURL != nil
    }
    
}
