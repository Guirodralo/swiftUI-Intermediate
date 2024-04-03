//
//  AlbumListView.swift
//  SwiftUI-Intermediate (iOS)
//
//  Created by Guillermo Rodríguez ALonso on 3/4/24.
//

import SwiftUI

struct AlbumListView: View {
    
    @State private var albumList = AlbumItem.placeholderMock
    @State private var searchText = ""
    @State private var isOnPlaceholder = true
    
    var searchResults: [AlbumItem] {
        if searchText.isEmpty {
            return albumList
        } else {
            return albumList.filter {
                ($0.collectionName ?? "").contains(searchText)
            }
        }
        
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(albumList, id: \.id) {item in
                    AlbumRow(album: item)
                }
            }
            .task {
                await fetchData()
            }
            .navigationTitle("Marvin Data")
        }
    }
    
    //MARK: ASYNC AWAIT
    private func fetchData() async {
        do {
            let url = URL(string: "https://itunes.apple.com/lookup?id=127329&entity=album")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let entityData: AlbumsListEntity = try JSONDecoder().decode(AlbumsListEntity.self, from: data)
            albumList = []
            
            if !entityData.results.isEmpty {
                entityData.results.forEach({albumList.append(AlbumItem(artistName: $0.artistName, collectionName: $0.collectionName, artworkUrl100: $0.artworkUrl100, primaryGenreName: $0.primaryGenreName, releaseDate: $0.releaseDate, collectionViewUrl: $0.collectionViewUrl))})
                isOnPlaceholder = false
            }
            
        }catch {
            // Error
            albumList = []
        }
    }
}

#Preview {
    AlbumListView()
}
