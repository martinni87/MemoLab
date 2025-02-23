//
//  DBDataSource.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//
//

import Foundation
import Firebase
import FirebaseDatabase


struct DBDataSource {
    
    private static let reference = Database.database(url: firebaseDatabaseURL).reference()
    
    public static func fetchAll<T: CollectionProtocol>(from books: BookCollection) async throws -> [String: T] {
        
        let snapshot = try await reference.child(books.name).getData()

        guard snapshot.exists(), let data = snapshot.value else {
            throw MLError.sanpshotIsNil
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let decodedData = try JSONDecoder().decode([String: T].self, from: jsonData)
            return decodedData
        } catch {
            throw MLError.invalidDataDecoding
        }
    }
    
    
    public static func fetch<T: CollectionProtocol>(with key: String, from collection: BookCollection) async throws -> T {
        
        let snapshot = try await reference.child(collection.name).child(key).getData()
        
        guard snapshot.exists(), let data = snapshot.value else {
            throw MLError.sanpshotIsNil
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data)
            let decodedData = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedData
        } catch {
            throw MLError.invalidDataDecoding
        }
    }
}
