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
    
    func getWeatherData(){
        AF.request("https://api.openweathermap.org/data/2.5/weather?q=Witley&appid=1319104a3baa155478e1466e9bc73c7d&units=metric").responseJSON {
            response in

            let json = JSON(response.value!)
            print(json)
            let icon = json["weather"][0]["icon"].string!
            self.currentTemperatureString = String(Int((json["main"]["temp"].float!).rounded())) + "°"
            self.cityName = json["name"].string!
            
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
}


