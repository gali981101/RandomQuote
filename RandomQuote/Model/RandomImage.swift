//
//  RandomImage.swift
//  RandomQuote
//
//  Created by Terry Jason on 2024/6/20.
//

import Foundation

// MARK: - RandomImage

struct RandomImage: Decodable {
    let image: Data
    let quote: Quote
}

// MARK: - Quote

struct Quote: Decodable {
    let content: String
}

