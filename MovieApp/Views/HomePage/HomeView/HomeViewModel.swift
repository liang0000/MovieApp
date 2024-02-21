import Foundation
import Observation
import Combine

@Observable
final class HomeViewModel {
    var movies: [Movie] = []
    var isLoading = false
    var alertItem: AlertItem?
    var sortingOptions: [String] = ["Release Date", "Title", "Rating"]
    var selectedSorting: String = "Release Date"
    var page: Int = 1
    
    func getMovies() {
        isLoading = true
        
        NetworkManager.shared.getMovies(page: page) { [self] result in
            DispatchQueue.main.async { [self] in
                isLoading = false
                
                switch result {
                    case .success(let movies):
                        self.movies.append(contentsOf: movies)
                        sortMoviesByReleaseDate()
                        
                    case .failure(let error):
                        switch error {
                            case .invalidData:
                                alertItem = AlertContext.invalidData
                                
                            case .invalidURL:
                                alertItem = AlertContext.invalidURL
                                
                            case .invalidResponse:
                                alertItem = AlertContext.invalidResponse
                                
                            case .unableToComplete:
                                alertItem = AlertContext.unableToComplete
                        }
                }
            }
        }
    }
    
    func pullToRefresh() {
        getMovies()
        selectedSorting = "Release Date"
    }
    
    func sortingMovies() {
        if selectedSorting == "Release Date" { sortMoviesByReleaseDate() }
        else if selectedSorting == "Title" { sortMoviesByTitle() }
        else if selectedSorting == "Rating" { sortMoviesByRating() }
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
