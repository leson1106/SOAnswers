//
//  TileDetailView.swift
//  MyAnswer
//
//  Created by Son Le on 17/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77500037/how-to-put-a-custom-binding-object-in-preview-in-swiftui
struct Tile {
    var name: String
}

struct TileDetailView: View {
    @Binding var tile: Tile
    @Binding var isShowingTileDetail: Bool
    
    var body: some View {
        Text("Hello \(tile.name)")
    }
}

struct TileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TileDetailView(
            tile: .constant(Tile.init(name: "Tile here")),
            isShowingTileDetail: .constant(false)
        )
    }
}
