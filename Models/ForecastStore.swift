//
//  ForecastStore.swift
//  HeavyRain4
//
//  Created by Edward L Richardson on 8/22/18.
//  Copyright © 2018 Edward L Richardson. All rights reserved.
//

import Foundation
import UIKit

class ForecastStore {
    public static let instance:ForecastStore = ForecastStore ()
    enum LoadingError {
        case invalidCity
        case noConnection
        case invalidURL
        case wrongResponse
    }
    static let WEATHER_API = "https://api.openweathermap.org/data/2.5/weather"
    static let WEATHER_API_QUERY = "?appid=0356f0d8e9865300021b8b2ba08ee811cb&units=imperial"
    
    private init(){
        print("initialization goes here")
    }
    
    public func loadForecast(for city: City, callback: @escaping (_ response:WeatherResponse?, _ error:LoadingError?)->()) {
        guard let cityId = city.id else {
            callback(nil, LoadingError.invalidCity)
            return
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let urlString = ForecastStore.WEATHER_API
            + ForecastStore.WEATHER_API_QUERY + "&id=" + String(describing: cityId)
        print(urlString)
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data, response, error) in
                if let _ = error {
                    callback(nil, LoadingError.wrongResponse)
                } else {
                    guard let data = data else {
                        callback(nil, LoadingError.wrongResponse)
                        return
                    }
                    do {
                        //debug
                        let rawData = String(data: data, encoding: String.Encoding.utf8)
                        print(rawData)
                        
                        let decoder = JSONDecoder()
                        let responseModel = try decoder.decode(WeatherResponse.self, from: data)
                        print(responseModel.name)
                        callback(responseModel, nil)
                    } catch let err {
                        print("Error", err)
                        callback(nil, LoadingError.wrongResponse)
                    }
                }
            }
            task.resume()
        }
    }
}
