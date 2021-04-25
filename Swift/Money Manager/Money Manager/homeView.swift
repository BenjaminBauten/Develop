//
//  homeView.swift
//  Money Manager
//
//  Created by Benjamin Bauten on 25/04/2021.
//

import SwiftUI

struct homeView: View {
    var body: some View {
        ZStack{
            Color("LightGray")
                .edgesIgnoringSafeArea(.all)
            VStack{
                headingView()
                Spacer()
                Text("Last Month Expense")
                    .frame(width: 350, alignment: .leading)
                    .font(.headline)
                lastMonthExpenseView()
            }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}

struct lastMonthExpenseView: View {
    var body: some View{
        VStack{
            expenseList()
            Divider()
            expenseList()
            Divider()
            expenseList()
            Divider()
            expenseList()
            Group{Divider()
            expenseList()
            Divider()
            expenseList()
            }
        }
        .frame(width: 350, height: 480, alignment: .top)
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct headingView: View{
    var body: some View{
        ZStack(alignment: .leading){
            LinearGradient(gradient: Gradient(colors: [Color("DarkGreenHeader"), Color("LightGreenHeader")]), startPoint: .bottom, endPoint: .top)
                .edgesIgnoringSafeArea(.all)
            HStack(spacing: 20){
                Spacer()
                    .frame(width: 5)
                VStack(alignment: .leading){
                    Spacer()
                    Image("ProfileImage2")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .leading)
                        .cornerRadius(25)
                    Spacer()
                        .frame(height: 20)
                    Text("Account Balance")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                    Text("5456.45€")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .medium))
                    Spacer()
                    
                }
            }
        }.frame(height:190)
        
    }
}

struct expenseList: View {
    var body: some View{
        HStack{
            Image(systemName: "airplane.circle.fill")
                .resizable()
                .frame(width: 30, height: 30, alignment: .leading)
                .foregroundColor(.blue)
            Text("Taxi to Airport")
            Spacer()
            Text("-63.45")
            
        }.frame(width: 330, height: 50, alignment: .center)
    }
}
