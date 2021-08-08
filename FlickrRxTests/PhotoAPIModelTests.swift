//
//  PhotoAPIModelTests.swift
//  FlickrRxTests
//
//  Created by Luis López on 9/8/21.
//

import XCTest
@testable import FlickrRx

class PhotoAPIModelTests: XCTestCase {

    func testPhotoSearchResponseSuccessfulParse() throws {
        let jsonData = try! data(fromJSONFile: "PhotoSearchSampleResponse")
        XCTAssertNoThrow(try JSONDecoder().decode(PhotoSearchResponse.self, from: jsonData))
    }
    
    func testPhotoSearchEmptyResponseSuccessfulParse() throws {
        let jsonData = try! data(fromJSONFile: "PhotoSearchEmptyResponse")
        XCTAssertNoThrow(try JSONDecoder().decode(PhotoSearchResponse.self, from: jsonData))
    }

}

extension String: Error { }

func data(fromJSONFile fileName: String) throws -> Data {
    guard let url = Bundle(for: PhotoAPIModelTests.self).url(forResource: fileName, withExtension: "json") else { throw "Couldn't create file url" }
    return try Data(contentsOf: url)
}
