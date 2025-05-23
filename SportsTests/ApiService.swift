//
//  ApiService.swift
//  SportsTests
//
//  Created by Macos on 23/05/2025.
//

import Foundation

@testable import Sports
class ApiService {
    var isOffline : Bool

    init(isOffline: Bool = false) {
        self.isOffline = isOffline
    }

    func loadDataFromFootballApi(url: String, complitionHandler: @escaping ([Leagues], Error?) -> Void) {

        if isOffline {
            complitionHandler([], responseError.responseFailed)
            return
        }

        guard let url = URL(string: url) else {
            complitionHandler([], responseError.responseFailed)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                complitionHandler([], error)
                return
            }

            guard let data = data else {
                complitionHandler([], responseError.responseFailed)
                return
            }

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(LeaguesResponse.self, from: data)
                complitionHandler(apiResponse.result, nil)
            } catch {
                complitionHandler([], error)
            }
        }

        task.resume()
    }

    func loadDataFromTeamsApi(url: String, complitionHandler: @escaping ([TeamDetails] , Error?) -> Void) {

        if isOffline {
            complitionHandler([], responseError.responseFailed)
            return
        }

        guard let url = URL(string: url) else {
            complitionHandler([], responseError.responseFailed)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                complitionHandler([], error)
                return
            }

            guard let data = data else {
                complitionHandler([], responseError.responseFailed)
                return
            }

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(TeamResponse.self, from: data)
                complitionHandler(apiResponse.result, nil)
            } catch {
                complitionHandler([], error)
            }
        }

        task.resume()
    }

    enum responseError: Error {
        case responseFailed
    }
}


