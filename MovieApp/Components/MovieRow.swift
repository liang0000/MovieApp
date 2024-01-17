//


import SwiftUI

struct MovieRow: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            MovieRemoteImage(urlString: movie.poster_path)
                .frame(width: 90, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .font(.title3.bold())
                    .lineLimit(2)
                HStack {
                    AdultSign(adultSign: movie.adult)
                    LabelBox(text: "\(movie.vote_average.rounded(toDecimalPlaces: 1)) Rates")
                    LabelBox(text: "\(Int(movie.popularity.rounded())) Popularities")
                }
                Text(movie.release_date)
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    MovieRow(movie: MockData.sampleMovie)
}
