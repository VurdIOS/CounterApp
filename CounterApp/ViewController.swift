//
//  ViewController.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 16.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var labelValue = 0
    
    let plusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("+", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.clear, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 150)
        button.addTarget(self, action: #selector(addCounterValue), for: .touchUpInside)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 150)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.clear, for: .highlighted)
        button.addTarget(self, action: #selector(minusLabelValue), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "MarkerFelt-Wide", size: 200)
        label.text = "0"
        label.textColor = .orange
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let horizontalStackForButtons: UIStackView = {
        let stackView   = UIStackView()
        
        stackView.axis  = .horizontal
        stackView.distribution  = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing   = 16.0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let verticalStackForButtonsAndLabel: UIStackView = {
        let stackView   = UIStackView()
        
        stackView.axis  = .vertical
        stackView.distribution  = .equalCentering
        stackView.alignment = .fill
        stackView.spacing   = 16.0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let play = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(goToSettingsVC))
        
        navigationItem.rightBarButtonItems = [play]
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        horizontalStackForButtons.addArrangedSubview(minusButton)
        horizontalStackForButtons.addArrangedSubview(plusButton)
        
        verticalStackForButtonsAndLabel.addArrangedSubview(counterLabel)
        verticalStackForButtonsAndLabel.addArrangedSubview(horizontalStackForButtons)
        
        view.addSubview(verticalStackForButtonsAndLabel)
        
        verticalStackForButtonsAndLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalStackForButtonsAndLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        verticalStackForButtonsAndLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        verticalStackForButtonsAndLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
    }
    
    @objc func addCounterValue() {
        labelValue += 1
        counterLabel.text = labelValue.formatted()
        
    }
    
    @objc func minusLabelValue() {
        if labelValue > 0 {
            labelValue -= 1
            counterLabel.text = labelValue.formatted()
        }
    }
    @objc func goToSettingsVC() {
        let vc = SettingsViewController()
        present(vc, animated: true)
    }
    
    
}

