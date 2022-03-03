//
//  PhotoGallery.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 1/12/20.
//

import Foundation

struct PhotoGallery: Decodable {
    let photoGallery: [GalleryInfo]
}

struct GalleryInfo: Decodable {
    let authorName: String
    let photoURL: String
    
    private enum CodingKeys : String, CodingKey {
        case authorName = "author"
        case photoURL = "download_url"
    }
}
