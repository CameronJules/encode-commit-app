import SwiftUI

struct TextStyleModifier: ViewModifier {
    let style: TextStyle

    func body(content: Content) -> some View {
        content
            .font(.custom(fontName, size: fontSize))
            .tracking(letterSpacing)
            .foregroundColor(textColor)
    }

    private var fontName: String {
        switch style {
        case .h1, .h2:
            return "Fredoka-Bold"
        case .h3, .h4, .h4Active, .buttonText:
            return "Fredoka-SemiBold"
        case .body1Bold, .body1Action, .body2Bold:
            return "Fredoka-Medium"
        case .body1, .body2, .tagline:
            return "Fredoka-Regular"
        }
    }

    private var fontSize: CGFloat {
        switch style {
        case .h1:
            return 56
        case .h2:
            return 32
        case .h3:
            return 26
        case .h4, .h4Active:
            return 22
        case .body1, .body1Bold, .body1Action, .buttonText:
            return 18
        case .body2, .body2Bold, .tagline:
            return 14
        }
    }

    private var letterSpacing: CGFloat {
        // Formula: letterSpacing = fontSize * (percentValue / 100)
        switch style {
        case .h1:
            return 56 * (-2.0 / 100) // -1.12
        case .h2:
            return 32 * (-2.0 / 100) // -0.64
        case .h3:
            return 26 * (1.0 / 100) // 0.26
        case .h4, .h4Active:
            return 22 * (1.0 / 100) // 0.22
        case .body1:
            return 18 * (2.0 / 100) // 0.36
        case .body1Bold, .body1Action:
            return 18 * (1.0 / 100) // 0.18
        case .body2:
            return 14 * (2.0 / 100) // 0.28
        case .tagline:
            return 14 * (3.0 / 100) // 0.42
        case .body2Bold:
            return 14 * (1.0 / 100) // 0.14
        case .buttonText:
            return 18 * (1.0 / 100) // 0.18
        }
    }

    private var textColor: Color? {
        switch style {
        case .h4:
            return Color("H4Text")
        case .h4Active, .body1Action:
            return Color("BluePrimary")
        case .body1, .body1Bold, .body2, .body2Bold:
            return Color("BodyText")
        case .tagline:
            return Color("TaglineText")
        case .h1, .h2, .h3, .buttonText:
            return nil
        }
    }
}
