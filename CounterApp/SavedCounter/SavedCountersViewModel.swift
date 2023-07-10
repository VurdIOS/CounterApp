//
//  SavedCountersViewModel.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 10.07.2023.
//

import Foundation
protocol SavedCountersViewModelProtocol {
    var counters: [Counter] { get }
    init(counters: [Counter])
    
    func deleteCounter(at: Int)
    func deleteAllCounters()
//    func changeCounter(with name: String, _ value: Int, at index: Int)
}

class SavedCountersViewModel: SavedCountersViewModelProtocol {
    var counters: [Counter]
    
    required init(counters: [Counter]) {
        self.counters = counters
    }
    
    func deleteCounter(at index: Int) {
        counters.remove(at: index) // rename
        StorageManager.shared.deleteCounter(at: index)
    }
    
    func deleteAllCounters() {
        counters = []
        StorageManager.shared.deleteAllCounter()
    }
//    func changeCounter(with name: String, _ value: Int, at index: Int) {
//        counters[index].name = name
//        counters[index].value = value
//        StorageManager.shared.save(counter: Counter(value: value, name: name))
//    }
    
    
}
