//
//  SPDBManager.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import RealmSwift
class SPDBManager {
    private var objRealm:Realm
    static let  shared = SPDBManager()
    private init() {
        objRealm = try! Realm()
    }
    
    func setDefaultRealmForUser() {
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("SongPlaylist.realm")
        print("Database Path: \(String(describing: config.fileURL))")
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    func getDataFromDB() -> Results<SPSongPlaylist> {
        let results: Results<SPSongPlaylist> =   objRealm.objects(SPSongPlaylist.self)
        return results
    }
    
    func saveData(object: SPSongPlaylist)   {
        try! objRealm.write {
            objRealm.add(object)
        }
    }
    func deleteAllFromDatabase()  {
        try!   objRealm.write {
            objRealm.deleteAll()
        }
    }
    func deleteFromDb(object: SPSongPlaylist)   {
        try!   objRealm.write {
            objRealm.delete(object)
        }
    }
}
