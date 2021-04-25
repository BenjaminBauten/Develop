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
                totalBalanceView()
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
            Color("StandardBlue")
                .cornerRadius(15)
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


