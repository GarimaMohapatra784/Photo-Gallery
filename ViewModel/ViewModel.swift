//
//  ViewModel.swift
//  Photo Gallery
//
//  Created by Garima Mohapatra on 1/12/20.
//

import Foundation

final class ViewModel: ViewConfigurable {
    
    private let service: ServiceProvider
    
    weak var delegate: Delegate?
    
    init(service: ServiceProvider = Service()) {
        self.service = service
    }
    
    private(set) var state: State<Model, Error> = .loading {
        didSet {
            switch state {
            case .loading:
                delegate?.didLoading(self)
            case .success:
                delegate?.didSucceed(self)
            case .failure(let errorModel):
                delegate?.didFail(self, errorModel: errorModel)
            }
        }
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        switch state {
        case .loading:
            return 10
        case .success(let model):
            return model.authorNames.count
        case .failure:
            return 1
        }
    }
    
    var cellViewModels: [CellViewModel] {
        switch state {
        case .success(let model):
            return model.authorNames.enumerated().map { index, author in
                return CellViewModel(authorName: author, photoURLString: model.photoURLs[index])
            }
        case .failure, .loading:
            return []
        }
    }

    func fetchResult() {
        service.photoGalleryInfo { (result) in
            switch result {
            case .success(let decodedData):
                let authorNames = decodedData.map { $0.authorName }
                let photoURLs = decodedData.map { $0.photoURL  }
                let model = Model(authorNames: authorNames, photoURLs: photoURLs)
                self.state = .success(model: model)
            case .failure(let error):
                self.state = .failure(error: error)
            }
        }
    }
    
    var errorModel: ErrorModel {
        return ErrorModel()
    }
}

struct Model: Equatable {
    let authorNames: [String]
    let photoURLs: [String]
    
    init(authorNames: [String] = [], photoURLs: [String] = []) {
        self.authorNames = authorNames
        self.photoURLs = photoURLs
    }
}

struct ErrorModel: Equatable {
    let errorText = "Connection Error. We are unable to load the photos right now. Please try again later."
}
