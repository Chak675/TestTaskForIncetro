//
//  OrganizationDetailView.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 18.07.2024.
//

import SwiftUI

struct OrganizationDetailView: View {
    
    let organizationID: Int
    
    @StateObject var viewDetail = OrganizationDetailViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
            ZStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewDetail.organizationsDetail.photos, id: \.self) { photo in
                                AsyncImage(url: photo) { image in
                                    image.resizable()
                                        .frame(width: 430, height: 250)
                                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 25.0, bottomLeadingRadius: 0.0, bottomTrailingRadius: 0.0, topTrailingRadius: 25.0))
                                    
//                                    struct ContentView: View {
//                                        
//                                        var body: some View {
//                                            NavigationStack {
//                                                ScrollView(.horizontal) {
//                                                    HStack {
//                                                        ForEach(1...5, id: \.self) { index in
//                                                            Text("Index \(index)")
//                                                            .frame(width: 430, height: 250)
//                                                            .background(.yellow)
//                                                        }
//                                                    }
//                                                }
//                                                .scrollIndicators(.hidden)
//                                            }
//                                        }
//                                    }

                                    
                                    
                                } placeholder: { ProgressView("Loading...") }
                            }
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 220)
//                            .background(.white.opacity(0.6))
//                            .clipShape(RoundedRectangle(cornerRadius: 50))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(.white.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                    VStack {
                        HStack {
                            Text(viewDetail.organizationsDetail.name)
                                .lineLimit(1)
                                .padding(.leading)
                            
                            Spacer()
                            
                            Image(systemName: "suit.heart")
                                .foregroundStyle(.blue)
                                .padding(.trailing)
                        }
                        
                        HStack(spacing: 10) {
                            RaitingView(raiting: viewDetail.rating)
                            Text(String(format: "%.1f", viewDetail.rating))
                            
                        }
                            .padding(.leading)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
//                    .frame(height: 220)
                    .background(.white.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                    Spacer()
                    
                VStack {
                    Text("Описание: Рестора́н (от лат. restauro «восстановить, крепить») — предприятие общественного питания с широким ассортиментом блюд сложного приготовления, включая заказные и фирменные. Блюда, как правило, подаются и съедаются на месте в ресторане, но многие рестораны также предлагают блюда навынос и доставку еды, а некоторые предлагают только вынос и доставку. Рестораны сильно различаются по внешнему виду и предложениям, включая большое разнообразие кухонь и видов обслуживания, от недорогих «ресторанов» быстрого питания до семейных ресторанов со средней ценой и дорогих заведений класса люкс.В западных странах в большинстве ресторанов среднего и высокого класса подают алкогольные напитки, такие как пиво и вино. В некоторых ресторанах подают все основные блюда, такие как завтрак, обед и ужин (например, крупные сети быстрого питания, закусочные, гостиничные рестораны и рестораны в аэропортах). В других ресторанах еда может быть подана только один раз (например, в блинных ресторанах может быть только завтрак), или они могут подавать еду два раза за день (например, обед и ужин). Владелец ресторанного бизнеса называется ресторатором; оба слова произошли от французского глагола restaurer «восстанавливать, укреплять; кормить». Restaurant в американском английском — любое предприятие общепита вообще, а не только ресторан в привычном смысле.")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.white.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 50))
            }
            .background(.gray.opacity(0.1))
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Favorite", systemImage: "suit.heart") {
                        //systemImage: "suit.heart.fill"
                    }
                    .navigationTitle("Restaurants")
                    .toolbarBackground(Color(.systemGray), for: .navigationBar)
                    
                }
            }
            .onAppear {
                Task {
                    try await viewDetail.getOrganizationsDetail(id: organizationID)
                }
            }
            }
        }
    }


#Preview {
    OrganizationDetailView(organizationID: 2365)
}
