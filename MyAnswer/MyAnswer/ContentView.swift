//
//  ContentView.swift
//  MyAnswer
//
//  Created by Son Le on 27/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77561425/is-there-a-way-to-have-a-view-only-be-included-for-previews-ignoring-that-view
struct ContentView: View {
    var body: some View {
        Text("Real view")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
            
            Text("PREVIEWING")
        }
    }
}
