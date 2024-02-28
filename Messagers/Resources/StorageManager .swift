//
//  StorageManager .swift
//  Messagers
//
//  Created by Alexander on 28.02.2024.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public typealias UploadPictureComplition = (Result<String, Error>) -> Void
    
    //Uploads picture to firebase storage and returns completion url string to download
    public func uploadProfilePicture(with data: Data,
                                     fileName: String,
                                     completion: @escaping UploadPictureComplition) {
        storage.child("images/\(fileName)").putData(data, metadata: nil) { metadata, error in
            guard error == nil else {
                //faled
                print("faled to upload data to firebase for picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            
            self.storage.child("images /\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("failed to downLoad url")
                    completion(.failure(StorageErrors.failedToDownLoadUrl))
                    return
                }
                
                let urlSrting = url.absoluteString
                print("downLoad url return: \(urlSrting)")
                completion(.success(urlSrting))
            }
        }
    }
    
    public enum StorageErrors:Error {
       case failedToUpload
       case failedToDownLoadUrl
    }
}
