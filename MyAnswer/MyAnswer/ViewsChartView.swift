//
//  ViewsChartView.swift
//  MyAnswer
//
//  Created by Son Le on 30/11/2023.
//

import SwiftUI
import Charts

//https://stackoverflow.com/questions/77575569/how-to-make-1d-bar-chart-fill-up-entire-width-in-swiftui
struct ViewStatus: Identifiable {
    var id = UUID()
    var views: Double
    var status: String
}

struct ViewsChartView: View {
    var data: [ViewStatus] = [
        .init(views: 150_000, status: "Watching"),
        .init(views: 10_000, status: "Completed"),
        .init(views: 10_000, status: "On Hold"),
        .init(views: 100_000, status: "Plan to watch"),
        .init(views: 5_000, status: "Dropped"),
    ]
    
    var max: Double {
        data.map { $0.views }.reduce(0, +)
    }
    
    var body: some View {
        HStack {
            Chart(data) {
                BarMark(
                    x: .value("Views", $0.views)
                )
                .foregroundStyle(by: .value("Status", $0.status))
            }
            .chartXScale(domain: 0...max)
            .frame(maxWidth: .infinity, maxHeight: 100)
        }
        .padding()
    }
}

struct ViewsChartView_Previews: PreviewProvider {
    static var previews: some View {
        ViewsChartView()
    }
}
