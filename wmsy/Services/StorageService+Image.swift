//
//  StorageService+Image.swift
//  wmsy
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import Toucan
import FirebaseStorage

extension StorageService {
    func storeImage(_ image: UIImage, imageID: String) -> StorageUploadTask? {
        let ref = getImagesRef().child(imageID)
        guard let resizedImage = Toucan(image: image).resize(CGSize(width: 500, height: 500)).image, let imageData = UIImageJPEGRepresentation(resizedImage, 0.5) else {
            return nil
        }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        return ref.putData(imageData, metadata: metaData, completion: { (storageMetaData, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
    public func storeUserImage(image: UIImage?, userID: String) {
        guard let image = image else {
            print("no image")
            return
        }
        guard let uploadTask = StorageService.manager.storeImage(image, imageID: userID) else {
            print("error uploading image")
            return
        }
        uploadTask.observe(.success) { (taskSnapshot) in
            guard let downloadURL = taskSnapshot.metadata?.downloadURL() else {
                print("could not download image")
                return
            }
            let downloadURLStr = downloadURL.absoluteString
            DBService.manager.addImageToUser(url: downloadURLStr, userID: userID)
        }
        
    }
    
    
    
    
    
}
