//
//  ConfigProfileView.swift
//  Example
//
//  Created by Son Le on 07/10/2023.
//

import SwiftUI

struct ConfigProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var locationInfra: LocationInfra?
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack (alignment: .leading ) {
                    Text(locationInfra?.locationName ?? "unknown")
                }
            }
        }
    }
}
struct ConfigProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigProfileView(locationInfra: LocationInfra(index: 0, locationName: "A"))
    }
}
