//
//  ApiManager.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 10.06.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    static let shared = APIManager()
    
    private func configureDB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func getPost(collection: String, docName: String, completion: @escaping (Document?) -> Void) {
        let db = configureDB()
        db.collection(collection).document().getDocument { document, error in
            guard error == nil else { completion(nil); return }
            let doc = Document(name: document?.get("name") as! String, description: document?.get("description") as! String, price: document?.get("price") as! Int)
            completion(doc)
        }
    }
    
    func getImage(picName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("pictures")
        
        var image: UIImage = UIImage(named: "sneakers1")!
        
        let fireRef = pathRef.child(picName + ".png")
        fireRef.getData(maxSize: 1920 * 1920) { data, error in
            guard error == nil else { completion(image); return }
            image = UIImage(data: data!)!
            completion(image)
        }
    }
}
