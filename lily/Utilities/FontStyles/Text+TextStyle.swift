import SwiftUI

extension Text {
    func textStyle(_ style: TextStyle) -> some View {
        self.modifier(TextStyleModifier(style: style))
    }

    func textStyle(_ style: TextStyle, color: Color) -> some View {
        self.modifier(TextStyleModifier(style: style, colorOverride: color))
    }
}
