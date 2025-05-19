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
    
    private let apiKey = "46892d70b10e4628b82222745251605" // Замените на ваш ключ c cайта https://www.weatherapi.com
    
    func fetchWeather() {
        guard !city.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(encodedCity)&days=5&aqi=no&alerts=no"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Некорректный URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Ошибка: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "Нет данных в ответе"
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(WeatherModel.self, from: data)
                    self?.weather = response
                } catch {
                    self?.errorMessage = "Ошибка при обработке данных: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
