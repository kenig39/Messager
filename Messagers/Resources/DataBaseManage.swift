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
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "_")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "_")
        
       
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapShot in
            guard snapShot.value as? String != nil else {
                complition(false)
                return
            }
            complition(true)
        })
    }
    
    /// inserts new user to daatabase
    public func insertUser(with user: ChatAppUser){
        database.child(user.safeEmail).setValue([
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
    
    var safeEmail: String {
        var safeEmail = emailAddres.replacingOccurrences(of: ".", with: "_")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "_")
        return safeEmail
    }
}
