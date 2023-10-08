//
//  SummaryView.swift
//  Example
//
//  Created by Son Le on 07/10/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77248167/swiftui-view-initializer-is-inaccessible-due-to-private-protection-level/
struct LocationInfra: Identifiable {
    var id: UUID = .init()
    var index: Int
    var locationName: String
}

struct SummaryView: View {
    var locationProfiles: [LocationInfra] = [
        .init(index: 0, locationName: "US"),
        .init(index: 1, locationName: "UK"),
        .init(index: 2, locationName: "SG")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(locationProfiles) { locationProfile in
                    NavigationLink() {
                        ConfigProfileView(locationInfra: locationProfile)
                    } label: {
                        Text("Index: \(locationProfile.index)")
                    }
                }
            }
            .navigationTitle("Summary")
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
