//
//  NetworkingTests.swift
//  AHTVmazeDemoTests
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import XCTest
@testable import AHTVmazeDemo

class NetworkingTests: XCTestCase {
    func testSearch() {
        let request = ShowSearchRequest(query: "The Simpsons")
        let router = SearchRouter.showSearch(request: request)
        let provider = NetworkingProvider(router: router)
        let expectation = XCTestExpectation(description: "Waiting for request")
        provider.send() { result in
            switch result {
            case .success(let searchDictionary):
                let tvShows = searchDictionary
                    .compactMap({ $0["show"] as? [String: Any] ?? nil })
                    .compactMap({ TVShow.from($0) })
                XCTAssertEqual(tvShows[0].name, "The Simpsons")
                XCTAssertEqual(tvShows[0].type, "Animation")
                XCTAssertEqual(tvShows[0].language, "English")
                XCTAssertEqual(tvShows[0].genres, ["Comedy", "Family"])
                XCTAssertEqual(tvShows[0].status, "Running")
                XCTAssertEqual(tvShows[0].premiered, "1989-12-17")
                XCTAssertEqual(tvShows[0].rating, Rating(average: 8.5))
                XCTAssertEqual(tvShows[0].image.mediumURL, URL(string: "http://static.tvmaze.com/uploads/images/medium_portrait/0/639.jpg"))
                XCTAssertEqual(tvShows[0].image.originalURL, URL(string: "http://static.tvmaze.com/uploads/images/original_untouched/0/639.jpg"))
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}

