
import SwiftUI

struct MHLoading: View {

    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    private let pulseEffect: Bool
    private let innerColor: Color
    private let outerColor: Color
    private let backgroundColor: Color

    init(backgroundColor: Color = Color.init(red: 0.96, green: 0.96, blue: 0.96),
         outerColor: Color = .blue,
         innerColor: Color = .green,
         pulseEffect: Bool = true) {
        self.pulseEffect = pulseEffect
        self.backgroundColor = backgroundColor
        self.outerColor = outerColor
        self.innerColor = innerColor
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .fill(backgroundColor)

            Circle()
                .trim(from: animateStart ? 1/3 : 1/9, to: animateEnd ? 2/5 : 1)
                .stroke(lineWidth: 10)
                .rotationEffect(.degrees(isCircleRotating ? 360 : 0))
                .foregroundColor(outerColor)
                .coordinateSpace(name: "container")
                .onAppear() {
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .repeatForever(autoreverses: false)) {
                        self.isCircleRotating.toggle()
                    }
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .delay(0.5)
                                    .repeatForever(autoreverses: true)) {
                        self.animateStart.toggle()
                    }
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .delay(1)
                                    .repeatForever(autoreverses: true)) {
                        self.animateEnd.toggle()
                    }
                }

            let ration: CGFloat = animateStart ? 16.0 / 9.0 : 1.0
            Circle()
                .trim(from: animateStart ? 1/3 : 1/9, to: animateEnd ? 2/5 : 1)
                .stroke(lineWidth: 15)
                .rotationEffect(.degrees(isCircleRotating ? -360 : 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(ration, contentMode: .fit)

                .foregroundColor(innerColor)


        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MHLoading()
            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/))
            .environment(\.sizeCategory, .small)
    }
}
