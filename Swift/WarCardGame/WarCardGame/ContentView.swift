//
//  ContentView.swift
//  WarCArdGame
//
//  Created by Benjamin Bauten on 04/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var randNum1 = 1
    @State private var randNum2 = 1
    
    @State private var score1 = 0
    @State private var score2 = 0
    
    var body: some View {
        
        ZStack{
            
            Image("Background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                Spacer()
                
                Image("logo")
                
                Spacer()
                
                HStack{
                    Image("card" + String(randNum1))
                    Image("card" + String(randNum2))
                }
                
                Spacer()
                
                Button(action: {
                    self.randNum1 = Int.random(in: 2...14)
                    self.randNum2 = Int.random(in: 2...14)
                    
                    if self.randNum1 > self.randNum2 {
                        score1 += 1
                    }else if self.randNum2 > self.randNum1 {
                        score2 += 1
                    }
                    
                }) {
                    Image("dealbutton")
                        .renderingMode(.original)
                }
                
                Spacer()
                
                HStack{
                    VStack{
                        Text("Player")
                            .bold()
                            .padding(.bottom, 20)
                        Text(String(score1))
                    }
                    .padding(.leading, 20)
                    .foregroundColor(.white)
                    Spacer()
                    VStack{
                        Text("CPU")
                            .bold()
                            .padding(.bottom, 20)
                        Text(String(score2))
                    }
                    .padding(.trailing, 20)
                    .foregroundColor(.white)
                    
                }
                Spacer()
                
                Button(action: {
                    score1 = 0
                    score2 = 0
                    self.randNum1 = 1
                    self.randNum2 = 1
                }) {
                    Text("Start again")
                        .foregroundColor(.white)
                }
                .padding(14)
                .background(Color.black)
                .cornerRadius(10)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
