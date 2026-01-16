# AlticeTakeHomeAssignment

This was my attempt at the list trending movies take home assignment for Altice

## Features

### ✅ Trending Movies (Today / This Week)
- Fetches trending movies from TMDB
- Displays movies in a clean list UI with poster, title, release date, and rating
- Pull-to-refresh supported
- Loading + error states included
### ✅ Movie Details
- Tap a movie to open a details screen
- Displays poster + key data (title, overview, rating, release date)
- Favorites can be toggled from the detail screen
- 
### ✅ Favorites 
- Users can favorite/unfavorite movies using a heart button
- Favorites screen shows saved movies and supports swipe-to-delete

### ✅ Settings
- Basic app information and TMDB attribution
- Includes an action to clear all favorites

## Tech Stack
- **Language:** Swift
- **UI:** SwiftUI
- **Networking:** URLSession (async/await)
- **Persistence:** UserDefaults (Codable storage)
- **Architecture:** MVVM (View + ViewModel + Service/Store split)
