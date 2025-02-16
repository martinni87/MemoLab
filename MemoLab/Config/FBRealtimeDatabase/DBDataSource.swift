//
//  DBDataSource.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//
//

import Foundation

struct DBDataSource {
    
    private static let baseURL = Database.baseURL
    
    public static func fetchAll<T: CollectionProtocol>(from books: BookCollection) async throws -> [String: T] {
        guard let url = URL(string: "\(baseURL + books.name).json") else {
            throw MLError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MLError.invalidResponse
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try jsonDecoder.decode([String: T].self, from: data)
                continuation.resume(returning: decodedData)
            } catch {
                continuation.resume(throwing: MLError.invalidDataDecoding)
            }
        }
    }
    
    
    public static func fetch<T: CollectionProtocol>(with key: String, from collection: BookCollection) async throws -> T {
        guard let url = URL(string: "\(baseURL + collection.name)/\(key).json") else {
            throw MLError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MLError.invalidResponse
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try jsonDecoder.decode(T.self, from: data)
                continuation.resume(returning: decodedData)
            } catch {
                continuation.resume(throwing: MLError.invalidDataDecoding)
            }
        }
    }
}
