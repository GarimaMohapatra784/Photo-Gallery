//
//  MockViewModel.swift
//  Photo GalleryTests
//
//  Created by Garima Mohapatra on 3/12/20.
//

import XCTest
@testable import Photo_Gallery

class MockViewModel: XCTestCase {
    
    private var mockServiceStateDelegate: MockServiceDelegate!
    private var mockService: MockService!
    private var viewModel: ViewModel!
    
    override func setUp() {
        super.setUp()
        mockServiceStateDelegate = MockServiceDelegate()
        mockService = MockService()
        
        
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testSuccessResponse() {
        viewModel = ViewModel(service: mockService)
        mockService.galleryInfo = [GalleryInfo(authorName: "Author1", photoURL: "Photo1"), GalleryInfo(authorName: "Author2", photoURL: "Photo2")]
        
        XCTAssertEqual(viewModel.numberOfRows, 10)

        viewModel.fetchResult()
        
        let expectedModel = Model(authorNames: ["Author1", "Author2"], photoURLs: ["Photo1", "Photo2"])
        XCTAssertEqual(viewModel.state, .success(model: expectedModel))
        XCTAssertEqual(viewModel.numberOfSections, 1)
        XCTAssertEqual(viewModel.numberOfRows, mockService.galleryInfo.count)
    }

    
    func testCellViewModels() {
        viewModel = ViewModel(service: mockService)
        mockService.galleryInfo = [GalleryInfo(authorName: "Author1", photoURL: "Photo1"), GalleryInfo(authorName: "Author2", photoURL: "Photo2")]
        viewModel.fetchResult()
        XCTAssertEqual(viewModel.cellViewModels, [CellViewModel(authorName: "Author1", photoURLString: "Photo1"), CellViewModel(authorName: "Author2", photoURLString: "Photo2")] )
    }
    
    func testErrorModel() {
        viewModel = ViewModel(service: mockService)
        mockService.error = NSError()
        
        viewModel.fetchResult()
        
        XCTAssertEqual(viewModel.numberOfRows, 1)
        XCTAssertTrue(viewModel.cellViewModels.isEmpty)
        XCTAssertEqual(viewModel.errorModel.errorText,  "Connection Error. We are unable to load the photos right now. Please try again later.")
    }

}

private final class MockServiceDelegate: Delegate {
    
    var didLoadingCalled: Bool = false
    func didLoading<T>(_ viewModel: T) {
        didLoadingCalled = true
    }
    
    var didSucceedCalled: Bool = false
    func didSucceed<T>(_ viewModel: T) {
        didSucceedCalled = true
    }
    var didFailCalled: Bool = false
    
    func didFail<T, E>(_ viewModel: T, errorModel: E) where T : ViewConfigurable, E : Error {
        didFailCalled = true
    }
}

private final class MockService: ServiceProvider {
    
    var galleryInfo: [GalleryInfo] = []
    var error: NSError?
    func photoGalleryInfo(completion: @escaping (Result<[GalleryInfo], NSError>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        completion(.success(galleryInfo))
    }
}
