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
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            backgroundView(isNight: $isNight)
            VStack {
                
                cityTextView(cityName: weatherData.cityName)
                mainWeatherStatusView(weatherDataInScope: self.weatherData, currentTemperature: weatherData.currentTemperatureString, symbolName: weatherData.symbolName)
                
                HStack (spacing: 20){
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 24)
                    
                    WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 29)
                    
                    WeatherDayView(dayOfWeek: "THU", imageName: "cloud.bolt.rain.fill", temperature: 17)
                    
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 19)
                    
                    WeatherDayView(dayOfWeek: "SAT", imageName: "cloud.fog.fill", temperature: 18)
                }
                Spacer()
                
                Button{
                    weatherData.getWeatherData()
                        
                } label: {
                    WeatherButton(title: "Refresh Data", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
                Button{
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
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
    
    @Binding var isNight: Bool
    
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
    
    var body: some View{
        VStack(spacing: 10){
            Image(systemName: symbolName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text(currentTemperature)
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
                .onAppear{weatherDataInScope.getWeatherData()}
        }
        .padding(.bottom, 40)
    }
}
