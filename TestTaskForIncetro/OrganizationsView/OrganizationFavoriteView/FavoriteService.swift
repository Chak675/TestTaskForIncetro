//
//  FavoriteService.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 25.07.2024.
//

import Foundation
import SwiftUI

@MainActor
class FavoriteService: ObservableObject {
    
    func addOrganizationsFavorite(id: Int) async throws -> Int {
        guard let url = URL(string: (HostOrganization.developOrganization.rawValue) + "\(id)/favorite/") else { throw CustomError.network }
        print("addFavorite : \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("Token \(HostOrganization.token.rawValue)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(FavoriteOrganizationModel.self, from: data).organization
    }
    
    func deleteOrganizationsFavorite(id: Int) async throws -> Bool {
        guard let url = URL(string: (HostOrganization.developOrganization.rawValue) + "\(id)/favorite/") else { throw CustomError.network }
        print("delFavorite : \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.addValue("Token \(HostOrganization.token.rawValue)", forHTTPHeaderField: "Authorization")
        let (_, response) = try await URLSession.shared.data(for: request)
        
        return (response as? HTTPURLResponse)?.statusCode == 204
    }
}
