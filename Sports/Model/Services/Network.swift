//
//  Network.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import Foundation
import Alamofire

protocol NetworkProtocol{
    static func fetchDataFromJSON(sport : String? ,complitionHandler: @escaping (LeaguesResponse?) -> Void)
}


class Network:NetworkProtocol{


    
    static func fetchDataFromJSON(sport : String? , complitionHandler: @escaping (LeaguesResponse?) -> Void) {

        guard let sportType = sport else {
            return
        }
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=Leagues&APIkey=\(Config.apiKey)"

        AF.request(url).responseDecodable(of: LeaguesResponse.self) { response in
             switch response.result {
             case .success(let data):
                 DispatchQueue.main.async {
                     complitionHandler(data)

                 }
             case .failure(let error):
                 print("\(error.localizedDescription)")
                 DispatchQueue.main.async {
                     complitionHandler(nil)
                 }
             }
         }


    }






}
