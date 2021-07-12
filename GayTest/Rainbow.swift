import SwiftUI
struct RainbowAnimation: ViewModifier {
    // 1
    @State var isOn: Bool = false
    let hueColors = stride(from: 0, to: 1, by: 0.01).map {
        Color(hue: $0, saturation: 1, brightness: 1)
    }
    // 2
    var duration: Double = 4
    var animation: Animation {
        Animation
            .linear(duration: duration)
            .repeatForever(autoreverses: true)
    }
    
    func body(content: Content) -> some View {
    // 3
        let gradient = LinearGradient(gradient: Gradient(colors: hueColors+hueColors), startPoint: .leading, endPoint: .trailing)
        return content.overlay(GeometryReader { proxy in
            ZStack {
                gradient
                    // 4
                    .frame(width: 2*proxy.size.width)
                    // 5
                    .offset(x: self.isOn ? -proxy.size.width : 0)
            }
        })
            // 6
            .onAppear {
                withAnimation(self.animation) {
                    self.isOn = true
                }
        }
        .mask(content)
    }
}

extension View {
    func rainbowAnimation() -> some View {
        self.modifier(RainbowAnimation())
    }
}

