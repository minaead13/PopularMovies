# MovieApp
A simple movie app using Clean Architecture + MVVM
# ✨ Features

- Displays a grid of popular movies.
- Navigates to a detailed screen with:
  - Poster image
  - Movie title
  - Release date
  - Vote average
  - Original language
  - Overview
- Favorite button to toggle state (stored in-memory/UserDefaults).
- Handles loading and error states gracefully.


# 🏗️ Architecture

🔷 Clean Architecture Layers

1- Presentation Layer
 - MoviesListViewController, MovieDetailsViewController
 - ViewModels: MoviesListViewModel, MovieDetailsViewModel
 
2- Domain Layer
 - Entities: MoviesResponse
 - UseCases: FetchMoviesUseCase, FetchMovieDetailsUseCase
 - Repository protocols: MoviesRepository, MovieDetailsRepository

3- Data Layer
 - APIClient: generic network layer using Alamofire
 - Storage: FavoritesLocalDataSource
 - Repository implementations: MoviesRepositoryImpl, MovieDetailsRepositoryImpl

# 🔷 Design Patterns Used
MVVM for separation of UI logic and business logic.
Coordinator Pattern for navigation handling.
Dependency Injection using AppDIContainer.
SPM (Swift Package Manager) for external dependencies management.
🔌 Third-party Dependencies

Alamofire for networking.
Kingfisher for asynchronous image loading.
🚀 Setup & Run

# 🧪 Unit Testing(Bonus)
Implemented using XCTest.
Tests cover:
ViewModels logic (MoviesListViewModel)
UseCases (FetchMoviesUseCase, FetchMovieDetailsUseCase)


Clone the repository:
git clone https://github.com/minaead13/PopularMovies.
Open the project in Xcode.
Ensure all dependencies are fetched via Swift Package Manager.
Build & run on iOS Simulator or device.


# 🎯 Trade-offs & Notes

Coordinator Pattern was used for navigation to decouple ViewControllers.
Error Handling and Loading States are implemented via closures in ViewModels for clean UI binding.
Used UIKit as per requirement.


# 👨‍💻 Author
Name: Mina Ead
LinkedIn: www.linkedin.com/in/mina-eid-254bb0177
