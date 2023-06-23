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
        var lastCounter = fetchCounter()
        lastCounter = counter
        guard let data = try? JSONEncoder().encode(lastCounter) else { return }
        userDefaults.set(data, forKey: keyForCurrentValue)
    }

    func fetchCounter() -> Int {
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
}

