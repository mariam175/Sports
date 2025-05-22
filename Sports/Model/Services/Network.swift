//
//  Network.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import Foundation
import Alamofire


class Network:NetworkProtocol{

    static func fetchData<T : Decodable>(sport:String?, quray : String, complitionHandler : @escaping (T? , Error?)->Void){
        guard let sportType = sport else {
            return
        }
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?\(quray)&APIkey=\(Config.apiKey)"

        AF.request(url).responseDecodable(of: T.self) { response in
             switch response.result {
             case .success(let data):
                 print("sucess")
                 DispatchQueue.main.async {
                     complitionHandler(data, nil)

                 }
             case .failure(let error):
                 print("\(error.localizedDescription)")
                 DispatchQueue.main.async {
                     complitionHandler(nil, error)
                 }
             }
         }
        
    }
    
}
