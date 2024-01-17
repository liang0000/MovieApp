//


import XCTest
@testable import MovieApp

final class MovieAppTests: XCTestCase {
    
    func testSortMoviesByReleaseDate() {
        let viewModel = HomeViewModel()
        let movie1 = Movie(id: 1, title: "Movie 1", poster_path: "", popularity: 0.0, vote_average: 0.0, release_date: "2023-01-01", adult: false)
        let movie2 = Movie(id: 2, title: "Movie 2", poster_path: "", popularity: 0.0, vote_average: 0.0, release_date: "2023-02-01", adult: false)
        let movie3 = Movie(id: 3, title: "Movie 3", poster_path: "", popularity: 0.0, vote_average: 0.0, release_date: "2023-03-01", adult: false)
        let unsortedMovies = [movie2, movie3, movie1]
        
        viewModel.movies = unsortedMovies
        viewModel.sortMoviesByReleaseDate()
        
        XCTAssertEqual(viewModel.movies, [movie3, movie2, movie1])
//        XCTAssertEqual(viewModel.movies, [movie1, movie2, movie3])
    }
    
    func testSortMoviesByTitle() {
        let viewModel = HomeViewModel()
        let movie1 = Movie(id: 1, title: "Aquaman", poster_path: "", popularity: 0.0, vote_average: 0.0, release_date: "2023-01-01", adult: false)
        let movie2 = Movie(id: 2, title: "Bee The King", poster_path: "", popularity: 0.0, vote_average: 0.0, release_date: "2023-02-01", adult: false)
        let movie3 = Movie(id: 3, title: "Cat The Famous", poster_path: "", popularity: 0.0, vote_average: 0.0, release_date: "2023-03-01", adult: false)
        let unsortedMovies = [movie2, movie3, movie1]
        
        viewModel.movies = unsortedMovies
        viewModel.sortMoviesByTitle()
        
        XCTAssertEqual(viewModel.movies, [movie1, movie2, movie3])
    }
    
    func testSortMoviesByRating() {
        let viewModel = HomeViewModel()
        let movie1 = Movie(id: 1, title: "Aquaman", poster_path: "", popularity: 0.0, vote_average: 7.0, release_date: "2023-01-01", adult: false)
        let movie2 = Movie(id: 2, title: "Bee The King", poster_path: "", popularity: 0.0, vote_average: 8.1, release_date: "2023-02-01", adult: false)
        let movie3 = Movie(id: 3, title: "Cat The Famous", poster_path: "", popularity: 0.0, vote_average: 5.6, release_date: "2023-03-01", adult: false)
        let unsortedMovies = [movie2, movie3, movie1]
        
        viewModel.movies = unsortedMovies
        viewModel.sortMoviesByRating()
        
        XCTAssertEqual(viewModel.movies, [movie2, movie1, movie3])
    }
}
