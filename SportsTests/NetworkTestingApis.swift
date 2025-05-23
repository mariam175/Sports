//
//  NetworkTesting.swift
//  SportsTests
//
//  Created by Macos on 23/05/2025.
//

import XCTest
@testable import Sports
final class NetworkTestingApis: XCTestCase {
    var service:ApiService?

    override func setUpWithError() throws {

        service = ApiService(isOffline: false)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }



    func testFootball_ReturnsData() {
           let expectation = self.expectation(description: "Loading Teams Data")

           let sport = "football"
           let query = "met=Leagues"

           Network.fetchData(sport: sport, quray: query) { (response: LeaguesResponse?, error) in
               XCTAssertNil(error, "error \(error?.localizedDescription ?? "")")
                        XCTAssertNotNil(response, "Empty")
                        print("Response success: \(response)")
                        expectation.fulfill()

           }

           waitForExpectations(timeout: 10)
       }


    func testTeams_ReturnsData() {
           let expectation = self.expectation(description: "Loading Teams Data")

           let sport = "football"
           let query = "met=Teams&teamId=96"

           Network.fetchData(sport: sport, quray: query) { (response: TeamResponse?, error) in
               XCTAssertNil(error, "error \(error?.localizedDescription ?? "")")
                        XCTAssertNotNil(response, "Empty")
                        print("Response success: \(response)")

               expectation.fulfill()
           }

           waitForExpectations(timeout: 10)
       }
    }



//    func testTeams_ReturnsData() {
//
//
//
//          let expectation = self.expectation(description: "Loading Teams Data")
//
//
//          let url = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=96&APIkey=\(Config.apiKey)"
//
//
//
//        service?.loadDataFromTeamsApi(url: url) { result, error in
//            XCTAssertNil(error, "error \(error?.localizedDescription ?? "")")
//            XCTAssertNotNil(result, "Empty")
//            print("Response success: \(result)")
//            expectation.fulfill()
//        }
//
//
//          waitForExpectations(timeout: 10)
//
//      }


//    func testFootball_ReturnsData() {
//
//
//
//          let expectation = self.expectation(description: "Loading Football Data")
//
//
//          let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(Config.apiKey)"
//
//
//
//        service?.loadDataFromFootballApi(url: url) { result, error in
//            XCTAssertNil(error, "error \(error?.localizedDescription ?? "")")
//            XCTAssertNotNil(result, "Empty")
//            print("Response success: \(result)")
//            expectation.fulfill()
//        }
//
//
//          waitForExpectations(timeout: 10)
//
//      }












