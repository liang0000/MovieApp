//


import Foundation
import Observation

@Observable
final class MovieDetailViewModel {
    var movie: MovieDetail?
    var isLoading = false
    var alertItem: AlertItem?
    var imagePath: String = NetworkManager.shared.imageURL
    
    func getMovieDetail(movieId: Int) {
        isLoading = true
        
        NetworkManager.shared.getMovieDetail(id: movieId) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                    case .success(let movie):
                        self.movie = movie
                        
                    case .failure(let error):
                        switch error {
                            case .invalidData:
                                self.alertItem = AlertContext.invalidData
                                
                            case .invalidURL:
                                self.alertItem = AlertContext.invalidURL
                                
                            case .invalidResponse:
                                self.alertItem = AlertContext.invalidResponse
                                
                            case .unableToComplete:
                                self.alertItem = AlertContext.unableToComplete
                        }
                }
            }
        }
    }
}
