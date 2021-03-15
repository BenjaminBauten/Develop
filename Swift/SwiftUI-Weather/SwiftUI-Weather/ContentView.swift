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
    
    @State private var isNight = false
    @State private var currentTemperature : Int = 1
    
    var body: some View {
        ZStack {
            backgroundView(isNight: $isNight)
            VStack {
                
                cityTextView(cityName: "Kevelaer")
                
                mainWeatherStatusView(currentTemperature: $currentTemperature, imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill")
                
                HStack (spacing: 20){
                    WeatherDayView(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 24)
                    
                    WeatherDayView(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 29)
                    
                    WeatherDayView(dayOfWeek: "THU", imageName: "cloud.bolt.rain.fill", temperature: 17)
                    
                    WeatherDayView(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 19)
                    
                    WeatherDayView(dayOfWeek: "SAT", imageName: "cloud.fog.fill", temperature: 18)
                }
                Spacer()
                
                Button{
                    AF.request("https://api.openweathermap.org/data/2.5/weather?q=Kevelaer&appid=1319104a3baa155478e1466e9bc73c7d&units=metric").responseJSON {
                        response in
                        
                        let json = JSON(response.value!)
                        print(json)
//                        let y = json["base"].string
//                        let z = json["name"].string
//                        let a = json["main"]["humidity"].float
                        currentTemperature = Int((json["main"]["temp"].float!).rounded())
//                        currentTemperature = temp
                        }
                        
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
    
    @Binding var currentTemperature: Int
    
    var imageName: String
    
    var body: some View{
        VStack(spacing: 10){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(currentTemperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
