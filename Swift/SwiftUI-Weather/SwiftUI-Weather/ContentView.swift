//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Benjamin Bauten on 22/02/2021.
//

import SwiftUI
import SwiftyJSON
import Alamofire

struct ContentView: View {
    
    @ObservedObject private var weatherData = WeatherData()
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            backgroundView(isNight: weatherData.isNight)
            VStack {
                
                cityTextView(cityName: weatherData.cityName)
                mainWeatherStatusView(weatherDataInScope: self.weatherData, currentTemperature: weatherData.currentTemperatureString, symbolName: weatherData.symbolName, weatherDescription: weatherData.weatherDescription, sunriseTime: weatherData.sunriseTime, sunsetTime: weatherData.sunsetTime, highestTemperature: weatherData.highestTemperature, lowestTemperature: weatherData.lowestTemperature)
                Divider()
                    .frame(height: 1)
                    .background(Color.white)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack (spacing: 20){
                        Spacer()
                        ForEach(weatherData.forecastTime.indices){ i in
                            WeatherDayView(dayOfWeek: weatherData.forecastTime[i], imageName: weatherData.forecastIcon[i], temperature: weatherData.forecastTemperature[i])
                        }
                        Spacer()
                    }
                }
                Divider()
                    .frame(height: 1)
                    .background(Color.white)
                VStack{
                    HStack{
                        informationView(variableName: "HUMIDITY", variable: weatherData.humidity)
                        Spacer()
                        informationView(variableName: "FEELS LIKE", variable: weatherData.feelsLike)
                        Spacer()
                    }
                    Divider()
                        .frame(height: 1.0)
                        .background(Color.white)
                    HStack{
                        informationView(variableName: "PRESSURE", variable: weatherData.pressure)
                        Spacer()
                        informationView(variableName: "WIND", variable: weatherData.windSpeed)
                        Spacer()
                    }
                    Divider()
                        .frame(height: 1.0)
                        .background(Color.white)
                }
//                locationDataView()
                Spacer()
                
                Button{
//                    locationManager.convertCoordinatesToPostCode()
                    weatherData.getWeatherData()
                    weatherData.hourlyForecastWeatherData()
                        
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 25)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 25)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}

struct backgroundView: View {
    
    var isNight: Bool
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct cityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct mainWeatherStatusView: View {
    
//    var locationManagerInScope: LocationManager
    var weatherDataInScope: WeatherData
    var currentTemperature: String
    var symbolName: String
    var weatherDescription: String
    var sunriseTime: String
    var sunsetTime: String
    var highestTemperature: String
    var lowestTemperature: String
    
    var body: some View{
        VStack(spacing: 10){
            Text(weatherDescription)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium))
            Image(systemName: symbolName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 140)
            HStack{
                Spacer()
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "sunrise")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        Text(sunriseTime)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                    HStack{
                        Image(systemName: "sunset")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                        Text(sunsetTime)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                }.frame(width: 100, height: 50, alignment: .center)
                Spacer()
                Text(currentTemperature)
                    .font(.system(size: 70, weight: .medium))
                    .foregroundColor(.white)
                    .onAppear{//locationManagerInScope.convertCoordinatesToPostCode()
                        weatherDataInScope.getWeatherData()
                        weatherDataInScope.hourlyForecastWeatherData()}
                Spacer()
                VStack(alignment: .leading){
                    Text(lowestTemperature)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    Text(highestTemperature)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }.frame(width: 100, height: 50, alignment: .center)
                Spacer()
            }
        }
        .padding(.bottom, 40)
    }
}
struct informationView: View {
    
    var variableName: String
    var variable: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(variableName)
                .font(.system(size: 14, weight: .medium, design: .default))
                .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.63))
                .padding()
                .frame(height: 10)
            Text(variable)
                .font(.system(size: 22, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding()
                .frame(height: 20)
        }.frame(width: 130, alignment: .leading)
    }
}

//struct locationDataView: View {
//
//    @StateObject var locationManager = LocationManager()
//
//        var userLatitude: String {
//            return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
//        }
//
//        var userLongitude: String {
//            return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
//        }
//
//        var body: some View {
//            VStack {
//                Text("location status: \(locationManager.statusString)")
//                HStack {
//                    Text("latitude: \(userLatitude)")
//                    Text("longitude: \(userLongitude)")
//                }
//            }
//        }
//}
