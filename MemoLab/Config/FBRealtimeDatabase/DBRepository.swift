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
//
//final class DataRepository {
//    
//    private let dataSource = DataSource()
//    
//    func postRuhiBook(_ book: RuhiBook) async -> Result<Bool, MLError> {
//        do {
//            try await dataSource.post(on: .ruhiBookCollection, the: book)
//            return .success(true)
//        } catch {
//            return .failure(MLError.someError)
//        }
//    }
//    
//    func postPrayersbook(_ book: PrayersBook) async -> Result<Bool, MLError> {
//        do {
//            try await dataSource.post(on: .prayersBookCollection, the: book)
//            return .success(true)
//        } catch {
//            return .failure(MLError.someError)
//        }
//    }
//    
//    func fetchRuhiBooks() async -> Result<[RuhiBook], MLError> {
//        do {
//            let books: [RuhiBook] = try await dataSource.fetchList(of: .ruhiBookCollection)
//            return .success(books)
//        } catch {
//            return .failure(MLError.someError)
//        }
//    }
//    
//    func fetchPrayersBook() async -> Result<[PrayersBook], MLError> {
//        do {
//            let books: [PrayersBook] = try await dataSource.fetchList(of: .prayersBookCollection)
//            return .success(books)
//        } catch {
//            return .failure(MLError.someError)
//        }
//    }
////    func getSection() async -> Result<RuhiSection, MLError> {
////        do {
////            let section = try await dataSource.getSection()
////            return .success(section)
////        } catch let error as MLError {
////            return .failure(error)
////        } catch {
////            return .failure(MLError.someError)
////        }
////    }
//}
