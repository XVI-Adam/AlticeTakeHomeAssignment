//
//  ContentView.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/14/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Tab(Constants.homeString, systemImage: Constants.homeIconString){
                HomeView()
            }
            Tab(Constants.favoriteString, systemImage: Constants.favoriteIconString){
                FavoriteView()
            }
            Tab(Constants.settingString, systemImage: Constants.settingIconString){
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
