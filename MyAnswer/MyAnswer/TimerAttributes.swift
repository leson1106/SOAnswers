//
//  TimerAttributes.swift
//  MyAnswer
//
//  Created by Son Le on 27/12/2023.
//

import SwiftUI
import ActivityKit

struct TimerAttributes: ActivityAttributes {
    public typealias TimerStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var endTime: Date
    }

    var timerName: String
}
