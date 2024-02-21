import UIKit

class NetworkManager: NSObject {
    static let shared           = NetworkManager()
    private let cache           = NSCache<NSString, UIImage>()
    
    private let baseURL          = "https://api.themoviedb.org/3/movie/"
    private let apiKey           = "?api_key=328c283cd27bd1877d9080ccb1604c91"
    let imageURL                = "https://image.tmdb.org/t/p/w400"
    
    private override init() {}
    
    func getMovies(page: Int, completed: @escaping (Result<[Movie], MVError>) -> Void) {
        let endpoint = baseURL + "now_playing\(apiKey)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
  
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
                        
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieResponse.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getMovieDetail(id: Int, completed: @escaping (Result<MovieDetail, MVError>) -> Void) {
        let urlString = baseURL + String(id) + apiKey
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDetail.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: imageURL + urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: imageURL + urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
