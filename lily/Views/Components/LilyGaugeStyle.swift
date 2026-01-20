import SwiftUI

struct LilyGaugeStyle: GaugeStyle {
    var fillColor: Color = Color("GreenPrimary")
    var trackColor: Color = Color(UIColor.systemGray5)
    var height: CGFloat = 16

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            let fillWidth = geometry.size.width * configuration.value

            ZStack(alignment: .leading) {
                // Track layer
                Capsule()
                    .fill(trackColor)

                // Fill layer
                Capsule()
                    .fill(fillColor)
                    .frame(width: fillWidth)

                // Highlight layer
                Capsule()
                    .fill(Color.white.opacity(0.4))
                    .frame(
                        width: max(0, fillWidth - 16),
                        height: height * 0.2
                    )
                    .offset(x: 8, y: -height * 0.20)
            }
            .clipShape(Capsule())
        }
        .frame(height: height)
        .animation(.easeInOut(duration: 0.3), value: configuration.value)
    }
}

#Preview {
    VStack(spacing: 24) {
        // Different progress values
        Gauge(value: 0.0) {}
            .gaugeStyle(LilyGaugeStyle())

        Gauge(value: 0.3) {}
            .gaugeStyle(LilyGaugeStyle())

        Gauge(value: 0.6) {}
            .gaugeStyle(LilyGaugeStyle())

        Gauge(value: 1.0) {}
            .gaugeStyle(LilyGaugeStyle())

        // Different colors
        Gauge(value: 0.5) {}
            .gaugeStyle(LilyGaugeStyle(fillColor: Color("BluePrimary")))

        Gauge(value: 0.7) {}
            .gaugeStyle(LilyGaugeStyle(fillColor: Color("PurplePrimary")))

        // Custom height
        Gauge(value: 0.5) {}
            .gaugeStyle(LilyGaugeStyle(fillColor: Color("GreenPrimary"), height: 32))
    }
    .padding()
}
