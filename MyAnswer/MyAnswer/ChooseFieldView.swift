//
//  ChooseFieldView.swift
//  Example
//
//  Created by Son Le on 22/08/2023.
//

import SwiftUI

struct ChooseFieldView: View {
    
    @Binding var index: Int
    var values: [String]
    
    var body: some View {
        Picker(selection: $index, label: EmptyView()) {
            ForEach(values.indices, id: \.self) { index in
                Text(values[index]).tag(index)
            }
        }
    }
}

struct ChooseFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseFieldView(index: .constant(0),
                        values: ["fieldFromFile1", "fieldFromFile2", "fieldFromFileN"])
    }
}
