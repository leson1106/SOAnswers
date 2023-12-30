//
//  VerticalPagination.swift
//  MyAnswer
//
//  Created by Son Le on 29/12/2023.
//

import SwiftUI

struct VerticalPagination: View {
    var colors: [Color] = [
        .red, .orange, .blue, .yellow
    ]

    var body: some View {
        TabView {
            GeometryReader { geo in
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach(0 ..< 100) { i in
                            ZStack {
                                Rectangle()
                                    .fill(colors[i % colors.count].opacity(0.6))
                                Text("Video \(i + 1)")
                                    .font(.title)
                                    .bold()
                            }
                            .frame(height: geo.size.height + geo.safeAreaInsets.top)
                            .padding(.bottom, geo.safeAreaInsets.bottom)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                .ignoresSafeArea(.container, edges: [.top, .bottom])
            }
        }
    }
}

#Preview {
    VerticalPagination()
}
