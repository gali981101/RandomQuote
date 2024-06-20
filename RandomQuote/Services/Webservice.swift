//
//  Webservice.swift
//  RandomQuote
//
//  Created by Terry Jason on 2024/6/20.
//

import Foundation

// MARK: - NetworkError

enum NetworkError: Error {
    case badUrl
    case invalidImageId(Int)
    case decodingError
}

// MARK: - Webservice

enum Webservice {
    
    // MARK: - RandomImages
    
    static func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        var randomImages: [RandomImage] = []
        
        try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
            for id in ids {
                group.addTask {
                    return (id, try await getRandomImage(id: id))
                }
            }
            
            for try await (_, randomImage) in group {
                randomImages.append(randomImage)
            }
        }
        
        return randomImages
    }
    
    // MARK: - RandomImage
    
    static func getRandomImage(id: Int) async throws -> RandomImage {
        
        guard let imageUrl = K.Urls.getRandomImageUrl() else {
            throw NetworkError.badUrl
        }
        
        guard let quoteUrl = K.Urls.randomQuoteUrl else {
            throw NetworkError.badUrl
        }
        
        async let (imageData, _) = URLSession.shared.data(from: imageUrl)
        async let (quoteData, _) = URLSession.shared.data(from: quoteUrl)
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await quoteData) else {
            throw NetworkError.decodingError
        }
        
        return RandomImage(image: try await imageData, quote: quote)
        
    }
    
}
