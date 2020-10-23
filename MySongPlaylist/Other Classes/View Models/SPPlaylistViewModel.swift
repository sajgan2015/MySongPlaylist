//
//  SPPlaylistViewModel.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import Foundation
import SwiftyXMLParser

class SPPlaylistViewModel: NSObject {
    var objSongPlaylist:SPSongPlaylist?
    
    /// Call API to fetch top headline
    /// - Parameters:
    ///   - completion: completion description
    public func callGetSongPlaylistAPI(completion: @escaping () -> Void) {

        Network.callAPIWithRequest(target: .songPlaylistRequest(parameters: [:]), success: { objData in
            if let dataResponse = objData {
                let xml = XML.parse(dataResponse)
                print(xml.feed.entry[0].title.text)
                self.objSongPlaylist = SPSongPlaylist()
                self.objSongPlaylist?.setupData(xmlAccessor: xml)
                SPDBManager.shared.saveData(object: self.objSongPlaylist ?? SPSongPlaylist())
            }
            completion()
            }, failure: { _ in })
    }
}
