//
//  OrganizationsView.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 15.07.2024.
//

import SwiftUI

struct OrganizationsView: View {
    
    @StateObject private var viewModel = OrganizationViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                    VStack {
                        ForEach(viewModel.favoriteList) { organization in
                            NavigationLink(destination: OrganizationDetailView(organizationID: organization.id)) {
                                    ZStack {
                                        VStack {
                                            AsyncImage(url: organization.photo) { image in
                                                image.resizable()
                                                    .frame(height: 160)
                                                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 25.0, bottomLeadingRadius: 0.0, bottomTrailingRadius: 0.0, topTrailingRadius: 25.0))
                                            } placeholder: { ProgressView("Loading...") }
                                            
                                            HStack {
                                                Text(organization.name)
                                                    .lineLimit(1)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                
                                                FavoriteView(organization: organization, viewModel: viewModel)
                                            }
                                            
                                            HStack(spacing: 10) {
                                                HStack(spacing: 2) {
                                                    Image(systemName: "star.fill")
                                                    Text(String(format: "%.1f", organization.rate ?? 0.0))
                                                }
                                                
                                                if !organization.averageCheck.isEmpty {
                                                    Text("€\(organization.averageCheck.joined(separator: ","))")
                                                        .foregroundStyle(.gray)
                                                }
                                                
                                                Text("\(organization.cuisines.joined(separator: ","))")
                                                    .foregroundStyle(.gray)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding()
                                        .background(.white.opacity(0.6))
                                        .clipShape(RoundedRectangle(cornerRadius: 50))
                                    }
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                        }
                    }
                }
            }
            .background(.gray.opacity(0.1))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showFavorites.toggle()
                    } label: {
                        Image(systemName: "suit.heart.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.cyan)
                            .overlay {
                                Text("\(viewModel.favoriteCount)")
                                    .foregroundStyle(.white)
                                    .font(.caption2)
                            }
                    }
                }
            }
            .navigationTitle("Restaurants")
            .toolbarBackground(Color(.systemGray), for: .navigationBar)
            .onAppear {
                Task {
                    try await viewModel.getOrganizations()
                }
            }
        }
    }
}

#Preview {
    OrganizationsView()
}
