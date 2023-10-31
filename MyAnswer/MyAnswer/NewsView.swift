//
//  NewsView.swift
//  MyAnswer
//
//  Created by Son Le on 31/10/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77393276/how-to-use-all-the-empty-space-in-ui-to-fill-with-text/77393359#77393359
struct NewsContent: Identifiable {
    var id = UUID()
    var username = ""
    var title = ""
    
    init(username: String, title: String) {
        self.username = username
        self.title = title
    }
}

struct NewsViewModel: Identifiable {
    var id = UUID()
    
    var news: [NewsContent] = [
        .init(username: "ethixltd", title: "I cannot figure out why my text is cutting off in the middle, instead of using the whole space in the green rectangle. What am I missing?"),
        .init(username: "ethixltd", title: "I cannot figure out why my text is cutting off in the middle, instead of using the whole space in the green rectangle. What am I missing?")
    ]
}

struct NewsView: View {
    var viewModel: NewsViewModel = .init()
    
    @State var input: String
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Button("Clear") {
//                        viewModel.clearHistory()
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.red)
                    .cornerRadius(8)
                    .frame(width: 100, alignment: .leading)
                    
                    ForEach(viewModel.news) { content in
                        HStack(alignment: .top, spacing: 0) {
                            Image("")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image("")
                                        .frame(width: 20, height: 20)
                                        .clipShape(Circle())
                                    if let username = content.username {
                                        Text(username)
                                            .font(.system(size: 12))
                                            .foregroundColor(.white)
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .trailing) {
                                        HStack(spacing: 5) {
                                            if let title = content.title {
                                                Button(action: {
                                                    UIPasteboard.general.string = ""
                                                }) {
                                                    Text("Copy")
                                                        .font(.system(size: 12))
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal, 6)
                                                        .padding(.vertical, 2)
                                                        .background(Color.blue)
                                                        .cornerRadius(8)
                                                }
                                            }
                                            
                                            Button(action: {
//                                                if let videoSrc = content.videoSrc, let url = URL(string: videoSrc) {
//                                                    videoDownloader.downloadVideo(from: url)
//                                                }
                                            }) {
                                                Image(systemName: "arrow.down.circle.fill")
                                                    .foregroundColor(.blue)
                                                    .font(.system(size: 20))
                                            }
                                        }
                                    }
                                }
                                
                                if let title = content.title {
                                    Text(title)
                                        .font(.system(size: 12))
                                        .foregroundColor(.white)
                                        .lineLimit(5)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }
                }
                .padding([.horizontal, .top])
            }
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.15, green: 0.15, blue: 0.15))
//                    TextField("Enter URL", text: $urlString)
                    TextField("Enter URL", text: $input)
                        .foregroundColor(Color.white.opacity(0.7))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white, lineWidth: 0.5))
                .frame(height: 36)
                
                Button("Load") {
//                    viewModel.loadPage(urlString: urlString)
//                    urlString = ""
                }
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue)
                .cornerRadius(8)
                .frame(height: 36)
            }
            .padding()
            
        }
        .padding(.vertical)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(viewModel: NewsViewModel(), input: "")
    }
}
