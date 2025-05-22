//
//  NetworkProtocol.swift
//  Sports
//
//  Created by Macos on 22/05/2025.
//

import Foundation

protocol NetworkProtocol{
    static func fetchData<T : Decodable>(sport:String?, quray : String, complitionHandler : @escaping (T? , Error?)->Void)
}
