//
//  LocationsForecast.swift
//  HeavyRain4
//
//  Created by Edward L Richardson on 8/20/18.
//  Copyright © 2018 Edward L Richardson. All rights reserved.
//

import Foundation
import UIKit

public struct Location {
    var name: String
}

public class Forecast {
    var date:Date
    var weather: String = "undefined"
    var temperature = 100
    public init(date:Date, weather: String, temperature: Int)  {
        self.date = date
        self.weather = weather
        self.temperature = temperature
    }
}

public class DailyForecast : Forecast {
    var isWholeDay = false
    var minTemp = -100
    var maxTemp = 100
}

public class LocationForecast {
    var location:Location?
    var weather: String?
    var forecastForToday: [Forecast]?
    var forecastForNextDays: [DailyForecast]?
    
    //create dummy data, to render it in the UI
    static func getTestData () -> LocationForecast {
        let aMinute = 60
        let location = Location(name: "New York")
        let forecast  = LocationForecast()
        forecast.location = location
        forecast.weather = "Sunny"
        
        //today
        let today = Date().midnight 
        var detailedForecast : [Forecast] = []
        
        for i in 0...23 {
            detailedForecast.append(Forecast (date: today.addingTimeInterval (TimeInterval ( 60 * aMinute * i)), weather: "Sunny", temperature: 25))
        }
        forecast.forecastForToday = detailedForecast
        
        let tomorrow = DailyForecast(date: today.tomorrow, weather: "Sunny", temperature: 25)
        tomorrow.isWholeDay = true
        tomorrow.minTemp = 23
        tomorrow.maxTemp = 27
        
        let afterTomorrow =  DailyForecast (date: tomorrow.date.tomorrow, weather: "Sunny", temperature: 25)
        afterTomorrow.isWholeDay = true
        afterTomorrow.minTemp = 24
        afterTomorrow.maxTemp = 28
        forecast.forecastForNextDays = [tomorrow, afterTomorrow]
        return forecast 
    }
}

extension Date {
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var midnight: Date {
        let cal = Calendar(identifier: .gregorian)
        return cal.startOfDay(for: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
