//
//  ViewController.swift
//  HeavyRain4
//
//  Created by Edward L Richardson on 8/20/18.
//  Copyright © 2018 Edward L Richardson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model: LocationForecast?
    
    //details outlet
    @IBOutlet weak var details: UICollectionView!
    @IBOutlet weak var nextDays: UITableView!
    
    var forecast : [Forecast] = []
    var degreeSymbol = "°"
    
    let collectionViewFormatter = DateFormatter()
    let tableViewFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //fill the model with mock data
        model = LocationForecast.getTestData()
        
        collectionViewFormatter.dateFormat = "H:mm"
        tableViewFormatter.dateFormat = "EEEE"
        
        //out class implements the correct protocols in extensions
        details.dataSource = self
        nextDays.dataSource = self
    }
    
    // MARK: Helper function
    
    func getCurrentTemperature() -> String {
        var lastTemperature = "?"
        if let forecastList = model?.forecastForToday {
            let currentDate = Date()
            
            for forecast in forecastList {
                if forecast.date < currentDate {
                    lastTemperature = "\(forecast.temperature)"
                }
            }
        }
        
        return lastTemperature
    }
    
    //Mark: private
    fileprivate func getIcon(weather: String) -> UIImage? {
        return nil 
    }
    
    @IBAction func onFavoritesClicked(_ sender:  Any)  {
        performSegue(withIdentifier: "showFavorites",
            sender: sender)
    }
}
extension ViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.forecastForToday?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:WeatherViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherViewCell
        
        let forecast:Forecast = (model?.forecastForToday?[indexPath.row])!
        
        cell.time.text = collectionViewFormatter.string(from: forecast.date)
        cell.icon.image =  getIcon(weather: forecast.weather)
        cell.temperature?.text = "\(forecast.temperature)\(self.degreeSymbol)"
        
        return cell
        
    }
}
extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.forecastForNextDays?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DailyForecastViewCell = tableView.dequeueReusableCell(withIdentifier: "FullDayWeatherCell", for: indexPath) as! DailyForecastViewCell
        
        let forecast:DailyForecast = (model?.forecastForNextDays?[indexPath.row])!
        
        cell.day.text = tableViewFormatter.string(from: forecast.date)
        cell.icon.image =  getIcon(weather: forecast.weather)
        cell.temperature.text = "\(forecast.maxTemp)\(self.degreeSymbol)/\(forecast.minTemp)\(self.degreeSymbol)"
        
        return cell
    }
}
    

  




