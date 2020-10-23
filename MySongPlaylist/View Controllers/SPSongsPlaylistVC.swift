//
//  ViewController.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/22/20.
//

import UIKit

class SPSongsPlaylistVC: UIViewController {
    let objPlayListViewModel = SPPlaylistViewModel()
    @IBOutlet weak var tblVwSongPlaylist:UITableView?
    //Mark :- View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        performDefaultSetupOrFetch()
        // Do any additional setup after loading the view.
    }

    //Mark :- Customr Methods or Actions
    func performDefaultSetupOrFetch()
    {
        self.tblVwSongPlaylist?.tableFooterView = UIView()
        fetchTheSongPlaylist()
    }
    
    func fetchTheSongPlaylist(isShowLoader: Bool = true) {
        let arrResult = SPDBManager.shared.getDataFromDB()
        if arrResult.count > 0
        {
            objPlayListViewModel.objSongPlaylist = arrResult[0]
            self.title = objPlayListViewModel.objSongPlaylist?.playListTitle
            self.tblVwSongPlaylist?.reloadData()
        }
        else
        {
            objPlayListViewModel.callGetSongPlaylistAPI {
                DispatchQueue.main.async {
                    self.tblVwSongPlaylist?.reloadData()
                    self.title = self.objPlayListViewModel.objSongPlaylist?.playListTitle
                }
            }
        }
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SPConstants.Segues.ShowSongDetails
        {
            let objSongDetailsVC = segue.destination as! SPSongDetailsVC
            if let objSongToSet = sender as? SPSongs
            {
                objSongDetailsVC.objSongSelected = objSongToSet
            }
        }
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SPSongsPlaylistVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objPlayListViewModel.objSongPlaylist?.songs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SPSongsCell.identifier, for: indexPath) as? SPSongsCell
        if let objSong = self.objPlayListViewModel.objSongPlaylist?.songs[indexPath.row] {
            cell?.setUp(objSong: objSong)
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SPConstants.Segues.ShowSongDetails, sender: self.objPlayListViewModel.objSongPlaylist?.songs[indexPath.row])
    }
}





