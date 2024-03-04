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
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
   
    
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
    public func insertUser(with user: ChatAppUser, complition: @escaping (Bool) -> Void){
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ], withCompletionBlock: { error, _ in
            guard error == nil else {
                print("failed ot write to dataBase")
                complition(false)
                return
            }
            
            self.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                
                
            })
            
            complition(true)
        })
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddres: String
  
    
    var safeEmail: String {
        var safeEmail = emailAddres.replacingOccurrences(of: ".", with: "_")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "_")
        return safeEmail
    }
    
    var profilePictureFilenmae: String {
        return "\(safeEmail)_profile_picture.png"
    }
}
