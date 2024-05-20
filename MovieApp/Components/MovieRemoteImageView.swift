import SwiftUI
import Observation

@Observable 
final class ImageLoader {
    var image: Image? = nil
    
    func load(fromURL url: String) {
		Task {
			guard let uiImage = await NetworkManager.shared.downloadImage(from: url) else { return }
			image = Image(uiImage: uiImage)
		}
    }
}

struct RemoteImage: View {
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image(systemName: "photo").resizable()
    }
}

struct MovieRemoteImage: View {
    @State private var imageLoader = ImageLoader()
    var urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .task { imageLoader.load(fromURL: urlString) }
    }
}
