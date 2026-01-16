//
//  Constants.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/14/26.
//

import Foundation
import SwiftUI

struct Constants {
    static let homeString = "Home"
    static let favoriteString = "Favorites"
    static let settingString = "Settings"
    static let homeIconString = "house.fill"
    static let favoriteIconString = "heart.fill"
    static let settingIconString = "gearshape"
    static let todayString = "Today"
    static let weekString = "This Week"
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let trendingTodayEndpoint = "/trending/movie/day"
    static let trendingWeekEndpoint = "/trending/movie/week"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    static let testTitle = "Test Title"
}

extension Text {
    func ghostButton() -> some View {
        self
            .frame(width: 100, height: 50)
            .foregroundStyle(.buttonText)
            .bold()
            .background {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.buttonBorder, lineWidth: 5)
            }
    }
}
