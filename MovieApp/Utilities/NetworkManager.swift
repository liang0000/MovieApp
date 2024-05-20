import UIKit

class NetworkManager: NSObject {
    static let shared           = NetworkManager()
    private let cache           = NSCache<NSString, UIImage>()
    
    private let baseURL         = "https://api.themoviedb.org/3/movie/"
    private let apiKey          = "?api_key=328c283cd27bd1877d9080ccb1604c91"
    let imageURL                = "https://image.tmdb.org/t/p/w400"
	let decoder					= JSONDecoder()
    
    private override init() {}
    
	func getMovies(page: Int) async throws -> [Movie] {
        let endpoint = baseURL + "now_playing\(apiKey)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
			throw MVError.invalidURL
        }
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw MVError.invalidResponse
		}
		
		do {
			let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
			return decodedResponse.results
		} catch {
			throw MVError.invalidData
		}
    }
	
	func getMovieDetail(id: Int) async throws -> MovieDetail {
        let urlString = baseURL + String(id) + apiKey
        
        guard let url = URL(string: urlString) else {
			throw MVError.invalidURL
        }
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw MVError.invalidResponse
		}
		
		do {
			let decodedResponse = try decoder.decode(MovieDetail.self, from: data)
			return decodedResponse
		} catch {
			throw MVError.invalidData
		}
    }
	
	func downloadImage(from urlString: String) async -> UIImage? {
		let cacheKey = NSString(string: imageURL + urlString)
		if let image = cache.object(forKey: cacheKey) { return image }
		
		guard let url = URL(string: imageURL + urlString),
			  let (data, _) = try? await URLSession.shared.data(from: url),
			  let image = UIImage(data: data) else {
			return nil
		}
		
		cache.setObject(image, forKey: cacheKey)
		return image
	}
}
