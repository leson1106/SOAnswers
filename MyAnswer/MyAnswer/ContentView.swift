//
//  ContentView.swift
//  MyAnswer
//
//  Created by Son Le on 27/12/2023.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    @State private var activity: Activity<TimerAttributes>?

    var body: some View {
        VStack(spacing: 16) {
            Button("Start") {
                start()
            }

            Button("Stop") {
                stop()
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }

    func start() {
        let att = TimerAttributes(timerName: "Mock timer")
        let state = TimerAttributes.TimerStatus(endTime: Date().addingTimeInterval(60*5))

        try? Activity<TimerAttributes>.request(attributes: att, contentState: state, pushType: nil)
    }

    private func stop() {
        let state = TimerAttributes.TimerStatus(endTime: .now)

        Task {
            await activity?.end(using: state, dismissalPolicy: .immediate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
