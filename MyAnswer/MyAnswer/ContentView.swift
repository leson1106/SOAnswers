//
//  ContentView.swift
//  MyAnswer
//
//  Created by Son Le on 14/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77482011/swiftui-how-to-initialize-segmented-pickers-from-saved-data
struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: MockUserDefault(), label: {
                Text("Tap me")
            }).simultaneousGesture(TapGesture().onEnded({
                UserDefaults.standard.set(3, forKey: "abc")
            }))
        }
    }
}

struct DemoChart_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
