//
//  ContentView.swift
//  Animations2
//
//  Created by Waihon Yew on 21/05/2022.
//

import SwiftUI

struct ContentView: View {
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
        .animation(.easeInOut(duration: 2).delay(1), value: animationAmount)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
