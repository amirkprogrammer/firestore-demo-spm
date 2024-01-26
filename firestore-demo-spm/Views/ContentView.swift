//
//  ContentView.swift
//  firestore-demo-spm
//
//  Created by Amir Kabiri on 1/24/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ViewModel()
    
    @State var name = ""
    @State var notes = ""
    
    var body: some View {
        
        VStack {
            List(model.list) { item in
                Text(item.name)
            }
            .listStyle(.inset)
            
            Divider()
            
            VStack(spacing: 5) {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Notes", text: $notes)
                    .textFieldStyle(.roundedBorder)
                
                
                Button {
                    
                    // call add data
                    model.addData(name: name, notes: notes)
                    
                    // clear the text fields
                    name = ""
                    notes = ""
                    
                } label: {
                    Text("Add Todo Item")
                }
            }
        }
        .padding()
    }
    
    init() {
        model.getData()
    }
}

#Preview {
    ContentView()
}
