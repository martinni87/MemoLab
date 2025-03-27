//
//  ListOfBooksViews.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 2/2/25.
//

import SwiftUI


struct ListOfBooksView: View {
    
    @ObservedObject var data: DBViewModel
    
    var body: some View {
        VStack(alignment: .center){
            Text(BookCollection.ruhiBooks.description).font(.title).bold()
                .multilineTextAlignment(.center)
                .padding(25)
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    Spacer().frame(width: 25)
                    ForEach(RuhiSequence.allCases) { book in
                        Button {
                            Task {
                                await data.fetchRuhiBook(with: book.id)
                            }
                        } label: {
                            Image(book.cover)
                                .resizable()
                                .scaledToFit()
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 30)
                    }
                }
                .frame(height: 350)
            }
        }
        .sheet(isPresented: $data.showBook) {
            if let book = data.bookSelected {
                ListOfUnitsSubView(data: data, book: book)
                    .interactiveDismissDisabled(true)
            }
        }
        .scrollIndicators(.never)
    }
}

struct ListOfUnitsSubView: View {
    
    @ObservedObject var data: DBViewModel
    let book: RuhiBook
    
    var body: some View {
        NavigationStack {
            Text(book.subtitle).font(.title).bold().multilineTextAlignment(.center)
            List(data.ruhiUnitsCollection.keys.sorted(), id:\.self) { key in
                if key.contains(book.id) {
                    if let unit = data.ruhiUnitsCollection[key] {
                        NavigationLink(unit.title){
                            ListOfSectionsSubView(data: data, unit: unit)
                                .alert("alert.unitNotAvailable.title", isPresented: $data.hasError) {
                                    Button("alert.primary.button"){}
                                } message: {
                                    Text("alert.unitNotAvailable.message")
                                }
                        }
                    }
                }
            }
            .navigationTitle(book.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                MLCloseBookSheetViewComponent(data: data)
            }
            .task {
                let unitsIds = data.ruhiBooksCollection[book.id]?.units ?? []
                unitsIds.forEach { id in
                    Task {
                        await data.fetchRuhiUnit(with: id)
                    }
                }
            }
        }
    }
}


struct ListOfSectionsSubView: View {
    
    @ObservedObject var data: DBViewModel
    let unit: RuhiUnit
    
    var body: some View {
        Text(unit.subtitle).font(.title).bold().multilineTextAlignment(.center)
        Text("sectionList.goal.description: \(unit.goal)").padding().font(.subheadline).fontWeight(.semibold)
        List(data.ruhiSectionsCollection.keys.sorted(), id:\.self) { key in
            if key.contains(unit.id){
                if let section = data.ruhiSectionsCollection[key] {
                    NavigationLink(section.title){
                        ListOfQuotesSubView(data: data, section: section)
                            .alert("alert.sectionNotAvailable.title", isPresented: $data.hasError) {
                                Button("alert.primary.button"){}
                            } message: {
                                Text("alert.sectionNotAvailable.message")
                            }
                    }
                }
            }
        }
        .navigationTitle(unit.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            MLCloseBookSheetViewComponent(data: data)
        }
        .task {
            guard let sectionsIds = data.ruhiUnitsCollection[unit.id]?.sections else {
                return
            }
            for id in sectionsIds {
                Task {
                    await data.fetchRuhiSection(with: id)
                }
            }
        }
    }
}

struct ListOfQuotesSubView: View {
    
    @ObservedObject var data: DBViewModel
    let section: RuhiSection
    @State var count = 1
    
    var body: some View {
        List(Array(data.quotesCollection.keys.sorted().enumerated()), id: \.element) { index, key in
            if key.contains(section.id){
                if let quote = data.quotesCollection[key] {
                    NavigationLink {
                        WelcomeToActivitiesView(data: data, quote: quote)
                            .alert("alert.quoteActivitiesNotAvailable.title", isPresented: $data.hasError) {
                                Button("alert.primary.button"){}
                            } message: {
                                Text("alert.quoteActivitiesNotAvailable.message")
                            }
                    } label: {
                        VStack(alignment: .leading) {
                            Text("list.quote.navigationLink \(index + 1)")
                                .font(.headline)
                            Text(quote.text)
                                .lineLimit(2)
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
        .navigationTitle(section.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            MLCloseBookSheetViewComponent(data: data)
        }
        .task {
            guard let quotesIds = data.ruhiSectionsCollection[section.id]?.quotes else {
                return
            }
            for id in quotesIds {
                Task {
                    await data.fetchQuote(with: id)
                }
            }
        }
    }
}

#Preview {
    ListOfBooksView(data: DBViewModel())
}
