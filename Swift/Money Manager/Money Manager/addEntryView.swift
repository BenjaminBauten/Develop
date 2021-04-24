//
//  addEntryView.swift
//  Money Manager
//
//  Created by Benjamin Bauten on 24/04/2021.
//

import SwiftUI

struct addEntryView: View {
    @State private var date = Date()
    var body: some View {
        Form{
            DatePicker("Date", selection: $date, in: ...Date(), displayedComponents: .date)
            
        }
    }
}

struct addEntryView_Previews: PreviewProvider {
    static var previews: some View {
        addEntryView()
    }
}
