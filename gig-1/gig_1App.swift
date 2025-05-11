//
//  gig_1App.swift
//  gig-1
//
//  Created by ABHINAV ANAND  on 11/05/25.
//

import SwiftUI

@main
struct gig_1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
