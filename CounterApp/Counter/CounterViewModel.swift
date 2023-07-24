//
//  CounterViewModel.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 05.07.2023.
//

import Foundation
import AVFoundation

// MARK: - CounterViewModelProtocol
protocol CounterViewModelProtocol {
    var counter: Int { get }
    var counterName: String { get set }
    var stepCounter: Int { get }
    var soundState: Bool { get set }
    var vibrationState: Bool { get set }
    var negativeNumbersState: Bool { get }
    var viewModelDidChange: ((CounterViewModelProtocol) -> Void)? { get set }
    
    func setupSettings()
    func changeCounterValue(on: Bool)
    func changeStepCounterValue(with: Int)
    func refreshCounterValue()
    func setCounterValue(on: Int?)
    func getSavedCounters() -> SavedCountersViewModel
}
// MARK: - CounterViewModel
class CounterViewModel: CounterViewModelProtocol {
    var counter: Int {
        get {
            StorageManager.shared.fetchCurrentCounter()
        } set {
            StorageManager.shared.saveCurrent(counter: newValue)
            viewModelDidChange?(self)
        }
    }
    
    var counterName: String {
        get {
            return "hello world!" // hehe useless just for fun
        }
        set {
            StorageManager.shared.save(
                counter: Counter(
                    value: counter,
                    name: newValue
                )
            ) // change saving work
        }
    }
    
    var stepCounter: Int = 1
    
    var soundState = StorageManager.shared.fetchSettings().sound
    var vibrationState = StorageManager.shared.fetchSettings().vibration
    var negativeNumbersState = StorageManager.shared.fetchSettings().ottricatelnie
    
    var viewModelDidChange: ((CounterViewModelProtocol) -> Void)?
    
    func setupSettings() {
        soundState = StorageManager.shared.fetchSettings().sound
        vibrationState = StorageManager.shared.fetchSettings().vibration
        negativeNumbersState = StorageManager.shared.fetchSettings().ottricatelnie
    }
    
    func changeCounterValue(on: Bool) {// change name
        if on {
            counter += stepCounter
        } else {
            if !negativeNumbersState, counter >= 1 {
                counter -= stepCounter
            } else if negativeNumbersState {
                counter -= stepCounter
            }
        }
        playClickSound()
        playVibrationSound()
        
    }
    
    func playClickSound() {
        if soundState{
            AudioServicesPlaySystemSound(1306)
        }
        
    }
    
    func playVibrationSound() {
        if vibrationState {
            AudioServicesPlaySystemSound(1520)
            
        }
    }
    
    func changeStepCounterValue(with: Int) {// rename
        if with == stepCounter {
            stepCounter = 1
        } else {
            stepCounter = with
        }
        viewModelDidChange?(self)
    }
    
    func refreshCounterValue() {
        counter = 0
    }
    func setCounterValue(on: Int?) { // rename
        guard let number = on else {return}
        counter = number
    }
    
    func getSavedCounters() -> SavedCountersViewModel {
        SavedCountersViewModel(counters: StorageManager.shared.fetchAllCounters())
    }
}


