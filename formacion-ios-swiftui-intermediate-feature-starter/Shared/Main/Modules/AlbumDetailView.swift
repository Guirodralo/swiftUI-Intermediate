//
//  AlbumDetailView.swift
//  SwiftUI-Intermediate (iOS)
//
//  Created by Guillermo Rodríguez ALonso on 4/4/24.
//

import SwiftUI

struct AlbumDetailView: View {
    @Binding var album: AlbumItem
    @State private var showAction = false
    @State var shouldShowFavouriteButton = true
    
    
    var body: some View {
        //MARK: GEOMETRY READER GET VSTACK SIZE AND SETS IMAGE FRAME
        GeometryReader { geo in
            
            VStack {
                AsyncImage(url: URL(string: album.artworkUrl100 ?? "")) {image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Image("albumCover")
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: geo.size.width - 32, height: geo.size.width - 32)
                .clipShape(Circle())
                
                Spacer()
                
                //MARK: SET ITEM ON FAVOURITE ALBuMS ENVIROMENT OBJECT
                Button {
                    //PDTE Enviroment Object
                } label: {
                    if shouldShowFavouriteButton {
                        Image(systemName: album.isOnFavourites ? "heart.fill" : "heart")
                            .font(.system(size: 60))
                            .foregroundStyle(.red)
                    }
                }
                .buttonStyle(ScaleButtonStyle())
                
                
                Spacer()
                
                //MARK: ALBUM DESCRIPTION
                VStack(alignment: .leading, spacing: 16) {
                Text("collection Name: ").foregroundColor(.secondary) + Text(album.collectionName ?? "") .bold()
                Text("Album Date: ").foregroundColor(.secondary) + Text(album.formattedDate, style: .date) .bold()
                Text("Genere: ").foregroundColor(.secondary) + Text(album.primaryGenreName ?? "") .bold()
                    Link(destination: URL(string: album.collectionViewUrl ?? "https://www.apple.com/es/itunes/")!, label: {
                        Text("Open in iTunes")
                            .foregroundColor(.blue)
                    })
                }.frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
            .padding()
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AlbumDetailView (album: .constant(AlbumItem(artistName: "", collectionName: "", artworkUrl100: "", primaryGenreName: "", releaseDate: "", collectionViewUrl: "")))
}
