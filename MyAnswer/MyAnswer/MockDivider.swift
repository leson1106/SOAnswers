//
//  MockDivider.swift
//  MyAnswer
//
//  Created by Son Le on 30/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77575247/swiftui-divider-widens-its-parent-view-too-much
struct MockDivider: View {
    var body: some View {
        HStack {
            VStack {
                Text("AAABBCCDD")
                Divider()
                Text("BBB")
            }
            .fixedSize()
            .background(Color.orange)
            
            Text("BodyBodyBodyBodyBodyBodyBodyBodyBodyBody")
            .frame(maxWidth: .infinity)
            .background(Color.blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MockDivider()
    }
}
