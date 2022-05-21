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
        .animation(.default, value: animationAmount)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
