//
//  BackgroundFillView.swift
//  MyAnswer
//
//  Created by Son Le on 27/11/2023.
//

import SwiftUI

struct BackgroundFillView: View {
    var body: some View {
        ContainerRelativeShape()
            .fill(Color.blue.gradient)
            .ignoresSafeArea()
            
    }
}

struct BackgroundFillView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundFillView()
    }
}
