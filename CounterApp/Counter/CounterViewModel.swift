//
//  CounterViewModel.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 05.07.2023.
//

import Foundation

protocol CounterViewModelProtocol {
    var counter: Int { get }
    var counterName: String { get set }
    var stepCounter: Int { get }
    var viewModelDidChange: ((CounterViewModelProtocol) -> Void)? { get set }
    
    func changeCounterValue(on: Bool)
    func changeStepCounterValue(with: Int)
    func refreshCounterValue()



}

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
            return "hello world!"
        }
        set {
            StorageManager.shared.save(counter: Counter(value: counter, name: newValue)) // change saving work
            
        }
    }
    
    var stepCounter: Int = 1
    
    
    var viewModelDidChange: ((CounterViewModelProtocol) -> Void)?
    
    func changeCounterValue(on: Bool) {// change name
        if on {
            counter += stepCounter
        } else {
            counter -= stepCounter
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

    
}
