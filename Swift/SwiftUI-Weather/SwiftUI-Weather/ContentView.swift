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
    
    var body: some View {
        ZStack {
            backgroundView(isNight: weatherData.isNight)
            VStack {
                
                cityTextView(cityName: weatherData.cityName)
                mainWeatherStatusView(weatherDataInScope: self.weatherData, currentTemperature: weatherData.currentTemperatureString, symbolName: weatherData.symbolName, weatherDescription: weatherData.weatherDescription, sunriseTime: weatherData.sunriseTime, sunsetTime: weatherData.sunsetTime, highestTemperature: weatherData.highestTemperature, lowestTemperature: weatherData.lowestTemperature)
                
                ScrollView(.horizontal){
                    HStack (spacing: 20){
                        WeatherDayView(dayOfWeek: weatherData.forecastTime[0], imageName: weatherData.forecastIcon[0], temperature: weatherData.forecastTemperature[0])
                        WeatherDayView(dayOfWeek: weatherData.forecastTime[1], imageName: weatherData.forecastIcon[1], temperature: weatherData.forecastTemperature[1])
                        WeatherDayView(dayOfWeek: weatherData.forecastTime[2], imageName: weatherData.forecastIcon[2], temperature: weatherData.forecastTemperature[2])
                        WeatherDayView(dayOfWeek: weatherData.forecastTime[3], imageName: weatherData.forecastIcon[3], temperature: weatherData.forecastTemperature[3])
                        WeatherDayView(dayOfWeek: weatherData.forecastTime[4], imageName: weatherData.forecastIcon[4], temperature: weatherData.forecastTemperature[4])
                        WeatherDayView(dayOfWeek: weatherData.forecastTime[5], imageName: weatherData.forecastIcon[5], temperature: weatherData.forecastTemperature[5])
                        WeatherDayView(dayOfWeek: weatherData.forecastTime[6], imageName: weatherData.forecastIcon[6], temperature: weatherData.forecastTemperature[6])
                        Group{
                            WeatherDayView(dayOfWeek: weatherData.forecastTime[7], imageName: weatherData.forecastIcon[7], temperature: weatherData.forecastTemperature[7])
                            WeatherDayView(dayOfWeek: weatherData.forecastTime[8], imageName: weatherData.forecastIcon[8], temperature: weatherData.forecastTemperature[8])
                            WeatherDayView(dayOfWeek: weatherData.forecastTime[9], imageName: weatherData.forecastIcon[9], temperature: weatherData.forecastTemperature[9])
                            WeatherDayView(dayOfWeek: weatherData.forecastTime[10], imageName: weatherData.forecastIcon[10], temperature: weatherData.forecastTemperature[10])
                            Group{
                                WeatherDayView(dayOfWeek: weatherData.forecastTime[11], imageName: weatherData.forecastIcon[11], temperature: weatherData.forecastTemperature[11])
                                WeatherDayView(dayOfWeek: weatherData.forecastTime[12], imageName: weatherData.forecastIcon[12], temperature: weatherData.forecastTemperature[12])
                                WeatherDayView(dayOfWeek: weatherData.forecastTime[13], imageName: weatherData.forecastIcon[13], temperature: weatherData.forecastTemperature[13])
                                WeatherDayView(dayOfWeek: weatherData.forecastTime[14], imageName: weatherData.forecastIcon[14], temperature: weatherData.forecastTemperature[14])
                                WeatherDayView(dayOfWeek: weatherData.forecastTime[15], imageName: weatherData.forecastIcon[15], temperature: weatherData.forecastTemperature[15])
                            }
                        }
                    }
                }
                Spacer()
                
                Button{
                    weatherData.getWeatherData()
                    weatherData.hourlyForecastWeatherData()
                        
                } label: {
                    WeatherButton(title: "Refresh Data", textColor: .blue, backgroundColor: .white)
                }
                Spacer()
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
                .frame(width: 40, height: 40)
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
                .frame(width: 160, height: 160)
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
                    .onAppear{weatherDataInScope.getWeatherData()
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
