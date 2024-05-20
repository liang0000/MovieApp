//


import SwiftUI

struct MovieDetailView: View {
    var movieId: Int
    @State private var viewModel = MovieDetailViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                AsyncImage(url: URL(string: viewModel.imagePath + (viewModel.movie?.backdrop_path ?? "") )) { image in
                    image
                } placeholder: { ProgressView() }
                
//                MovieRemoteImage(urlString: "/lBm8kh5iucqthRYo9jhsDaJHPJ7.jpg")
                
				VStack {
					HStack {
						AsyncImage(url: URL(string: viewModel.imagePath + (viewModel.movie?.poster_path ?? "") )) { image in
							image
								.resizable()
								.frame(width: 90, height: 130)
								.clipShape(RoundedRectangle(cornerRadius: 5))
								.background(
									Color.white
										.clipShape(RoundedRectangle(cornerRadius: 5))
										.shadow(color: .black.opacity(0.5), radius: 5, y: 5)
								)
						} placeholder: { ProgressView() }
						
						VStack(alignment: .leading) {
							Text(viewModel.movie?.title ?? "")
								.font(.title2.bold())
							
							HStack {
								AdultSign(adultSign: viewModel.movie?.adult ?? false)
								LabelBox(text: "\(viewModel.movie?.runtime ?? 0) mins")
								LabelBox(text: "\(viewModel.movie?.vote_average.rounded(toDecimalPlaces: 1) ?? 0) Rates")
							}
							
							HStack {
								ForEach(viewModel.movie?.spoken_languages ?? [], id: \.id) { language in
									LabelBox(text: language.english_name)
								}
							}
							
							HStack {
								ForEach(viewModel.movie?.genres ?? [], id: \.id) { genre in
									Text(genre.name)
										.font(.caption2)
										.foregroundStyle(.secondary)
								}
							}
						}
						.frame( maxWidth: .infinity, alignment: .leading)
						.padding(.leading, 5)
					}
					
					DisclosureGroup {
						Text(viewModel.movie?.overview ?? "")
					} label: {
						Text("Overview")
							.font(.title2.bold())
							.foregroundStyle(Color(.label))
					}
					.padding(.bottom)
					
					SlotPicker()
				}
				.padding(.horizontal)
            }
			.background(Color(.secondarySystemBackground))
            
            if viewModel.isLoading { LoadingView() }
        }
		.navigationBarTitleDisplayMode(.inline)
		.task { viewModel.getMovieDetail(movieId: movieId) }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    MovieDetailView(movieId: 572802)
}
