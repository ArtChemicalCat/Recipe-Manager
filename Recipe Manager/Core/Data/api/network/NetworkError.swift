//
//  NetworkError.swift
//  Recipe Manager
//
//  Created by Николай Казанин on 14.05.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
}
