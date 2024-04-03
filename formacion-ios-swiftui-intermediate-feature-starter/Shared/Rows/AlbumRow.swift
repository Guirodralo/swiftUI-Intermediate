//
//  AlbumRow.swift
//  SwiftUI-Intermediate (iOS)
//
//  Created by Guillermo Rodríguez ALonso on 3/4/24.
//

import SwiftUI

struct AlbumRow: View {
    
    let album: AlbumItem
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: album.artworkUrl100 ?? "")) {image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image("albumCover")
                    .resizable()
                    .scaledToFill()
            }
            .frame(maxWidth: 100, maxHeight: 100)
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
            
            //MARK: - Album Info
            VStack(alignment: .leading) {
                Text(album.artistName ?? "")
                    .font(.headline)
                
                Text(album.collectionName ?? "")
                    .foregroundStyle(.secondary)
                Image(systemName: album.isOnFavourites ? "heart.fill" : "heart")
            }
        }
    }
}

// MARK: - PREVIEW
struct AlbumRow_Previews: PreviewProvider {
    static var previews: some View {
        AlbumRow(album: AlbumItem(artistName: "Drake", collectionName: "Laugh now or cry later", artworkUrl100: "https://i.pinimg.com/originals/10/b8/8d/10b88d166dea481c94939731ac30ed21.jpg", primaryGenreName: "", releaseDate: "", collectionViewUrl: nil))
            .previewLayout(.sizeThatFits)
    }
}
