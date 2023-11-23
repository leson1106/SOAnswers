//
//  ParentView.swift
//  MyAnswer
//
//  Created by Son Le on 22/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77530656/why-the-child-view-parameter-changed-without-view-updated
extension Date {
    mutating func add(days: Int) {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        components.day! += 1
        
        self = calendar.date(from: components) ?? Date()
    }
}

struct ParentView: View {
    
    @State private var hostDate = Date()
    @State private var dayOffSet = 0
    
    var body: some View {
        VStack(spacing: 10) {
            ChildView(hostDate: $hostDate)
            
            Button {
                dayOffSet += 1
                hostDate.add(days: dayOffSet)
            } label: {
                Text("Change day offset")
            }
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
