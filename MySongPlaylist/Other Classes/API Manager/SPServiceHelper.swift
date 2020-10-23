//
//  ServiceHelper.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import Foundation
import Moya

enum SPServiceHelper {
    case songPlaylistRequest(parameters: [String: Any])
}

extension SPServiceHelper: TargetType {
    
    var task: Task {
        switch self {
        case .songPlaylistRequest(let parameters):
            return .requestParameters(parameters: parameters, encoding: self.parameterEncoding)
        }
    }
    
    var baseURL: URL {
        return URL(string: SPConstants.WS_URL.BASE_URL)!
    }
    
    /// The headers to be used in the request.
    var headers: [String: String]? {
        return ["Content-Type": "application/xml"]
    }
    
    /// MARK: - path
    var path: String {
        switch self {
        case .songPlaylistRequest:
            return SPConstants.Request_Endpoints.topSongs
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .songPlaylistRequest:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .songPlaylistRequest:
            return URLEncoding.queryString
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}
