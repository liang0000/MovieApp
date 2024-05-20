//


import Foundation
import SwiftUI

extension Double {
    func rounded(toDecimalPlaces decimalPlaces: Int) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return (self * multiplier).rounded() / multiplier
    }
}

extension Color {
	static var lightModeBlueDarkModeWhite: Color {
		Color(UIColor { traitCollection in
			return traitCollection.userInterfaceStyle == .dark ? .white : .systemBlue
		})
	}
}
