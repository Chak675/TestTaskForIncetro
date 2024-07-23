//
//  OrganizationModelDetail.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 21.07.2024.
//

import Foundation

struct OrganizationModelDetail: Codable, Identifiable {
    
    static let `default` = OrganizationModelDetail(id: 1, name: "", categoryName: "", rate: 0, photos: [])
    
    let id: Int
    let name:  String
    let categoryName: String
    let rate:  Double?
    let photos: [URL]
}
