import Foundation
import Observation
import Combine

@Observable
final class HomeViewModel {
    var movies: [Movie] = []
    var isLoading = false
	var isLoadingContent = false
    var alertItem: AlertItem?
	var selectedSorting: Sort = .releaseDate
    var page: Int = 1
    
    func getMovies() {
		isLoading = true
		loadMovies()
    }
    
    func pullToRefresh() {
		isLoading = true
		Task {
			do {
				page = 1
				let moviesData = try await NetworkManager.shared.getMovies(page: page)
				movies = moviesData
				sortingMovies()
			} catch MVError.invalidData {
				alertItem = AlertContext.invalidData
			} catch MVError.invalidURL {
				alertItem = AlertContext.invalidURL
			} catch MVError.invalidResponse {
				alertItem = AlertContext.invalidResponse
			} catch {
				alertItem = AlertContext.unableToComplete
			}
			isLoading = false
		}
    }
	
	func loadMoreContent(_ movie: Movie) {
		if movie == movies.last {
			isLoadingContent = true
			page += 1
			loadMovies()
		}
	}
	
	func loadMovies() {
		Task {
			do {
				let moviesData = try await NetworkManager.shared.getMovies(page: page)
				movies.append(contentsOf: moviesData)
			} catch MVError.invalidData {
				alertItem = AlertContext.invalidData
			} catch MVError.invalidURL {
				alertItem = AlertContext.invalidURL
			} catch MVError.invalidResponse {
				alertItem = AlertContext.invalidResponse
			} catch {
				alertItem = AlertContext.unableToComplete
			}
			isLoading = false
			isLoadingContent = false
		}
	}
    
    func sortingMovies() {
		switch selectedSorting {
			case .releaseDate:
				sortMoviesByReleaseDate()
			case .title:
				sortMoviesByTitle()
			case .rating:
				sortMoviesByRating()
		}
    }
    
    func sortMoviesByReleaseDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        movies.sort { (movie1, movie2) -> Bool in
            guard let date1 = dateFormatter.date(from: movie1.release_date),
                  let date2 = dateFormatter.date(from: movie2.release_date) else {
                return false
            }
            return date1 > date2
        }
    }
    
    func sortMoviesByTitle() {
        movies.sort { $0.title < $1.title }
    }
    
    func sortMoviesByRating() {
        movies.sort { $0.vote_average > $1.vote_average }
    }
}
