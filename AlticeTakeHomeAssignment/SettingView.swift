//
//  SettingView.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import Foundation
import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var favoritesStore: FavoritesStore

    var body: some View {
        NavigationStack {
            List {
                Section("App") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        Text("Build")
                        Spacer()
                        Text("Take-Home")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Data Source") {
                    Text("Powered by TMDB API")
                        .foregroundStyle(.secondary)
                }

                Section("Actions") {
                    Button(role: .destructive) {
                        favoritesStore.clearAll()
                    } label: {
                        Text("Clear Favorites")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
