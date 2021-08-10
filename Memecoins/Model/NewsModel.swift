//
//  NewsModel.swift
//  Memecoins
//
//  Created by Alex Paul on 8/6/21.
//

import Foundation


// MARK: - NewDataModel
struct NewDataModel: Codable, Hashable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
struct Article: Codable,Hashable,Equatable {
    let source: Source?
    let author, title, articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}
// MARK: - Source

struct Source: Codable, Hashable {
    let id: String?
    let name: String?
    
}
