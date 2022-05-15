//
//  DataParser.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 15.05.2022.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(data: Data) throws -> T
}

class DataParser: DataParserProtocol {
    private var jsonDecoder = JSONDecoder()
    
    func parse<T>(data: Data) throws -> T where T : Decodable {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
