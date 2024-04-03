//
//  SwiftUI_IntermediateApp.swift
//  Shared
//
//  Created by Daniel Ayala on 2/3/22.
//

import SwiftUI

@main
struct SwiftUI_IntermediateApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                
                AlbumListView()
                    .tabItem {
                        Label("Albums", systemImage: "list.dash")
                    }
                
                FavouritesListView()
                    .tabItem {
                        Label("Favourites", systemImage: "heart")
                    }
                
                
                
                NavigationView {
                    ProfileView()
                }
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            }
        }
    }
}
