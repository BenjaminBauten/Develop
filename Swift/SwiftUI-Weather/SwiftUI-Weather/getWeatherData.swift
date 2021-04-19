//
//  getWeatherData.swift
//  SwiftUI-Weather
//
//  Created by Benjamin Bauten on 23/03/2021.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

class WeatherData: ObservableObject {
    
    @ObservedObject private var locationManager = LocationManager()
    
    @Published var symbolName: String = ""
    @Published var currentTemperatureString: String = "--"
    @Published var cityName: String = ""
    @Published var weatherDescription: String = ""
    @Published var isNight = false
    @Published var sunriseTime: String = ""
    @Published var sunsetTime: String = ""
    @Published var highestTemperature: String = "--"
    @Published var lowestTemperature: String = "--"
    
    @Published var forecastTemperature: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @Published var forecastIcon: [String] = ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-",]
    @Published var forecastTime: [String] = ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-",]
    
    @Published var humidity: String = ""
    @Published var feelsLike: String = ""
    @Published var pressure: String = ""
    @Published var windSpeed: String = ""
    
//    @State var cityNameInScope:String = "Kevelaer"
    @State var language:String = "de"
    
    func getWeatherData(){
        
        let localLanguage = Locale.current.languageCode!
        print(localLanguage)
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=" + String(locationManager.lastLocation!.coordinate.latitude) +
                   "&lon=" + String(locationManager.lastLocation!.coordinate.longitude) + "&lang=" + localLanguage + "&appid=1319104a3baa155478e1466e9bc73c7d&units=metric").responseJSON {
            response in
            let json = JSON(response.value!)
            let icon = json["weather"][0]["icon"].string!
            self.currentTemperatureString = String(Int((json["main"]["temp"].float!).rounded())) + "°"
            self.cityName = json["name"].string!
            self.weatherDescription = json["weather"][0]["description"].string ?? "not found"
            let sunriseTime = json["sys"]["sunrise"].int!
            let sunsetTime = json["sys"]["sunset"].int!
            let currentTime = Int(NSDate().timeIntervalSince1970)
            self.highestTemperature = "H:" + String(Int((json["main"]["temp_max"].float!).rounded())) + "°"
            self.lowestTemperature = "L:" + String(Int((json["main"]["temp_min"].float!).rounded())) + "°"
            
            self.sunriseTime = self.convertUnixTimeToString(unixTime: Double(sunriseTime))
            self.sunsetTime = self.convertUnixTimeToString(unixTime: Double(sunsetTime))
            self.isNight = !(currentTime > sunriseTime && currentTime < sunsetTime)
            self.symbolName = self.convertSymbolName(icon: icon)
            
            self.humidity = String(json["main"]["humidity"].int!) + " %"
            self.windSpeed = String(Int((json["wind"]["speed"].float!).rounded())) + " km/h"
            self.pressure = String(json["main"]["pressure"].int!) + " hPa"
            self.feelsLike = String(Int((json["main"]["feels_like"].float!).rounded())) + "°"
        }
    }
    
    func hourlyForecastWeatherData(){
        AF.request("https://api.openweathermap.org/data/2.5/forecast?lat=" + String(locationManager.lastLocation!.coordinate.latitude) +
                    "&lon=" + String(locationManager.lastLocation!.coordinate.longitude) +  "&units=metric&appid=ca929c7fbdc1623d4837fb863f9853e0").responseJSON {
            response in
            
            let json = JSON(response.value!)
//            print(json)
            let list = json["list"]
            var icons = Array<String>()
            var time = Array<String>()
            var temperature = Array<Int>()
            
            
            for counter in 0...15 {
                
                icons += [self.convertSymbolName(icon: list[counter]["weather"][0]["icon"].string!)]
                time += [self.convertUnixTimeToString(unixTime: Double(list[counter]["dt"].int!))]
                temperature += [Int((list[counter]["main"]["temp_max"].float!).rounded())]
                
            }
//            print(icons)
//            print(time)
//            print(temperature)
            self.forecastIcon = icons
            self.forecastTime = time
            self.forecastTemperature = temperature
        }
    }
       
    
    func convertUnixTimeToString(unixTime: Double) -> String {
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func convertSymbolName(icon: String) -> String{
        var symbolName: String = ""
        if icon == "04n" || icon == "04d" {
            symbolName = "cloud.fill"
        } else if icon == "09d" || icon == "09n"{
            symbolName = "cloud.heavyrain.fill"
        } else if icon == "13d" || icon == "13n"{
            symbolName = "cloud.snow.fill"
        } else if icon == "50d" || icon == "50n"{
            symbolName = "clod.fog.fill"
        } else if icon == "01d" {
            symbolName = "sun.max.fill"
        } else if icon == "01n"{
            symbolName = "moon.stars.fill"
        } else if icon == "02d" || icon == "03d"{
            symbolName = "cloud.sun.fill"
        } else if icon == "02n" || icon == "03n"{
            symbolName = "cloud.moon.fill"
        } else if icon == "10d"{
            symbolName = "cloud.sun.rain.fill"
        } else if icon == "10n"{
            symbolName = "cloud.moon.rain.fill"
        } else if icon == "11d"{
            symbolName = "cloud.sun.bolt.fill"
        } else if icon == "11n"{
            symbolName = "cloud.moon.bolt.fill"
        } else{
            symbolName = "wifi.exclamationmark"
        }
        return symbolName
    }
}
