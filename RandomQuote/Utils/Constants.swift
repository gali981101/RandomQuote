//
//  Constants.swift
//  RandomQuote
//
//  Created by Terry Jason on 2024/6/20.
//

import Foundation

// MARK: - K

enum K {
    
    static let appname = "Random Quotes"
    static let circleImage = "arrow.clockwise.circle"
    
    // MARK: - Urls
    
    enum Urls {
        static func getRandomImageUrl() -> URL? {
            return URL(string: "https://picsum.photos/200/300?uuid=\(UUID().uuidString)")
        }
        
        static let randomQuoteUrl: URL? = URL(string: "https://api.quotable.io/random")
    }
    
}
