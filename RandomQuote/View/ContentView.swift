//
//  ContentView.swift
//  RandomQuote
//
//  Created by Terry Jason on 2024/6/20.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @StateObject private var randomImageListVM = RandomImageListVM()
    
}

// MARK: - View

extension ContentView {
    
    var body: some View {
        NavigationView {
            List(randomImageListVM.randomImages) { randomImage in
                HStack {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Text(randomImage.quote)
                }
            }
            .task {
                await randomImageListVM.getRandomImages(ids: Array(100...120))
            }
            .navigationTitle(K.appname)
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await randomImageListVM.getRandomImages(ids: Array(100...120))
                }
            }, label: {
                Image(systemName: K.circleImage)
            }))
        }
    }
    
}

// MARK: - Preview

#Preview {
    ContentView()
}
