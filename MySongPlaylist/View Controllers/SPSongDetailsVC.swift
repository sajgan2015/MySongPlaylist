//
//  SPSongDetailsVC.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import UIKit
import AVFoundation

class SPSongDetailsVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblCopyrights: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var imgVwSong: UIImageView!
    @IBOutlet weak var btnPlaySong: UIButton!
    var audioPlayer = AVAudioPlayer()
    var objSongSelected: SPSongs?

    //Mark :- View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        performDefaultSetupOrFetch()
        // Do any additional setup after loading the view.
    }

    //Mark :- Customr Methods or Actions
    func performDefaultSetupOrFetch()
    {
        guard let objSongToSet = objSongSelected else { return }
        btnPlaySong.layer.cornerRadius = 8
        btnPlaySong.clipsToBounds = true
        
        imgVwSong.setImageUsingKF(string: objSongToSet.imageSongURL)
        lblTitle.text = objSongToSet.title
        lblArtist.text = objSongToSet.artistName
        lblCopyrights.text = objSongToSet.rights
        lblPrice.text = objSongToSet.price
        lblReleaseDate.text = SPUtility.shared.convertDateInFormat(objSongToSet.releaseDate, fromFormate: SPConstants.DateFormats.serverFormat, toFormate: SPConstants.DateFormats.releaseDateFormat)
    }
    
    @IBAction func actionOnPlaySong(sender:UIButton)
    {
        guard let objSongToSet = objSongSelected else { return }
        if let urlToDownload = URL.init(string: objSongToSet.songPlayLink)
        {
            self.downloadFileFromURL(urlToDownload: urlToDownload)
        }
    }
    
    func downloadFileFromURL(urlToDownload:URL){
        DispatchQueue.global().async {
            var downloadTask:URLSessionDownloadTask
            downloadTask = URLSession.shared.downloadTask(with: urlToDownload, completionHandler: { [weak self](url, response, error) -> Void in
                self?.playSong(urlToPlay: url ?? urlToDownload)
            })

            downloadTask.resume()
        }
    }
    
    func playSong(urlToPlay:URL) {
        print("playing \(urlToPlay)")
        DispatchQueue.main.async {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: urlToPlay)

                if self.btnPlaySong.isSelected
                {
                    self.audioPlayer.pause()
                    self.btnPlaySong.isSelected = false
                }
                else
                {
                    self.audioPlayer.play()
                    self.btnPlaySong.isSelected = true
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            } catch {
                print("AVAudioPlayer init failed")
            }

        }
       
    }

}
