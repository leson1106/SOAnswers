//
//  ChildView.swift
//  MyAnswer
//
//  Created by Son Le on 22/11/2023.
//

import SwiftUI

struct ChildView: View {
    
    @Binding var hostDate: Date
    
    var body: some View {
        VStack {
            Text("Host Date is \(hostDate.description)")
        }
    }
}

struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        ChildView(hostDate: .constant(Date()))
    }
}
