//
//  ActivityViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/4/25.
//

import SwiftUI

final class ActivityViewModel: ObservableObject {
    @Published var activity: ActivityModel?
    @Published var orderedWords: [WordEntity]?
    @Published var hiddenWords: [WordEntity]?
    @Published var isExitRequested: Bool = false
    
    init(activity: ActivityModel? = nil) {
        self.activity = activity
        var hiddenPercentage = 0.0
        if let activity = activity {
            switch activity.order {
            case 1: hiddenPercentage = 0.25
            case 2: hiddenPercentage = 0.55
            case 3: hiddenPercentage = 1.0
            default: hiddenPercentage = 0.0
            }
        }
        self.orderedWords = self.separateQuoteInWords(hidden: hiddenPercentage)
        self.hiddenWords = self.shuffleHiddenWordEntities()
    }
    
    @ViewBuilder
    func showGame(for activity: ActivityModel) -> some View {
        switch activity.order {
        case 1: ActivityOne(activityVM: self)
        case 2: ActivityTwo()
        case 3: ActivityThree()
        default: ActivityZero(activity: activity)
        }
    }
    
    public func nextActivity() -> ActivityModel? {
        guard let currentActivity = activity else {
            return nil
        }
        guard currentActivity.order != 3 else {
            return nil
        }
        let newActivityOrder = currentActivity.order + 1
        return ActivityModel(quote: currentActivity.quote,
                             isFinished: false,
                             title: "activity.title.\(newActivityOrder)",
                             description: "activity.description.\(newActivityOrder)",
                             order: newActivityOrder)
    }
    
    private func separateQuoteInWords(hidden percentage: Double) -> [WordEntity] {
        guard let text = activity?.quote.text else { return [] }
        let wordsList = text.split(separator: " ").map(String.init)
        return setWordGroup(wordsList, hidden: percentage)
    }
    
    private func setWordGroup(_ wordList: [String], hidden percentage: Double = 0.5) -> [WordEntity] {
        let size = wordList.count
        let numberOfHiddenWordsNeeded = Int(ceil(Double(size) * percentage))
        let hiddenIndices = Set(wordList.indices.shuffled().prefix(numberOfHiddenWordsNeeded))
        
        let wordGroup: [WordEntity] = wordList.enumerated().map { index, word in
            let shouldBeHidden = hiddenIndices.contains(index)
            return WordEntity(word: word, originalOrder: index, startsHidden: shouldBeHidden)
        }
        
        return wordGroup
    }
    
    private func shuffleHiddenWordEntities() -> [WordEntity] {
        guard let wordEntityList = orderedWords else { return [] }
        let disorderedHiddenWordList = wordEntityList.filter(\.startsHidden).shuffled()
        return disorderedHiddenWordList
    }
    
    public func transformHiddenWordsIntoSelectableItems(hidden percentage: Double) {
        let wordGroup = separateQuoteInWords(hidden: percentage)
        var selectableItems: [WordEntity] = []
        wordGroup.forEach { word in
            if word.startsHidden {
                selectableItems.append(word)
            }
        }
        self.hiddenWords = selectableItems
    }
}
