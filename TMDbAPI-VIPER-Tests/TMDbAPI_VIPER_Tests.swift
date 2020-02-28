//
//  TMDbAPI_VIPER_Tests.swift
//  TMDbAPI-VIPER-Tests
//
//  Created by David Figueroa on 27/02/20.
//  Copyright © 2020 David Figueroa. All rights reserved.
//

import XCTest
@testable import The_Movie_DB
import RxSwift

class TMDbAPI_VIPER_Tests: XCTestCase {

    var disposeBag = DisposeBag()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        checkDatesFiltered(movieName:"Scarface", year: "1983")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func checkDatesFiltered(movieName: String, year: String){
           //CHECK IF THE ARRAY RETURNED BY THE SERVER CONTAINS ONLY MEDIA OF THAT GIVEN TYPE
    
        let expectation =  self.expectation(description: "Search Request")
        
        let interactor = SearchInteractor()
        interactor.search(title: movieName, type: "Movie", year: year)
            .subscribe(onNext: { mediaArray in
                XCTAssertGreaterThan(mediaArray.count, 0)
                mediaArray.forEach { media in
                    if self.getYearFromString(dateString: media.releaseDate ?? "")  != year {
                        XCTFail("IS GETTING WRONG MOVIES")
                    }
                }
                expectation.fulfill()
            }, onError: { (error) in
                print(error)
                // HANDLE THE ERROR
            })
            .disposed(by: disposeBag)
        waitForExpectations(timeout: 10) { error in
            if (error != nil) {
                XCTFail("FAIL")
            }
        }
    }
    
    func getYearFromString(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else {
            return ""
        }
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }

}
