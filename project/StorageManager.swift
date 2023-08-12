//
//  StorageManager.swift
//  project
//
//  Created by Nazar Kopeika on 21.06.2023.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let container = Storage.storage()
    private let storage = Storage.storage()

    
    private init() {}
    
//    public func uploadUserProfilePicture(
//        email: String,
//        image: UIImage?,
//        completion: @escaping (Bool) -> Void
//    ) {
//        let path = email
//            .replacingOccurrences(of: "@", with: "_")
//            .replacingOccurrences(of: ".", with: "_")
//
//        guard let pngData = image?.pngData() else {
//            return
//        }
//
//        container
//            .reference(withPath: "profile_pictures/\(path)/photo.png")
//            .putData(pngData, metadata: nil) { metadata, error in
//                guard metadata != nil, error == nil else {
//                    completion(false)
//                    return
//                }
//                completion(true)
//            }
//    }
    

    func uploadUserProfilePicture(email: String, image: UIImage, completion: @escaping (Bool) -> Void) {
            guard let data = image.pngData() else {
                completion(false)
                return
            }

            let fileName = "\(email)_profile_picture.png"

            let storageRef = storage.reference().child("profile_pictures/\(fileName)")

            let metadata = StorageMetadata()
            metadata.contentType = "image/png" // Замените на соответствующий тип изображения

            storageRef.putData(data, metadata: metadata) { metadata, error in
                completion(error == nil)
            }
        }
    
    public func downloadUrlForProfilePicture(
        path: String,
        completion: @escaping (URL?) -> Void
    ) {
        container.reference(withPath: path)
            .downloadURL { url, _ in
                completion(url)
            }
    }
}
