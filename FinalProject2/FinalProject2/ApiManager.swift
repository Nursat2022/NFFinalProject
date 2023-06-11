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
import FirebaseFirestore

class APIManager {
    static let shared = APIManager()
    
    func configureDB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
//    func getPost(collection: String, docName: String, completion: @escaping (Document?) -> Void) {
//        let db = APIManager.shared.configureDB()
//        let docRef = db.document("\(collection)/\(docName)")
//        docRef.getDocument { snapshot, error in
//            guard let data = snapshot?.data(), error == nil else {
//                completion(nil)
//                return }
//            guard let name = data["name"], error == nil else {
//                print("error name")
//                completion(nil)
//                return }
//            guard let description = data["description"], error == nil else {
//                completion(nil)
//                return }
//            guard let price = data["price"], error == nil else { return }
//            completion(Document(name: name as! String, description: description as! String, price: price as! Int))
//        }
//    }
    
    func getAllPosts(collection: String, completion: @escaping ([Document]?) -> Void) {
        let db = APIManager.shared.configureDB()
        let collectionRef = db.collection(collection)
        
        collectionRef.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                completion(nil)
                return
            }
            
            var allDocuments: [Document] = []
            
            for document in documents {
                let data = document.data()
                
                if let name = data["name"] as? String,
                   let description = data["description"] as? String,
                   let price = data["price"] as? Int,
                    let imageName = data["imageName"] as? String {
                    let document = Document(name: name, description: description, price: price, imageName: imageName)
                    allDocuments.append(document)
                }
            }
            
            completion(allDocuments)
        }
    }
    
    func getImage(picName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("pictures")

        var image: UIImage = UIImage(named: "sneakers1")!

        let fireRef = pathRef.child(picName + ".png")
        fireRef.getData(maxSize: 1920 * 1920) { data, error in
            guard error == nil else {
                print("errorimage")
                completion(image); return }
            image = UIImage(data: data!)!
            completion(image)
        }
    }
    
    func getAllImages(picNames: [String], completion: @escaping ([UIImage]?) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("pictures")
        
        var allImages: [UIImage] = []
        
        let group = DispatchGroup()
        
        for picName in picNames {
            group.enter()
            
            let fireRef = pathRef.child(picName + ".png")
            fireRef.getData(maxSize: 1920 * 1920) { data, error in
                defer {
                    group.leave()
                }
                
                guard let data = data, error == nil else {
                    print("Error retrieving image: \(picName)")
                    return
                }
                
                if let image = UIImage(data: data) {
                    allImages.append(image)
                }
            }
        }
        group.notify(queue: .main) {
            completion(allImages)
        }
    }
    
    
    func getImageByName(imageName: String, completion: @escaping (UIImage?) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let imagePath = "pictures/\(imageName).png" // Путь к изображению в хранилище Firebase
        
        let imageRef = reference.child(imagePath)
        imageRef.getData(maxSize: 1920 * 1920) { data, error in
            guard let data = data, error == nil else {
                print("Ошибка при получении данных изображения: \(error?.localizedDescription ?? "")")
                completion(nil)
                return
            }
            print(imageName)
            let image = UIImage(data: data)
            completion(image)
        }
    }

}
