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
                ForEach(searchResults, id: \.id) {item in
                    buildRow(isAlbumRow: item.artistName != "placeholder01", item: item)
                }
            }
            .refreshable {
                await fetchData()
            }
            //            .task {
            //                await fetchData()
            //            }
            
            .searchable(text: $searchText) {
                ForEach(searchResults, id: \.id) { result in
                    Text("Are you looking for \(result.collectionName ?? "")?")
                        .searchCompletion(result.collectionName ?? "")
                }
                .disabled(isOnPlaceholder ? true: false)
                
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
    
    // MARK: BINDING
    private func binding(for album: AlbumItem) -> Binding<AlbumItem> {
        guard let albumIndex = albumList.firstIndex(where: { $0.id == album.id }) else {
            fatalError("Can't find album in array")
        }
        return $albumList[albumIndex]
    }
    
    //MARK: VIEW BUILDER
    @ViewBuilder func buildRow(isAlbumRow: Bool, item: AlbumItem) -> some View {
        if isAlbumRow {
            NavigationLink(destination: AlbumDetailView(album: binding(for: item))) {
                AlbumRow(album: item)
                    .id(item.id)
                    .redacted(reason: isOnPlaceholder ? .placeholder : [])
            }
            .disabled(isOnPlaceholder ? true : false)
            .swipeActions {
                Button("Remove", role: .destructive) {
                    albumList.removeAll(where: { $0.id == item.id})
                }
            }
        } else {
            Text("⬇️Pull to refresh⬇️")
        }
        
        
    }
}

#Preview {
    AlbumListView()
}
