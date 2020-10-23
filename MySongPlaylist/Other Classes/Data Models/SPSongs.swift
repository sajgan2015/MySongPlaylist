//
//  SPSongsRealm.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import RealmSwift
import SwiftyXMLParser
class SPSongs: Object {
    @objc dynamic var title = ""
    @objc dynamic var imageSongURL = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var price = ""
    @objc dynamic var artistName = ""
    @objc dynamic var rights = ""
    @objc dynamic var songPlayLink = ""


    func setupData(with xmlAccessor:XML.Accessor, index:Int)
    {
        self.title = xmlAccessor.feed.entry[index].title.text ?? ""
        self.imageSongURL = xmlAccessor["feed", "entry", index, "im:image", 2].text ?? ""
        self.rights = xmlAccessor.feed.entry[index].rights.text ?? ""
        self.price = xmlAccessor["feed", "entry", index, "im:price"].text ?? ""
        self.artistName = xmlAccessor["feed", "entry", index, "im:artist"].text ?? ""
        self.releaseDate = xmlAccessor["feed", "entry", index, "im:releaseDate"].text ?? ""
        self.songPlayLink = xmlAccessor.feed.entry[index].link[1].attributes["href"] ?? ""
        
    }
}

