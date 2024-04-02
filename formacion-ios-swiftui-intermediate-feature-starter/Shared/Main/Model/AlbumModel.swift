//
//  AlbumModel.swift
//  SwiftUI-Intermediate
//
//  Created by Daniel Ayala on 3/3/22.
//

import Foundation

// MARK: ENTITY
struct AlbumItemEntity: Codable {
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: String?
    let primaryGenreName: String?
    let releaseDate: String?
    let collectionViewUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName, collectionName, artworkUrl100, primaryGenreName, releaseDate, collectionViewUrl
    }
}

struct AlbumsListEntity: Codable {
    var results: [AlbumItemEntity]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: DOMAIN
struct AlbumItem:  Identifiable, Hashable {
    let id = UUID()
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: String?
    let primaryGenreName: String?
    let releaseDate: String?
    var isOnFavourites = false
    var isSelected = false
    let collectionViewUrl: String?
    
    var formattedDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: releaseDate ?? "") ?? Date()
    }
    
    static let placeholderMock: [AlbumItem] =
    [AlbumItem(artistName: "placeholder01", collectionName: nil, artworkUrl100: nil, primaryGenreName: nil, releaseDate: nil, collectionViewUrl: nil), AlbumItem(artistName: "Lorem Ipsum", collectionName: "The Best of Marvin Gaye", artworkUrl100: nil, primaryGenreName: nil, releaseDate: nil, collectionViewUrl: nil), AlbumItem(artistName: "Lorem Ipsum", collectionName: "The Best of Marvin Gaye", artworkUrl100: nil, primaryGenreName: nil, releaseDate: nil, collectionViewUrl: nil), AlbumItem(artistName: "Lorem Ipsum", collectionName: "The Best of Marvin Gaye", artworkUrl100: nil, primaryGenreName: nil, releaseDate: nil, collectionViewUrl: nil)]
}

// MARK: OBSERVABLE
class FavouriteAlbums: ObservableObject {
    @Published var albumList: [AlbumItem] = []
}

