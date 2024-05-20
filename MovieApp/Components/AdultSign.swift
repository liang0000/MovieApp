//


import SwiftUI

struct AdultSign: View {
    let adultSign: Bool
    
    var body: some View {
        VStack {
            Text(adultSign ? "18" : "13")
                .padding(5)
                .font(.caption)
        }
		.background(Color(adultSign ? .systemRed : .systemGray))
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    AdultSign(adultSign: true)
}
