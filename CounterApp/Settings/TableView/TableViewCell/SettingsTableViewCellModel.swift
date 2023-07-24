//
//  SettingsTableViewCellModel.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 21.07.2023.
//

import Foundation

enum SwitchesName: String {
    case Vibration
    case Sound
    case negativeNumbers
}



protocol SettingsTableViewCellProtocol {
    var vibrationSwitchState: Bool { get }
    var soundSwitchState: Bool { get }
    var negativeNumbers: Bool { get }
    
    func changeSwitchState(name: SwitchesName)
}

class SettingsTableViewCellModel: SettingsTableViewCellProtocol {
    
    var vibrationSwitchState = StorageManager.shared.fetchSettings().vibration {
        didSet {
            var newSettings = getSettings()
            newSettings.vibration = vibrationSwitchState
            save(settings: newSettings)
        }
    }
    
    var soundSwitchState = StorageManager.shared.fetchSettings().sound {
        didSet {
            var newSettings = getSettings()
            newSettings.sound = soundSwitchState
            save(settings: newSettings)
        }
    }
    var negativeNumbers = StorageManager.shared.fetchSettings().ottricatelnie {
        didSet {
            var newSettings = getSettings()
            newSettings.ottricatelnie = negativeNumbers
            save(settings: newSettings)
        }
    }
    
    
    func changeSwitchState(name: SwitchesName) {
        switch name {
        case SwitchesName.Vibration:
            vibrationSwitchState.toggle()
        case SwitchesName.Sound:
            soundSwitchState.toggle()
        case SwitchesName.negativeNumbers:
            negativeNumbers.toggle()
        }
    }
    
    private func save(settings: Settings) {
        StorageManager.shared.save(settings: settings)
    }
    
    private func getSettings() -> Settings {
        StorageManager.shared.fetchSettings()
    }
    
    
}
