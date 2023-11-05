//
//  ContentView.swift
//  MyAnswer
//
//  Created by Son Le on 05/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77421723/swiftui-scrollview-with-paging-scrolltargetbehavior-shows-end-of-previous-page
struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) { //<- change spacing to 0
                    ForEach(1...10, id: \.self) { _ in
                        Image(systemName: "rectangle.slash")
                            .frame(width: geometry.size.width)
                            .border(.red)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
