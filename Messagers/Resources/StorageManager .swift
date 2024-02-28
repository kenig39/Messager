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
        storage.child("")
    }
}
