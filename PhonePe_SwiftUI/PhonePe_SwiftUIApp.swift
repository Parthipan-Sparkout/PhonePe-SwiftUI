//
//  PhonePe_SwiftUIApp.swift
//  PhonePe_SwiftUI
//
//  Created by Mac on 30/04/22.
//

import SwiftUI

@main
struct PhonePe_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
