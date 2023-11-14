//
//  MockUserDefault.swift
//  MyAnswer
//
//  Created by Son Le on 14/11/2023.
//

import SwiftUI

struct MockUserDefault: View {
    
    @AppStorage("abc") var selectedValue = 0
    var numbers = [1,2,3,4,5]
    
    var body: some View {
        Picker("Select number", selection: $selectedValue) {
            ForEach(numbers, id: \.self) {
                Text("\($0)")
            }
        }
        .pickerStyle(.segmented)
    }
}

struct MockUserDefault_Previews: PreviewProvider {
    static var previews: some View {
        MockUserDefault()
    }
}
