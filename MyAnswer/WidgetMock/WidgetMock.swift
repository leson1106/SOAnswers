//
//  WidgetMock.swift
//  WidgetMock
//
//  Created by Son Le on 27/12/2023.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerActivityView: View {
    let context: ActivityViewContext<TimerAttributes>

    var body: some View {
        VStack {
            Text(context.attributes.timerName)
                .font(.headline)

            Text(context.state.endTime, style: .timer)
                .frame(alignment: .center)
        }
    }
}

struct WidgetMock: Widget {
    let kind: String = "WidgetMock"

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            TimerActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Increase")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Close")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    TimerActivityView(context: context)
                }
            } compactLeading: {
                Text("I")
            } compactTrailing: {
                Text("C")
            } minimal: {
                Text("Min")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}
