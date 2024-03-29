//
//  ViewModel.swift
//  firestore-demo-spm
//
//  Created by Amir Kabiri on 1/24/24.
//

import Foundation
import Firebase
import FirebaseFirestore


class ViewModel: ObservableObject {
    
    @Published var list = [Todo]()
    
    func updateData(todoToUpdate: Todo) {
        // get a reference to the database
        let db = Firestore.firestore()
        
        // set the data to update
        db.collection("todos").document(todoToUpdate.id).setData(["name":"Updated: \(todoToUpdate.name)"], merge: true) { error in
            // check for errors
            if error == nil {
                
                // get the new data
                self.getData()
            }
        }
        
    }
    
    func deleteData(todoToDelete: Todo) {
        // get a referenced to the database
        let db = Firestore.firestore()
        
        // specify document to delete
        db.collection("todos").document(todoToDelete.id).delete { error in
            // check for errors
            if error == nil {
                // no error
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // remove the todo that was just deleted
                    self.list.removeAll { todo in
                        // check for the todo to remove
                        return todo.id == todoToDelete.id
                    }
                }
            }
        }
    }
    
    func addData(name: String, notes: String) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("todos").addDocument(data: ["name":name, "notes":notes]) { error in
            // check for errors
            
            if error == nil {
                // no errors
                
                // call get data to retrieve latest data
                self.getData()
            }
            else {
                // handle the error
            }
        }
        
    }
    
    func getData() {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("todos").getDocuments { snapshot, error in
            // check for error first
            if error == nil {
                // no errors
                
                if let snapshot {
                    
                    // update the list property in the main thread
                    DispatchQueue.main.async {
                        // get all the documents and create todos
                        
                        // create a Todo item for each item returned
                        self.list = snapshot.documents.map { d in
                            return Todo(id: d.documentID,
                                        name: d["name"] as? String ?? "",
                                        notes: d["notes"] as? String ?? "")
                        }
                    }
                }
            }
            else {
                // handle the error
                
            }
        }
    }
    
}
