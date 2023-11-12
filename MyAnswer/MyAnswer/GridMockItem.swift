//
//  GridMockItem.swift
//  MyAnswer
//
//  Created by Son Le on 11/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77464447/is-that-possible-to-scroll-a-lazyvgrid-to-show-a-particular-item-in-the-middle
struct MockData: Identifiable {
    var id = UUID()
    var title: String
    
    static func createElements() -> [MockData] {
        var res = [MockData]()
        for i in 0..<200 {
            res.append(MockData(title: "\(i)"))
        }
        return res
    }
}

struct GridMockItem: View {
    @Namespace var bottomID
    @Namespace var topID
    
    var items: [MockData]
    
    init(items: [MockData]) {
        self.items = items
    }
    
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), spacing: 0),
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), spacing: 0),
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), spacing: 0),
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), spacing: 0)
    ]
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack {
                Button {
                    withAnimation {
                        proxy.scrollTo(120, anchor: .center)
                    }
                } label: {
                    Text("Scroll")
                }
                
                ScrollView {
                    ZStack {
                        Color.blue
                        
                        LazyVGrid(
                            columns: columns,
                            alignment: .center,
                            spacing: 10,
                            pinnedViews: []
                        ) {
                            //Iterating by index
                            ForEach(0..<items.count, id: \.self) { i in
                                Text(items[i].title)
                                    .listRowBackground(Color.clear)
                                    .id(i) //<- put index here
                                    .padding(.horizontal, 15)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
        }
    }
}

struct GridMockItem_Previews: PreviewProvider {
    static var previews: some View {
        GridMockItem(items: MockData.createElements())
    }
}
