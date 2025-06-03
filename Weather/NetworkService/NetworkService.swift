//
//  NetworkService.swift
//  Weather
//
//  Created by Михаил Ганин on 03.06.2025.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

class NetworkService: WeatherServiceProtocol {
    private let apiKey: String
    private let baseURL = "https://api.weatherapi.com/v1"
    private let urlSession: URLSession
    
    init(apiKey: String, urlSession: URLSession = .shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        guard !city.isEmpty else {
            return
        }
        
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)/forecast.json?key=\(apiKey)&q=\(encodedCity)&days=5&aqi=no&alerts=no"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(WeatherModel.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
