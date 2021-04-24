//
//  navigationButton.swift
//  Money Manager
//
//  Created by Benjamin Bauten on 24/04/2021.
//

import SwiftUI

struct navigationButton: View {
    
    var imageName: String
    var text: String

    var body: some View {
        VStack{
            Image(systemName: imageName)
            Text(text)
        }
    }
}
