//
//  OrganizationDetailViewModel.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 18.07.2024.
//

import Foundation
import SwiftUI

@MainActor
class OrganizationDetailViewModel: ObservableObject {
    
    @Published var organizationsDetail: OrganizationModelDetail = .default // 1
    @Published var rating = 0.0
    @Published private var organization = [OrganizationModelDetail]()  // 2
    @Published var showFavorites = false // ?
    
    let favoriteService = FavoriteService()
    
    func getOrganizationsDetail(id: Int) async throws {
        guard let url = URL(string: (HostOrganization.developOrganization.rawValue) + "\(id)/") else { throw CustomError.network }
        print("URL for server: \(url)")
        
        var request = URLRequest(url: url)
        
        request.addValue("Token \(HostOrganization.token.rawValue)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        organizationsDetail = try JSONDecoder().decode(OrganizationModelDetail.self, from: data)
    }
    
    func addToFavorite(id: Int) {
        Task {
            let id = try await favoriteService.addOrganizationsFavorite(id: id)
            guard let index = organization.firstIndex(where: { $0.id == id }) else { return }
            
            let organisation = organization[index]
            organization[index] = OrganizationModelDetail(
                id: organisation.id,
                name: organisation.name,
                categoryName: organisation.categoryName,
                rate: organisation.rate,
                photos: organisation.photos,
                isFavorite: true
            )
        }
    }
 
    func removeFromFavorite(id: Int) {
        Task {
            let isRemoved = try await favoriteService.deleteOrganizationsFavorite(id: id)
            guard isRemoved, let index = organization.firstIndex(where: { $0.id == id }) else { return }
            
            let organisation = organization[index]
            organization[index] = OrganizationModelDetail(
                id: organisation.id,
                name: organisation.name,
                categoryName: organisation.categoryName,
                rate: organisation.rate,
                photos: organisation.photos,
                isFavorite: false
            )
        }
       
    }
}
