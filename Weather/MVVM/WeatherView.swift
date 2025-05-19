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
            VStack(alignment: .leading, spacing: 20) {
                // Текущая погода
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(weather.current?.condition?.text ?? "")
                        }
                    }
                    ForEach(Array((weather.forecast?.forecastday ?? []).enumerated()), id: \.offset) { (offset, day) in
                        VStack(alignment: .leading) {
                            Text(getDayName(offset: offset))
                                .font(.headline)
                            
                            if let dayData = day.day {
                                Text("Температура - \(dayData.avgtemp_c?.formatted() ?? "N/A")°C")
                                Text("Ветер - \(dayData.maxwind_kph?.formatted() ?? "N/A")")
                                Text("Влажность - \(dayData.avghumidity?.formatted() ?? "N/A")")
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    private func getDayName(offset: Int) -> String {
        switch offset {
        case 0: return "Сегодня"
        case 1: return "Завтра"
        default:
            let date = Calendar.current.date(byAdding: .day, value: offset, to: Date())!
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter.string(from: date)
        }
    }
}
