//
//  NetworkManager.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 15.07.2024.
//

import Foundation

enum CustomError: Error {
    case network
}

extension CustomError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .network: return "An error occurred while accessing the server"
        }
    }
}
