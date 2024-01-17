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
                        }
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Text("Movies")
                            .font(.title.bold())
                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Menu {
                            Picker("Sorting", selection: $viewModel.selectedSorting) {
                                ForEach(viewModel.sortingOptions, id: \.self) { option in
                                    Text(option)
                                }
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
            }
            .onAppear { viewModel.getMovies() }
            .refreshable { viewModel.pullToRefresh() }
            .onChange(of: viewModel.selectedSorting) { viewModel.sortingMovies() }
            
            if viewModel.isLoading { LoadingView() }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    HomeView()
}
