//
//  ImportDataView.swift
//  Example
//
//  Created by Son Le on 22/08/2023.
//

import SwiftUI

//Related to https://stackoverflow.com/questions/76954569/swiftui-common-view-with-binding-variable/
class ImportDataViewModel: ObservableObject {
   
    @Published var field1Index: Int = 0
    @Published var field2Index: Int = 0
    @Published var fieldNIndex: Int = 0
    
    func getFieldNamesFromCSV() -> [String] {
        return ["fieldFromFile1", "fieldFromFile2", "fieldFromFileN"]
    }
}

struct ImportDataView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var itVM: ImportDataViewModel
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Field 1  *")
                    Spacer()
                    ChooseFieldView(index: $itVM.field1Index,
                                    values: itVM.getFieldNamesFromCSV())
                }
                HStack {
                    Text("Field 2 *")
                    Spacer()
                    ChooseFieldView(index: $itVM.field2Index,
                                    values: itVM.getFieldNamesFromCSV())
                }
                HStack {
                    Text("Field N *")
                    Spacer()
                    ChooseFieldView(index: $itVM.fieldNIndex,
                                    values: itVM.getFieldNamesFromCSV())
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
        
    }
}

struct ImportDataView_Previews: PreviewProvider {
    static var previews: some View {
        ImportDataView()
            .environmentObject(ImportDataViewModel())
            .preferredColorScheme(.light)
    }
}
