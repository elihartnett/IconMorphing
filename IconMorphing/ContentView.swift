//
//  ContentView.swift
//  IconMorphing
//
//  Created by Eli Hartnett on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MorphingView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
