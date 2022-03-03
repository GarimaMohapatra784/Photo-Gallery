//
//  ServiceProtocol.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 3/12/20.
//

import Foundation

protocol ServiceProvider: AnyObject {
    func photoGalleryInfo(completion: @escaping (Swift.Result<[GalleryInfo], NSError>) -> Void)
}
