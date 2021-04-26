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
            ScrollView(showsIndicators: false){
                VStack{
                    totalBalanceView()
                    incomeAndExpenseView()
                    walletView()
                    recentTransactionsView()
                }
            }
            }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}

struct headingView: View{
    var body: some View{
        HStack{
            VStack(alignment: .leading, spacing: 5){
                Text("Good Morning,")
                    .foregroundColor(.gray)
                Text("Benjamin Bauten")
                    .font(.system(size: 20, weight: .bold))
                    
            }
            Spacer()
            Image(systemName: "bell.fill")
                .foregroundColor(.gray)
        }.padding()
    }
}

struct totalBalanceView: View{
    var body: some View{
        ZStack(alignment: .leading){
            Image("AccountBalanceBackground")
                .resizable()
            VStack(alignment: .leading){
                Text("$2,821.00")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold))
                Text("Total Balance")
                    .foregroundColor(.white)
            }.padding()
        }.frame(height: 90)
        .padding()
    }
}

struct incomeAndExpenseView: View {
    var body: some View{
        HStack(spacing: 15){
            Spacer()
            Image("BlueArrowDown")
                .resizable()
                .frame(width: 45, height: 45)
            VStack(alignment: .leading, spacing: 8){
                Text("Income")
                    .foregroundColor(.gray)
                Text("$460.00")
                    .font(.system(size: 17, weight: .bold))
            }
            Spacer()
            Image("OrangeArrowUp")
                .resizable()
                .frame(width: 45, height: 45)
            VStack(alignment: .leading, spacing: 8){
                Text("Expense")
                    .foregroundColor(.gray)
                Text("$231.00")
                    .font(.system(size: 17, weight: .bold))
            }
            Spacer()
        }.padding()
    }
}

struct walletView: View{
    var body: some View{
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text("Your Wallet")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Image(systemName: "plus")
                    .foregroundColor(Color("StandardBlue"))
                Text("Add New")
                    .foregroundColor(Color("StandardBlue"))
                    .font(.system(size: 15, weight: .bold))
            }
            Text("2 Budged, 1 Savings")
                .foregroundColor(.gray)
                .font(.system(size: 15))
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 15){
                    walletCard(ammount: "$45.00", typeOfAccount: "Food", imageName: "BlueCardBackground")
                    walletCard(ammount: "$150.00", typeOfAccount: "Clothing", imageName: "OrangeCardBackground")
                    walletCard(ammount: "$60.00", typeOfAccount: "Parking", imageName: "BlueCardBackground")
                }
            }
        }.padding()
    }
}

struct walletCard: View{
    var ammount: String
    var typeOfAccount: String
    var imageName: String
    var body: some View{
        ZStack(){
            Image(imageName)
                .cornerRadius(20)
            VStack(alignment: .leading, spacing: 10){
                Text(ammount)
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .bold))
                Text(typeOfAccount)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .bold))
            }.frame(width: 120, height: 150, alignment: .bottomLeading)
        }
    }
}

struct recentTransactionsView: View {
    var body: some View{
        VStack{
            HStack{
                Text("Recent Transactions")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
                Text("See All")
                    .foregroundColor(Color("StandardBlue"))
                    .font(.system(size: 15, weight: .bold))
            }
            VStack(){
                recentTransactionsRow()
                recentTransactionsRow()
                recentTransactionsRow()
            }
            .background(Color.white)
            .cornerRadius(15)
        }.padding()
    }
}

struct recentTransactionsRow: View{
    var body: some View{
        HStack{
            Image("FoodIcon")
                .resizable()
                .frame(width: 40, height: 40)
            Spacer()
            VStack(alignment: .leading){
                Text("Food & Beverage")
                HStack{
                    Text("Today")
                    Text("•")
                    Text("Makan Basko")
                }
                .foregroundColor(.gray)
            }
            Spacer()
            Text("-$15.00")
                .foregroundColor(.red)
                .font(.system(size: 15, weight: .bold))
        }.padding()
    }
}
