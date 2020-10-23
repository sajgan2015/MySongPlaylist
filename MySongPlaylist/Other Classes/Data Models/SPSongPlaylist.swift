//
//  SPSongPlaylistRealm.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import RealmSwift
import SwiftyXMLParser

class SPSongPlaylist: Object {
    @objc dynamic var playListTitle = ""
    @objc dynamic var authorName = ""
    @objc dynamic var authorURL = ""
    @objc dynamic var rights = ""
    let songs = List<SPSongs>()


    func setupData(xmlAccessor:XML.Accessor)
    {
        self.playListTitle = xmlAccessor.feed.title.text ?? ""
        self.authorName = xmlAccessor.feed.author.element?.childElements[0].text ?? ""
        self.authorURL = xmlAccessor.feed.author.element?.childElements[1].text ?? ""
        self.rights = xmlAccessor.feed.rights.text ?? ""
        if let arrFiltered = xmlAccessor.feed.element?.childElements.filter({$0.name == "entry"})
        {
            for index in 0..<arrFiltered.count
            {
                let objSong = SPSongs()
                objSong.setupData(with: xmlAccessor, index: index)
                songs.append(objSong)
            }
        }
        
    }
}

