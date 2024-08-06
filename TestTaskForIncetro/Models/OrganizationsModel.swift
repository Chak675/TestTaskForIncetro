//
//  OrganizationsModel.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 15.07.2024.
//

import Foundation

struct OrganizationsModel: Codable {
    
    let data: [OrganizationsData]
}

struct OrganizationsData: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let photo: URL
    let rate: Double?
    let averageCheck: [String] 
    let cuisines:  [String]
    let isFavorite: Bool
}
