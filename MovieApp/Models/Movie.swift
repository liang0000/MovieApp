import Foundation

struct Movie: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let poster_path: String
    let popularity: Double
    let vote_average: Double
    let release_date: String
    let adult: Bool
}

struct MovieDetail: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let poster_path: String
    let backdrop_path: String
    let adult: Bool
    let vote_average: Double
    let genres: [Genre]
    let overview: String
    let runtime: Int
    let spoken_languages: [Language]
}

struct Genre: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
}

struct Language: Hashable, Codable, Identifiable {
    var id: String { iso_639_1 }
    let english_name: String
    let iso_639_1: String
}

struct MovieResponse: Hashable, Codable {
    let results: [Movie]
}

struct MockData {
    static let movies = [sampleMovie, sampleMovie, sampleMovie]
    
    static let sampleMovie = Movie(id: 1143183, title: "Rewind", poster_path: "/ru1i4ZR11lPPVArk3fOcO1VCOlD.jpg", popularity: 667.748, vote_average: 6.875, release_date: "2023-12-25", adult: false)
}
