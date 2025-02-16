//
//  DBRepository.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//

import Foundation

struct DBRepository {
    
    public static func fetchOnboardingQuotes() async -> Result<[String: Quote], MLError> {
        do {
            let data: [String: Quote] = try await DBDataSource.fetchAll(from: .onboardingQuotes)
            return .success(data)
        } catch let caughtError as MLError {
            return .failure(caughtError)
        } catch {
            return .failure(MLError.unknown)
        }
    }
    
    public static func fetchRuhiBook(with key: String) async -> Result<RuhiBook, MLError> {
        do {
            let book: RuhiBook = try await DBDataSource.fetch(with: key.capitalized, from: .ruhiBooks)
            return .success(book)
        } catch let caughtError as MLError {
            return .failure(caughtError)
        } catch {
            return .failure(MLError.unknown)
        }
    }
    
    public static func fetchRuhiUnit(with key: String) async -> Result<RuhiUnit, MLError> {
        do {
            let unit: RuhiUnit = try await DBDataSource.fetch(with: key.capitalized, from: .ruhiUnits)
            return .success(unit)
        } catch let caughtError as MLError {
            return .failure(caughtError)
        } catch {
            return .failure(MLError.unknown)
        }
    }
    
    public static func fetchRuhiSection(with key: String) async -> Result<RuhiSection, MLError> {
        do {
            let section: RuhiSection = try await DBDataSource.fetch(with: key.capitalized, from: .ruhiSections)
            return .success(section)
        } catch let caughtError as MLError {
            return .failure(caughtError)
        } catch {
            return .failure(MLError.unknown)
        }
    }
    
    public static func fetchQuote(with key: String) async -> Result<Quote, MLError> {
        do {
            let quote: Quote = try await DBDataSource.fetch(with: key.capitalized, from: .quotes)
            return .success(quote)
        } catch let caughtError as MLError {
            return .failure(caughtError)
        } catch {
            return .failure(MLError.unknown)
        }
    }

}
