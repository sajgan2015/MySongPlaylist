//
//  SPSongsCell.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import UIKit

class SPSongsCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgVwSong: UIImageView!
    
    
    // MARK: - Public Properties
    public static let identifier = "SongCell"
    
    // MARK: - Public Methods
    
    /// Configure your data on cell
    /// - Parameter data: data description
    public func setUp(objSong: SPSongs) {
        self.lblTitle.text = objSong.title
        self.imgVwSong.setImageUsingKF(string: objSong.imageSongURL)
    }
}
