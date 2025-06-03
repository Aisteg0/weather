//
//  WeatherView.swift
//  Weather
//
//  Created by Михаил Ганин on 19.05.2025.
//

import SwiftUI

struct WeatherView: View {
    let weather: WeatherModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let current = weather.current, let location = weather.location {
                    CurrentWeatherView(current: current, location: location)
                }
                
                if let forecastDays = weather.forecast?.forecastday {
                    VStack(spacing: 12) {
                        Text("Прогноз на \(forecastDays.count) дней")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        ForEach(Array((weather.forecast?.forecastday ?? []).enumerated()), id: \.offset) { (offset, day) in
                            if let dayData = day.day {
                                ForecastDayView(day: dayData, date: forecastDays.firstIndex(where: { $0.id == day.id }) == 0 ? "Сегодня" : nil, offset: offset)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }
}
