//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Михаил Ганин on 19.05.2025.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var weather: WeatherModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol = NetworkService(apiKey: "46892d70b10e4628b82222745251605")) {
        self.weatherService = weatherService
    }
    
    func fetchWeather() {
        guard !city.isEmpty else {
            errorMessage = "Введите город"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let weather):
                    self?.weather = weather
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
