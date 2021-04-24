//
//  ContentView.swift
//  Money Manager
//
//  Created by Benjamin Bauten on 22/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ State var index = 1
    
    var body: some View {
        ZStack{
            Color("LightGray")
                    .edgesIgnoringSafeArea(.all)
            VStack{
                if index == 1 {
                headingView()
                Spacer()
                Text("Last Month Expense")
                    .frame(width: 350, alignment: .leading)
                    .font(.headline)
                lastMonthExpenseView()
                } else if index == 0 {
                    headingView()
                } else {
                    lastMonthExpenseView()
                }
                Spacer()
                navigationBar(index: self.$index)
            }.edgesIgnoringSafeArea(.bottom)
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

struct navigationBar: View {
     
    @Binding var index : Int
    
    var body: some View{
        VStack(spacing: 0){
                HStack{
                    Spacer()
                    Button{
                        self.index = 0
                    } label: {
                    navigationButton(imageName: "creditcard", text: "Spend")
                        .foregroundColor(self.index == 0 ? Color("DarkGreenHeader") : Color.black)
                        .frame(width: 50)
                    }
                    Spacer()
                    Button{
                        self.index = 1
                    } label: {
                    navigationButton(imageName: "house", text: "Home")
                        .foregroundColor(self.index == 1 ? Color("DarkGreenHeader") : Color.black)
                        .frame(width: 50)
                    }
                    Spacer()
                    Button{
                        self.index = 2
                    } label: {
                        navigationButton(imageName: "heart", text: "Save")
                            .foregroundColor(self.index == 2 ? Color("DarkGreenHeader") : Color.black)
                            .frame(width: 50)
                    }
                    Spacer()
                }
                .frame(height: 90)
                .background(Color.white)
            }
    }
}
