//
//  CounterViewModel.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 05.07.2023.
//

import Foundation

protocol CounterViewModelProtocol {
    var counter: Int { get }
    var stepCounter: Int { get set }
    var viewModelDidChange: ((CounterViewModelProtocol) -> Void)? { get set }
    
    func changeCounterValue(on: Bool)
    func changeStepCounterValue(with: Int)



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
    }
    
}