//
//  DBViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//

import SwiftUI

@MainActor
final class DBViewModel: ObservableObject {
    
    @Published var ruhiBooksCollection: [String: RuhiBook] = [:]
    @Published var ruhiUnitsCollection: [String: RuhiUnit] = [:]
    @Published var ruhiSectionsCollection: [String: RuhiSection] = [:]
    @Published var quotesCollection: [String: Quote] = [:]
    @Published var onboardingQuote: Quote?

    @Published var bookSelected: RuhiBook?
    
    @Published var showBook = false
    @Published var error: String = ""
    @Published var hasError: Bool = false
    @Published var randomQuoteHaserror: Bool = false
    
    private var activeRequests = Set<String>()
    
    func fetchRuhiBook(with id: String) async {
        
        guard !activeRequests.contains(id) else { return } // Avoid duplicated calls
        activeRequests.insert(id)
        
        if let book = ruhiBooksCollection[id] {
            self.hasError = false
            self.error = ""
            self.bookSelected = book
            self.showBook = true
            activeRequests.remove(id)
            return
        }
        
        let result = await DBRepository.fetchRuhiBook(with: id)
        
        await MainActor.run {
            switch result {
            case .success(let book):
                self.hasError = false
                self.error = ""
                self.ruhiBooksCollection[book.id] = book
                self.bookSelected = book
                self.showBook = true
            case .failure(let error):
                self.showBook = false
                self.bookSelected = nil
                self.error = error.rawValue
                self.hasError = true
            }
        }
        activeRequests.remove(id)
    }
    
    func fetchRuhiUnit(with id: String) async {
        guard !activeRequests.contains(id) else { return } // Avoid duplicated calls
        activeRequests.insert(id)
        
        if let _ = ruhiUnitsCollection[id] {
            self.hasError = false
            self.error = ""
            activeRequests.remove(id)
            return
        }
        
        
        let result = await DBRepository.fetchRuhiUnit(with: id)
        
        switch result {
        case .success(let unit):
            self.error = ""
            self.hasError = false
            self.ruhiUnitsCollection[unit.id] = unit
        case .failure(let error):
            self.error = error.rawValue
            self.hasError = true
        }
        activeRequests.remove(id)
    }
    
    func fetchRuhiSection(with id: String) async {
        guard !activeRequests.contains(id) else { return } // Avoid duplicated calls
        activeRequests.insert(id)
        
        if let _ = ruhiSectionsCollection[id] {
            self.hasError = false
            self.error = ""
            activeRequests.remove(id)
            return
        }
        
        let result = await DBRepository.fetchRuhiSection(with: id)
        
        switch result {
        case .success(let section):
            self.error = ""
            self.hasError = false
            self.ruhiSectionsCollection[section.id] = section
        case .failure(let error):
            self.error = error.rawValue
            self.hasError = true
        }
    }
    
    func fetchQuote(with id: String) async {
        guard !activeRequests.contains(id) else { return } // Avoid duplicated calls
        activeRequests.insert(id)
        
        if let _ = quotesCollection[id] {
            self.hasError = false
            self.error = ""
            activeRequests.remove(id)
            return
        }
        
        let result = await DBRepository.fetchQuote(with: id)
        
        switch result {
        case .success(let quote):
            self.error = ""
            self.hasError = false
            self.quotesCollection[quote.id] = quote
        case .failure(let error):
            self.error = error.rawValue
            self.hasError = true
        }
    }
    
    func fetchRandomOnboardingQuote() async {
        guard !activeRequests.contains("onboardingQuotes") else { return } // Avoid duplicated calls
        activeRequests.insert("onboardingQuotes")
        
        if onboardingQuote != nil {
            self.hasError = false
            self.error = ""
            return
        }
        
        let result = await DBRepository.fetchOnboardingQuotes()
        
        switch result {
        case .success(let quotes):
            if let quote = quotes[quotes.keys.randomElement()!] {
                self.onboardingQuote = quote
            }
        case .failure(let error):
            self.error = error.rawValue
            self.randomQuoteHaserror = true
        }
    }
    
    func closeBook() {
        self.bookSelected = nil
        self.showBook = false
    }
}
