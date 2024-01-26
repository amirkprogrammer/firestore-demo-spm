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
                
                HStack {
                    Text(item.name)
                    
                    Spacer()
                    
                    // update button
                    Button {
                        // update todo
                        model.updateData(todoToUpdate: item)
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .buttonStyle(.borderless)
                    
                    // delete button
                    Button {
                        // delete todo
                        model.deleteData(todoToDelete: item)
                    } label: {
                        Image(systemName: "minus.circle")
                    }
                    .buttonStyle(.borderless)
                }
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
