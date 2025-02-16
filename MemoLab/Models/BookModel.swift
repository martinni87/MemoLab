//
//  BookModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 10/1/25.
//

import SwiftUI

protocol CollectionProtocol: Codable, Equatable {
    var id: String { get }
}


/// Enums definitions
enum BookCollection: String, Identifiable, CaseIterable {
    case ruhiBooks, ruhiUnits, ruhiSections, quotes, onboardingQuotes
    
    var id: String {
        self.rawValue
    }
    
    var name: String {
        "\(self)Collection"
    }
    
    var description: String {
        switch self {
        case .ruhiBooks, .ruhiUnits, .ruhiSections:
            "Libros de la secuencia del Instituto Ruhí"
        case .quotes, .onboardingQuotes:
            "Citas y oraciones de los Escritos Bahá'ís"
        }
    }
}

enum RuhiSequence: String, Identifiable, CaseIterable {
    case one    = "Book1"
    case two    = "Book2"
    case three  = "Book3"
    case four   = "Book4"
    case five   = "Book5"
    case six    = "Book6"
    case seven  = "Book7"
    
    var id: String {
        self.rawValue
    }
    
    var cover: String {
        "Cover\(self.rawValue)"
    }
}

/// Ruhi books structure, including each unit per book and subsections with corresponding activities
struct RuhiBook: Identifiable, Hashable, CollectionProtocol {
    let id: String
    let title: String
    let subtitle: String
    let author: String
    let image: String
    let units: [String]
}

struct RuhiUnit: Identifiable, Hashable, CollectionProtocol {
    let id: String
    let title: String
    let subtitle: String
    let goal: String
    let sections: [String]
}

struct RuhiSection: Identifiable, Hashable, CollectionProtocol {
    let id: String
    let title: String
    let quotes: [String]
}

struct Quote: Identifiable, Hashable, CollectionProtocol {
    let id: String
    let text: String
    let author: String?
}

extension RuhiBook {
    static let empty = RuhiBook(id: "", title: "", subtitle: "", author: "", image: "", units: [])
    static let sample = RuhiBook(id: "BookId", title: "Libro X", subtitle: "Sample Book", author: "Developer", image: "SampleCover", units: ["BookId_UnitId"])
}

extension RuhiUnit {
    static let empty = RuhiUnit(id: "", title: "", subtitle: "", goal: "", sections: [])
    static let sample = RuhiUnit(id: "BookId_UnitId", title: "Unit X", subtitle: "Sample Unit X", goal: "El objetivo es testear la app", sections: ["BookId_UnitId_SectionId"])
}

extension RuhiSection {
    static let empty = RuhiSection(id: "", title: "", quotes: [])
    static let sample = RuhiSection(id: "BookId_UnitId_SectionId", title: "Sección X", quotes: ["BookId_UnitId_SectionId_QuoteId"])
}

extension Quote {
    static let empty = Quote(id: "", text: "", author: "")
    static let sample = Quote(id: "BookId_UnitId_SectionId_QuoteId", text: "Esto es una cita de ejemplo para desarrollo", author: "Developer")
}
