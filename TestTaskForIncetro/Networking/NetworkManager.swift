//
//  NetworkManager.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 15.07.2024.
//

//import Foundation
//
//class NetworkManager {
//    
//    enum NetworkError: String, Error {
//        case invalidURL = "Invalid URL address"
//        case invalidAuthorisation = "Invald authorisation API"
//    }
//    
//    @MainActor
//    func fetchData(from url: String?, completion: @escaping (Result<OrganizationsModel, Error>) -> Void) async {
//        guard let url, let dataURL = URL(string: url) else {
//            return completion(.failure(NetworkError.invalidURL))
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: dataURL)
//            let decodedResponse = try JSONDecoder().decode(OrganizationsModel.self, from: data)
//                
//            completion(.success(decodedResponse))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//}
