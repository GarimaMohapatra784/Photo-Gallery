//
//  Service.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 1/12/20.
//

import Foundation

final class Service: ServiceProvider {
    
    func photoGalleryInfo(completion: @escaping (Result<[GalleryInfo], NSError>) -> Void) {
        guard let url = URL(string: Constant.url) else {
            let error = NSError.init(domain: "Error", code: 00, userInfo: ["Reason": "Invalid URL"])
            completion(.failure(error))
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let data = data else { return }
            do {
                let jsonDecoder = JSONDecoder()
                let decodedData = try jsonDecoder.decode([GalleryInfo].self, from: data)
                completion(.success(decodedData))
                
            } catch(let error) {
                completion(.failure(error as NSError))
            }
        }
        task.resume()
    }
}
