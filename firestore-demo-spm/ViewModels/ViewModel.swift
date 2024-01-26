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
