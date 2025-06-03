//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by Михаил Ганин on 03.06.2025.
//

import SwiftUI

struct CurrentWeatherView: View {
    let current: Current
    let location: Location
    
    var body: some View {
        VStack(spacing: 8) {
            VStack {
                Text(location.name ?? "Неизвестное место")
                    .font(.title.bold())
                
                if let region = location.region, let country = location.country {
                    Text("\(region), \(country)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            if let condition = current.condition {
                HStack(alignment: .center, spacing: 16) {
                    if let icon = condition.icon {
                        AsyncImage(url: URL(string: "https:\(icon)")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                    }
                    
                    VStack(alignment: .leading) {
                        if let text = condition.text {
                            Text(text)
                                .font(.headline)
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
