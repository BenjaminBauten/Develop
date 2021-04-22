//
//  ContentView.swift
//  Money Manager
//
//  Created by Benjamin Bauten on 22/04/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            headingView()
            lastMonthExpenseView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct headingView: View{
    var body: some View{
        ZStack(alignment: .leading){
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    Spacer()
                    Image("ProfileImage")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .leading)
                        .cornerRadius(25)
                    Spacer()
                    Text("Account Balance")
                        .foregroundColor(.white)
                        .font(.system(size: 13, weight: .medium))
                    Text("545.45€")
                        .foregroundColor(.white)
                        .font(.system(size: 25, weight: .medium))
                    Spacer()
                    
                }
            }.frame(height: 200, alignment: .top)
    }
}

struct lastMonthExpenseView: View {
    var body: some View{
        VStack{
            expenseList()
            expenseList()
            expenseList()
            expenseList()
            
        }
    }
}

struct expenseList: View {
    var body: some View{
        HStack{
            Image(systemName: "car.circle.fill")
                .resizable()
                .frame(width: 30, height: 30, alignment: .leading)
                .foregroundColor(.blue)
            Text("Taxi to Airport")
            Spacer()
            Text("-63.45")
            
        }
    }
}
