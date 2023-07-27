//
//  SettingsTableViewCell.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 20.07.2023.
//
import UIKit

protocol SettingsTableViewCellDelegate {
    
}

class SettingsTableViewCell: UITableViewCell {

    let switchView = UISwitch()
    
    private var viewModel: SettingsTableViewCellProtocol!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewModel = SettingsTableViewCellModel()
        switchView.setOn(false, animated: false)
        switchView.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        accessoryView = switchView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func valueChanged(sender: UISwitch) {
        switch textLabel?.text {
        case SwitchesName.Vibration.rawValue:
            viewModel.changeSwitchState(name: .Vibration)
        case SwitchesName.Sound.rawValue:
            viewModel.changeSwitchState(name: .Sound)
        case SwitchesName.NegativeNumbers.rawValue:
            viewModel.changeSwitchState(name: .NegativeNumbers)
            
        default:
            print("Did u add a new Switch?")
        }
    }
}
