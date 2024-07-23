//
//  RaitingView.swift
//  TestTaskForIncetro
//
//  Created by Zorin Dmitrii on 22.07.2024.
//

import SwiftUI

struct RaitingView: View {
    
    let raiting: Double?
    
    private func starType(index: Int) -> String {
        
        if let raiting {
            return index <= Int(raiting) ? "star.fill" : "star"
        } else {
            return "star"
        }
    }
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: self.starType(index: index))
                    .foregroundStyle(.cyan)
            }
        }
    }
}

#Preview {
    RaitingView(raiting: 3)
}
