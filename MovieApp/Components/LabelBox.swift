//


import SwiftUI

struct LabelBox: View {
    let text: String
    
    var body: some View {
        VStack {
            Text(text)
                .padding(5)
                .font(.caption2)
        }
        .foregroundStyle(.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(.gray, lineWidth: 2))
    }
}

#Preview {
    LabelBox(text: "110 Mins")
}
