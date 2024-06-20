//
//  RandomImageListVM.swift
//  RandomQuote
//
//  Created by Terry Jason on 2024/6/20.
//

import UIKit

// MARK: - RandomImageListVM

@MainActor
final class RandomImageListVM: ObservableObject {
    
    // MARK: - Properties
    
    @Published var randomImages: [RandomImageVM] = []
}

// MARK: - RandomImageListVM Methods

extension RandomImageListVM {
    
    func getRandomImages(ids: [Int]) async {
        randomImages = []
        
        do {
            try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
                for id in ids {
                    group.addTask {
                        return (id, try await Webservice.getRandomImage(id: id))
                    }
                }
                
                for try await (_, randomImage) in group {
                    randomImages.append(RandomImageVM(randomImage: randomImage))
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}

// MARK: - RandomImageVM

struct RandomImageVM: Identifiable {
    
    let id: UUID = UUID()
    
    fileprivate let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
    
}

