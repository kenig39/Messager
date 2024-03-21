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
                          complition: @escaping((Bool) -> Void)) {
        
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
        ], withCompletionBlock: {[weak self] error, _ in
            
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("failed ot write to dataBase")
                complition(false)
                return
            }
            
            strongSelf.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                if var usersCollections = snapshot.value as? [[String: String]] {
                    // append to user dictionary
                    let newElement = [
                        "name": user.firstName + " " + user.lastName,
                        "email": user.safeEmail
                    ]
                    usersCollections.append(newElement)
                    
                    strongSelf.database.child("users").setValue(usersCollections, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            complition(false)
                            return
                        }
                        complition(true)
                    })
                }
                else {
                    //create that array
                    let newCollection: [[String: String]] = [
                        
                        [
                         "name": user.firstName + " " + user.lastName,
                         "email": user.safeEmail
                        ]
                        
                    ]
                    
                    strongSelf.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            complition(false)
                            return
                        }
                        complition(true)
                    })
                }
            })
            
        })
    }
    
    
    public func getAllUsers(completion: @escaping(Result<[[String: String]], Error>) -> Void){
        database.child("users").observeSingleEvent(of: .value, with: {snapshot in
            guard let value = snapshot.value as? [[String: String]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
        })
    }
    
    public enum DatabaseError: Error {
        case failedToFetch
    }
}
// MARK: - sending messages / conversation
extension DataBaseManager {
    
    //create new conversation with target user email
  public func  createNewConversation(with otherUserEmail:String, firstMessage: Message, completion: @escaping(Bool) -> Void ) {
        
    }
    
    ///Fetches and returns all conversation for user with passed in email
    public func getAllConversations(for email: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    
    public func getAllMessagesForConversation(with id: String, complition: @escaping(Result<String, Error>) -> Void) {
        
    }
    
    /// send a message with target for a given
    public func sendMessage(to conversation: String, message: Message, comptletion: @escaping(Bool) -> Void) {
        
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

