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
    }

    override func tearDownWithError() throws {
        service = nil
    }


    func testFootball_ReturnsData() {
           let expectation = self.expectation(description: "Loading Teams Data")

           let sport = "football"
           let query = "met=Leagues"

           Network.fetchData(sport: sport, quray: query) { (response: LeaguesResponse?, error) in
               XCTAssertNil(error, "error \(error?.localizedDescription ?? "")")
                        XCTAssertNotNil(response, "Empty")
               //print("Response success: \(String(describing: response)//)")
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
    
    func testFixtures(){
        let expectation = expectation(description: "wait for Loading")
        Network.fetchData(sport: "football", quray: "met=Fixtures&leagueId=177&from=2025-05-22&to=2025-05-30"){
            (response:EventRespose?, error) in
            if let error = error {
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            else{
                XCTAssertEqual(response?.success, 1)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testAllteams(){
        let expectation = expectation(description: "wait for Loading")
        Network.fetchData(sport: "football", quray: "met=Standings&leagueId=177"){
            (response:LeagueTeamsResponse?, error) in
            if let error = error {
                XCTFail("Request failed: \(error.localizedDescription)")
            }
            else{
                XCTAssertEqual(response?.success, 1)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testWrongApi(){
        let expectation = expectation(description: "wait for Loading")
        Network.fetchData(sport: "football", quray: "met=Team&teamId=84"){
            (response:TeamResponse?, error) in
                XCTAssertNil(response)
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












