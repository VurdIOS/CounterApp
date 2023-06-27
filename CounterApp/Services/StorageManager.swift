//
//  StorageManager.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 23.06.2023.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let keyForCurrentValue = "CurrentValue"
    private let keyForSavedCounters = "contact"
    
    private init() {}
    
    func saveCurrent(counter: Int) {
        var lastCounter = fetchCurrentCounter() // Глупо, переделать потом, не нужные две строки
        lastCounter = counter
        guard let data = try? JSONEncoder().encode(lastCounter) else { return }
        userDefaults.set(data, forKey: keyForCurrentValue)
    }

    func fetchCurrentCounter() -> Int {
        guard let data = userDefaults.data(forKey: keyForCurrentValue) else { return 0 }
        guard let counter = try? JSONDecoder().decode(Int.self, from: data) else { return 0 }
        return counter
    }
//
//    func deleteContact(at index: Int) {
//        var contacts = fetchContacts()
//        contacts.remove(at: index)
//        guard let data = try? JSONEncoder().encode(contacts) else { return }
//        userDefaults.set(data, forKey: key)
//    }
    
    func save(counter: Counter) {
        var сounters = fetchAllCounters()
        сounters.append(counter)
        guard let data = try? JSONEncoder().encode(сounters) else { return }
        userDefaults.set(data, forKey: keyForSavedCounters)
    }

    func fetchAllCounters() -> [Counter] {
        guard let data = userDefaults.data(forKey: keyForSavedCounters) else { return [] }
        guard let counter = try? JSONDecoder().decode([Counter].self, from: data) else { return [] }
        return counter
    }

    func deleteCounter(at index: Int) {
        var counters = fetchAllCounters()
        counters.remove(at: index)
        guard let data = try? JSONEncoder().encode(counters) else { return }
        userDefaults.set(data, forKey: keyForSavedCounters)
    }
    
//    func edit(counter: Counter, title: String, value: Int) {
//        counter.name = title
//        counter.value = value
//    }
    
    func deleteAllCounter() {
        var counters = fetchAllCounters()
        counters = []
        guard let data = try? JSONEncoder().encode(counters) else { return }
        userDefaults.set(data, forKey: keyForSavedCounters)
    }
}

