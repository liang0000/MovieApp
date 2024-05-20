//


import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
				List {
					ForEach(viewModel.movies, id: \.id) { movie in 
						NavigationLink {
							MovieDetailView(movieId: movie.id)
						} label: {
							MovieRow(movie: movie)
								.onAppear { viewModel.loadMoreContent(movie) }
						}
					}
					
					if viewModel.isLoadingContent {
						ProgressView()
							.frame( maxWidth: .infinity, alignment: .center)
					}
                }
				.navigationTitle("Movies")
                .toolbar {
					ToolbarItem {
						Menu {
							Picker("Sorting", selection: $viewModel.selectedSorting) {
								ForEach(Sort.allCases, id: \.self) { option in
									Text(option.rawValue)
								}
							}
						} label: {
							Image(systemName: "line.3.horizontal.decrease.circle")
						}
					}
                }
            }
            
            if viewModel.isLoading { LoadingView() }
        }
		.task { viewModel.getMovies() }
		.refreshable { viewModel.pullToRefresh() }
		.onChange(of: viewModel.selectedSorting) { viewModel.sortingMovies() }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    HomeView()
}
