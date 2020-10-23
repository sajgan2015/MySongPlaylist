//
//  SPAPIManager.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.

//import Foundation
import Alamofire
import IHProgressHUD
import Moya

struct AlamofireManager {
    
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60.0           // Seconds
        configuration.timeoutIntervalForResource = 60.0          // Seconds
        return Alamofire.Session(configuration: configuration)
    }()
}

private let objMoyaProvider = MoyaProvider<SPServiceHelper>(session: AlamofireManager.shared)

class Network {
    
    /// - Parameters:
    ///   - target: Your API Target.
    ///   - successCallback: Success block.
    ///   - failureCallback: failure block.
    
    class func callAPIWithRequest(target: SPServiceHelper, shouldShowLoader: Bool = true, success successCallback: @escaping (_ response: Data?) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        print("==== URL ===== \(target.baseURL)")
        print("==== PATH ==== \(target.path)")
        print("==== METHOD ==== \(target.method.rawValue)")
        print("==== HEADER ==== \(target.headers ?? [:])")
        print("==== PARAMETER ==== \(target.task)")
        
        if shouldShowLoader {
            DispatchQueue.main.async {
                IHProgressHUD.show(withStatus: "Loading...")
            }
        }
        
        objMoyaProvider.request(target) { (result) in
            if shouldShowLoader {
                DispatchQueue.main.async {
                    IHProgressHUD.dismiss()
                }
            }

            switch result {
            case .success(let response):
                print(response.statusCode)
                switch response.statusCode {
                case 200...300:
                    successCallback(response.data)
                default:
                    break
                }
            case .failure(let error):
                print("")
                failureCallback(error)
            }
        }
    }
}

