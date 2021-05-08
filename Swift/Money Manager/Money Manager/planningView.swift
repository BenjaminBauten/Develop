//
//  planningView.swift
//  Money Manager
//
//  Created by Benjamin Bauten on 25/04/2021.
//

import SwiftUI

struct planningView: View {
    var body: some View {
        ZStack{
            Color("LightGray")
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Planning")
                    .font(.system(size: 27, weight: .bold))
                    .padding()
                ScrollView(showsIndicators: false){
                    VStack{
                        walletView()
                        savingsView()
                        budgetView()
                    }
                }
            }
        }
        
    }
}

struct planningView_Previews: PreviewProvider {
    static var previews: some View {
        planningView()
    }
}

struct savingsView: View{
    var body: some View{
        VStack{
            HStack{
                Text("Savings")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Image(systemName: "plus")
                    .foregroundColor(Color("StandardBlue"))
                Text("Add New")
                    .foregroundColor(Color("StandardBlue"))
                    .font(.system(size: 15, weight: .bold))
            }
            savingsAndBudgetCards(title: "Iphone 12 Pro", ammount: "$985.00")
            savingsAndBudgetCards(title: "Nike Air Force 1", ammount: "$100.00")
        }.padding()
    }
}

struct budgetView: View{
    var body: some View{
        VStack{
            HStack{
                Text("Budget")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Image(systemName: "plus")
                    .foregroundColor(Color("StandardBlue"))
                Text("Add New")
                    .foregroundColor(Color("StandardBlue"))
                    .font(.system(size: 15, weight: .bold))
            }
            savingsAndBudgetCards(title: "Food & Beverage", ammount: "$125.00")
            savingsAndBudgetCards(title: "Medicine", ammount: "$200.00")
        }.padding()
    }
}
struct savingsAndBudgetCards: View{
    @State var progressValue: Float = 0.6
    var title: String
    var ammount: String
    var body: some View{
        HStack(spacing: 15){
            Image(systemName: "bag")
                .resizable()
                .frame(width: 29, height: 32, alignment: .center)
                .foregroundColor(Color("StandardBlue"))
            VStack{
                HStack(alignment: .top){
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                    Text(ammount)
                        .font(.system(size: 16, weight: .semibold))
                }
                progressBar(value: $progressValue).frame(height: 6)
            }.padding(10)
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(15)
    }
}

struct progressBar: View{
    @Binding var value: Float
        
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color("StandardBlue"))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color("StandardBlue"))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}


