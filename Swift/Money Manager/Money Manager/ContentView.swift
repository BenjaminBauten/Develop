//
//  ContentView.swift
//  Money Manager
//
//  Created by Benjamin Bauten on 22/04/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        navigationBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct navigationBar: View {
    var body: some View {
        TabView{
        homeView()
            .tabItem{
                Image(systemName: "house")
            }
        statisticsView()
            .tabItem{
                Image(systemName: "chart.bar.xaxis")
            }
        addEntryView()
            .tabItem {
                Image("PlusIcon")
                    .resizable()
                
            }
        planningView()
            .tabItem{
                Image(systemName: "creditcard")
            }
        settingsView()
            .tabItem {
                Image(systemName: "person")
            }
        }
        .accentColor(Color("StandardBlue"))
        .background(Color.white)
    }
}
