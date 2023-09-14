//
//  UserService.swift
//  UsingFrameworkMoya
//
//  Created by Murtazaev Mirjaloliddin Kamolovich on 14/09/23.
//

import Foundation
import Moya

enum UserService {
    case createUser(name: String)
    case readUser
    case updateUser(id:Int, name: String)
    case deleteUseer(id: Int)
}

extension UserService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .readUser, .createUser(_):
            return "/Users"
        case .updateUser( let id, _), .deleteUseer(let id):
            return "/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createUser(_):
            return .post
        case .readUser:
               return .get
        case .updateUser(_, _):
            return .put
        case .deleteUseer(_):
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .readUser, .deleteUseer(_):
            return .requestPlain
        case .createUser(let name), .updateUser(_, let name):
            return .requestParameters(parameters: ["name" : name], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Conent": "application/json"]
    }
}
