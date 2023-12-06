//
//  DemoGridView.swift
//  MyAnswer
//
//  Created by Son Le on 05/12/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77603397/how-to-get-text-in-a-buttons-label-to-conform-to-grid-and-gridrow
struct GridData: Identifiable {
    var id = UUID()
    var type = ""
    var time = ""
    var speed: Float = 0.0
}

struct DemoGridView: View {
    var currents: [GridData] = [
        .init(type: "Ebb", time: "01:11", speed: 6.7),
        .init(type: "Slack", time: "04:44", speed: 0),
        .init(type: "Flood", time: "07:35", speed: 4.7),
        .init(type: "Slack", time: "10:42", speed: 0),
        .init(type: "Ebbbbaaaa", time: "13:30", speed: 15.6),
    ]

    @State private var selectedCurrent: GridData?

    var body: some View {
        VStack {
            if let selectedCurrent {
                Text("selected: \(selectedCurrent.type) - \(selectedCurrent.time)")
            }

            Grid() {
                ForEach(currents) { current in
                    GridRow {
                        Text(current.type)
                            .gridColumnAlignment(.trailing)
                        Text(current.time)
                            .gridColumnAlignment(.center)
                        Text("\(String(format: "%.1f", current.speed)) kn")
                            .gridColumnAlignment(.center)
                    }
                    .foregroundColor(.blue)
                    .onTapGesture {
                        selectedCurrent = current
                    }
                }
            }
        }
    }
}

struct DemoGridView_Previews: PreviewProvider {
    static var previews: some View {
        DemoGridView()
    }
}
