//
//  AlticeTakeHomeAssignmentApp.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/14/26.
//

import SwiftUI

@main
struct AlticeTakeHomeAssignmentApp: App {
    @StateObject private var favoritesStore = FavoritesStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoritesStore)
        }
    }
}
