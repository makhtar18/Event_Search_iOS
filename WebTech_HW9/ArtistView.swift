//
//  ArtistView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 30/04/23.
//

import SwiftUI
import Kingfisher

struct ArtistView: View {
    var musicRelatedArtists: MusicRelatedArtists
    var spotifyAlbumnImages: [SpotifyAlbumnResponse]
    var recColor = #colorLiteral(red: 0.3615253568, green: 0.3615253568, blue: 0.3615253568, alpha: 1)
    var followersText: String{
        var followerCount = (musicRelatedArtists.followers.total/1000000)
        if(followerCount != 0){
            return "\(followerCount)M"
        }
        else {
            followerCount = (musicRelatedArtists.followers.total/1000)
            return "\(followerCount)K"
        }
    }
    var body: some View {
        
            VStack() {
                VStack(){
                    HStack{
                        KFImage(URL(string: musicRelatedArtists.images[0].url))
                            .resizable()
                            .frame(width: 130, height: 130)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .padding(1)

                        VStack{
                            HStack {
                                Text(musicRelatedArtists.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                Spacer()
                            }
                            Spacer()
                            HStack{
                                Text("\(followersText)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                Text("Followers")
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Link(destination: URL(string: musicRelatedArtists.external_urls.spotify)!) {
                                        Image("spotify_logo")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .aspectRatio(contentMode: .fit)
                                        Text("Spotify")
                                        .foregroundColor(Color.green)
                                }
                                Spacer()
                            }
                            
                        }
                        .frame(width: 131 ,height: 130)
                        VStack{
                            Text("Popularity")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            ProgressBar(progress: Double(musicRelatedArtists.popularity))
                                .frame(width: 70)
                            Spacer()
                        }
                        .frame(height: 130)
                    }
                    HStack {
                        Text("Popular Albumns")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                        Spacer()
                    }.frame(width: 380)
                    HStack{
                        KFImage(URL(string: spotifyAlbumnImages[0].images[0].url))
                            .resizable()
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .padding(1)
                        KFImage(URL(string: spotifyAlbumnImages[1].images[0].url))
                            .resizable()
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .padding(1)
                        KFImage(URL(string: spotifyAlbumnImages[2].images[0].url))
                            .resizable()
                            .frame(width: 120, height: 120)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .padding(1)
                    }
                }
            }
            .frame(width: 400, height: 330)
            .background(Color(recColor))
            .cornerRadius(10)
            .padding(20)
        
    }
}

struct ArtistView_Previews: PreviewProvider {
    static var previews: some View {
        var musicRelatedArtists = MusicRelatedArtists(external_urls: External_urls(spotify: "https://open.spotify.com/artist/1KCSPY1glIKqW2TotWuXOR"), followers: Followers(total: 115020813
), name: "P!nk", popularity: 83, images: [Images(height: 640, url: "https://i.scdn.co/image/ab6761610000e5eb7bbad89a61061304ec842588", width: 640)], id: "1KCSPY1glIKqW2TotWuXOR")
        
        ArtistView(musicRelatedArtists: musicRelatedArtists , spotifyAlbumnImages: [SpotifyAlbumnResponse(images:[Images(height: 640, url: "https://i.scdn.co/image/ab67616d0000b2735b8cf73dd4eebd286d9a2c78", width: 640)]), SpotifyAlbumnResponse(images:[Images(height: 640, url: "https://i.scdn.co/image/ab67616d0000b2735b8cf73dd4eebd286d9a2c78", width: 640)]), SpotifyAlbumnResponse(images:[Images(height: 640, url: "https://i.scdn.co/image/ab67616d0000b2735b8cf73dd4eebd286d9a2c78", width: 640)])])
    }
}
