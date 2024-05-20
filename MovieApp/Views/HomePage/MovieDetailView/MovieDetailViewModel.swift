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
		Task {
			do {
				movie = try await NetworkManager.shared.getMovieDetail(id: movieId)
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
}
