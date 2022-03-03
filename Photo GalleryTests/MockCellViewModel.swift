//
//  MockCellViewModel.swift
//  Photo GalleryTests
//
//  Created by Garima Mohapatra on 7/12/20.
//

import Foundation
import XCTest
@testable import Photo_Gallery

class MockCellViewModel: XCTestCase {
    var cellViewModel: CellViewModel!
    
    func testPhotoUrl() {
        cellViewModel = CellViewModel(authorName: "AuthorName", photoURLString: "PhotoUrl")
        XCTAssertEqual(cellViewModel.photoURL, URL(string:"PhotoUrl"))
        XCTAssertEqual(cellViewModel.shouldDownloadPhoto, true)
        
        // If PhotoURL is nil
        
        cellViewModel = CellViewModel(authorName: "AuthorName", photoURLString: "")
        XCTAssertEqual(cellViewModel.photoURL, nil)
    }
}
