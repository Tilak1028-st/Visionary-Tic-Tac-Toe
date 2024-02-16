//
//  ContentView.swift
//  Visionary Tic Tac Toe
//
//  Created by Tilak Shakya on 14/02/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        VStack {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)

            TicTacToe()
        }
        .padding()
    }
}


#Preview(windowStyle: .automatic) {
    ContentView()
}
