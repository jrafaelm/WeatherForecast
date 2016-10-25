//
//  City.swift
//  WeatherForecast
//
//  Created by Rafael Moraes on 24/10/16.
//  Copyright © 2016 Rafael Moraes. All rights reserved.
//

import UIKit

class City: NSObject {

    var name : String?
    var minTemperatureCelsius : Double?
    var maxTemperatureCelsius : Double?
    var weatherDescription : String?
    
    
    init(map: [String:Any]) {
        self.name = map["name"] as! String?
        if let mainInformation = map["main"] as? [String:Any]{
            self.minTemperatureCelsius = mainInformation["temp_min"] as? Double
            self.minTemperatureCelsius = self.minTemperatureCelsius! - 273.0
            self.maxTemperatureCelsius = mainInformation["temp_max"] as? Double
            self.maxTemperatureCelsius = self.maxTemperatureCelsius! - 273
        }
        if let weather = map["weather"] as? NSArray{
            if let firstWeather = weather[0] as? [String:Any]{
                self.weatherDescription = firstWeather["description"] as? String
            }
        }
    }
}
