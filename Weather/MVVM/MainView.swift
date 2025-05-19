//
//  mainView.swift
//  Weather
//
//  Created by Михаил Ганин on 17.05.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Введите город", text: $viewModel.city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: viewModel.fetchWeather) {
                    Text("Получить прогноз")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .disabled(viewModel.city.isEmpty || viewModel.isLoading)
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else if let weather = viewModel.weather {
                    WeatherView(weather: weather)
                }
                
                Spacer()
            }
            .navigationTitle("Прогноз погоды")
            .padding()
        }
    }
}

#Preview {
    MainView()
}
