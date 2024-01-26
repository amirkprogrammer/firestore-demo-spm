//
//  firestore_demo_spmApp.swift
//  firestore-demo-spm
//
//  Created by Amir Kabiri on 1/24/24.
//

import SwiftUI
import Firebase

@main
struct firestore_demo_spmApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
