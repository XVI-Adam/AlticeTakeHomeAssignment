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
                Text(Constants.favoriteString)
            }
            Tab(Constants.settingString, systemImage: Constants.settingIconString){
                Text(Constants.settingString)
            }
        }
    }
}

#Preview {
    ContentView()
}
