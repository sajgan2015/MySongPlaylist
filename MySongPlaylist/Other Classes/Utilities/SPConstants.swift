//
//  SPConstants.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import Foundation

struct SPConstants {
    
    struct WS_URL {
        static let BASE_URL = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/"
    }
    
    struct Request_Endpoints {
        static let topSongs = "topsongs/limit=20/xml"
    }
    
    struct Segues {
        static let ShowSongDetails = "ShowSongDetailsVC"
    }
    
    struct DateFormats {
        static let serverFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let releaseDateFormat = "dd MMM, yyyy h:mm a"
    }

}

