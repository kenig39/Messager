//
//  DataBaseManage.swift
//  Messagers
//
//  Created by Alexander on 13.02.2024.
//

import Foundation
import FirebaseDatabase


final class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    
   
}
//Mark: - Accoun manager

extension DataBaseManager {
    
    public func userExist(with email: String,
                          complition: @escaping((Bool) -> Void)){
        database.child(email).observeSingleEvent(of: .value, with: {snapShot in
            guard snapShot.value as? String != nil else {
                complition(false)
                return
            }
            complition(true)
        })
    }
    
    /// inserts new user to daatabase
    public func insertUser(with user: ChatAppUser){
        database.child(user.emailAddres).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddres: String
  //  let profilePictureUrl: URL
}
