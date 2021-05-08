//
//  addEntryView.swift
//  Money Manager
//
//  Created by Benjamin Bauten on 24/04/2021.
//

import SwiftUI

struct addEntryView: View {
    var body: some View{
        VStack{
            Text("Add Entry")
            entryList()
        }
    }
}

struct addEntryView_Previews: PreviewProvider {
    static var previews: some View {
        addEntryView()
    }
}

struct entryList: View{
    @State private var date = Date()
    let accounts = [
        "Cash",
        "DKB",
        "MasterCard"
    ]
    var body: some View {
        Form{
            DatePicker("Date", selection: $date, in: ...Date(), displayedComponents: .date)
            Text("Account")
            Text("Category")
            Text("Amount")
            Text("Note")
            Text("Description")
            
        }
    }
}
