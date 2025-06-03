//
//  ForecastDayView.swift
//  Weather
//
//  Created by Михаил Ганин on 03.06.2025.
//

import SwiftUI

struct ForecastDayView: View {
    let day: Day
    let date: String?
    let offset: Int
    
    var body: some View {
        HStack {
            Text(getDayName(offset: offset))
                .font(.headline)
                .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            Text("\(Int(day.avgtemp_c ?? 0))°")
                .font(.system(size: 18, weight: .bold))
                .frame(width: 50)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("Ветер: \(Int(day.maxwind_kph ?? 0)) км/ч")
                    .font(.caption)
                Text("Влажность: \(day.avghumidity ?? 0)%")
                    .font(.caption)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
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
