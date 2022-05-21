//
//  ContentView.swift
//  Animations2
//
//  Created by Waihon Yew on 21/05/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Tap Me") {
            // Do nothing
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
