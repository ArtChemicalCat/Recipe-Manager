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
    case dailyQuotaUsed
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidServerResponse:
            return "Invalid server response"
        case .dailyQuotaUsed:
            return "All daily quotas used"
        }
    }
}
