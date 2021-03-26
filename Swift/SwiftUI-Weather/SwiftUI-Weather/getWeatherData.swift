//
//  getWeatherData.swift
//  SwiftUI-Weather
//
//  Created by Benjamin Bauten on 23/03/2021.
//

import SwiftUI
import SwiftyJSON
import Alamofire

class WeatherData: ObservableObject {
    
    @Published var symbolName: String = ""
    @Published var currentTemperatureString: String = "--"
    @Published var cityName: String = ""
    @Published var weatherDescription: String = ""
    @Published var isNight = false
    @Published var sunriseTime: String = ""
    @Published var sunsetTime: String = ""
    @Published var highestTemperature: String = "--"
    @Published var lowestTemperature: String = "--"
    
    func getWeatherData(){
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=Kevelaer&appid=1319104a3baa155478e1466e9bc73c7d&units=metric").responseJSON {
            response in

            let json = JSON(response.value!)
            print(json)
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
            
            if icon == "03d" || icon == "03n" || icon == "04n" || icon == "04d" {
                self.symbolName = "cloud.fill"
            } else if icon == "09d" || icon == "09n"{
                self.symbolName = "cloud.heavyrain.fill"
            } else if icon == "13d" || icon == "13n"{
                self.symbolName = "cloud.snow.fill"
            } else if icon == "50d" || icon == "50n"{
                self.symbolName = "clod.fog.fill"
            } else if icon == "01d" {
                self.symbolName = "sun.max.fill"
            } else if icon == "01n"{
                self.symbolName = "moon.fill"
            } else if icon == "02d"{
                self.symbolName = "cloud.sun.fill"
            } else if icon == "02n"{
                self.symbolName = "cloud.moon.fill"
            } else if icon == "10d"{
                self.symbolName = "cloud.sun.rain.fill"
            } else if icon == "10n"{
                self.symbolName = "cloud.moon.rain.fill"
            } else if icon == "11d"{
                self.symbolName = "cloud.sun.bolt.fill"
            } else if icon == "11n"{
                self.symbolName = "cloud.moon.bolt.fill"
            } else{
                self.symbolName = "wifi.exclamationmark"
            }
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
}


