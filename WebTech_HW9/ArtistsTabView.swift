//
//  ArtistsTabView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 29/04/23.
//

import SwiftUI

struct ArtistsTabView: View {
    var musicRelatedArtists: [MusicRelatedArtists]
    var spotifyAlbumnImages: [String: [SpotifyAlbumnResponse]]
    var body: some View {
        if(musicRelatedArtists.count==0){
            Text("No music related artist details to show")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        else {
            ScrollView{
                VStack(){
                    ForEach(musicRelatedArtists) { artist in
                        ArtistView(musicRelatedArtists: artist, spotifyAlbumnImages: spotifyAlbumnImages[artist.id]!)
                    }
                }
            }
            .padding(.top, 0.2)
        }
        
    }
}

struct ArtistsTabView_Previews: PreviewProvider {
    static var previews: some View {
        let musicRelatedArtists = MusicRelatedArtists(external_urls: External_urls(spotify: "https://open.spotify.com/artist/1KCSPY1glIKqW2TotWuXOR"), followers: Followers(total: 15020813
), name: "P!nk", popularity: 83, images: [Images(height: 640, url: "https://i.scdn.co/image/ab6761610000e5eb7bbad89a61061304ec842588", width: 640)], id: "1KCSPY1glIKqW2TotWuXOR")
        
        let spotifyAlbumnImages = ["1KCSPY1glIKqW2TotWuXOR":[SpotifyAlbumnResponse(images: [Images(height: 640, url: "https://i.scdn.co/image/ab67616d0000b2735b8cf73dd4eebd286d9a2c78", width: 640)]), SpotifyAlbumnResponse(images:[ Images(height: 640, url: "https://i.scdn.co/image/ab67616d0000b2735b8cf73dd4eebd286d9a2c78", width: 640)]), SpotifyAlbumnResponse(images:[Images(height: 640, url: "https://i.scdn.co/image/ab67616d0000b2735b8cf73dd4eebd286d9a2c78", width: 640)])]]
        
        ArtistsTabView(musicRelatedArtists: [musicRelatedArtists, musicRelatedArtists, musicRelatedArtists] , spotifyAlbumnImages: spotifyAlbumnImages)
    }
}
