//
//  ContentView.swift
//  Animations2
//
//  Created by Waihon Yew on 21/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingRed = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                isShowingRed.toggle()
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
            }
        }
    }
}

struct DragCharactersContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    // Make the first character to have zero delay, and
                    // subsequent characters more and more delay
                    .animation(.default.delay(Double(num) / 20.0), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

struct GradientCardContentView: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    // translation tells us how far it's moved from the start point
                    .onChanged { dragAmount = $0.translation }
                    // Ignore the input and set dragAmount back to zero to return
                    // the card to its original position
                    .onEnded { _ in
                        // Explicit animation
                        withAnimation(.spring()) {
                            dragAmount = .zero
                        }
                    }
            )
    }
}

struct MultipleAnimationContentView: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        // Only changes that occur before the animation() get animated
        .animation(.easeIn, value: enabled)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60: 0))
        // With multiple animation(), each one controls everything before it
        // up to the next animation.
        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
    }
}

struct ExplicitAnimationContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        Button("Tap Me") {
            // withAnimation() can be given an animation parameter
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
}

struct BindingContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        print(animationAmount)

        return VStack {
            // Since the stepper is bound to $animationAmount.animation(),
            // SwiftUI will automatically animate its changes.
            Stepper("Scale amount", value: $animationAmount.animation(
                .easeInOut(duration: 1)
                .repeatCount(3, autoreverses: true)
            ), in: 1...10)
                .padding()

            Spacer()

            Button("Tap Me") {
                animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)

            Spacer()
        }
    }
}

struct OverlayContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
            // Do nothing
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                // When animationAmount is 1 the opacity is 1 (it's opaque)
                // and when animationAmount is 2 the opacity is 0 (it's transparent)
                .opacity(2.0 - animationAmount)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: false),
                           value: animationAmount)
        )
        .onAppear {
            animationAmount = 2.0
        }
    }
}

struct AnimationContentView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
            animationAmount += 0.5  // 50%
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        // The blur radius will start at 0 (no blur)
        .blur(radius: (animationAmount - 1.0) * 2.0)

        // The default animation in practice is an "ease in, ease out" animation
        //.animation(.default, value: animationAmount)

        // Change the type of anamiation to .easeOut to make the animation
        // start fast then slow down to a smooth stop.
        //animation(.easeOut, value: animationAmount)

        // Spring animations cause the movement to overshoot then return to
        // its target.
        // stiffness = Initial velocity when the animation starts
        // damping = How fast the animation should be "damped" - lower values
        // cause the spring to bounce back and forth for longer.
        //.animation(.interpolatingSpring(stiffness: 50, damping: 2), value: animationAmount)

        // Customize the animation with a duration specified as a number of seconds
        //.animation(.easeInOut(duration: 2), value: animationAmount)

        // Wait for a second before executing a two-second animation
        //.animation(.easeInOut(duration: 2).delay(1), value: animationAmount)

        // Create a one-second animation that will bounce up and down before
        // reaching its final size
        //.animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true),
        //           value: animationAmount)

        // With repeat count set to 2, the button would scale up then down
        // again, then jump immediately back up to its larger scale.
        // This is because ultimately the button must match the state of
        // our program, regardless of what animations we apply.
        //.animation(.easeInOut(duration: 1).repeatCount(2, autoreverses: true),
        //           value: animationAmount)

        // Continuous animations
        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true),
                   value: animationAmount)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
