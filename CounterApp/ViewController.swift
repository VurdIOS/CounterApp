//
//  ViewController.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 16.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var labelValue = 95
    
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
        label.text = "95"
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
        
        setupNavigationBar()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBarTitle()
    }
    
    private func setupNavigationBar() {
        let play = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(goToSettingsVC))
        play.tintColor = .orange
        
        navigationItem.rightBarButtonItems = [play]
    }
    
    private func setupNavigationBarTitle() {
        self.title = "Counter"
        for view in self.navigationController?.navigationBar.subviews ?? [] {
            let subviews = view.subviews
            if subviews.count > 0, let label = subviews[0] as? UILabel {
                label.textColor = .orange
                label.font = UIFont(name: "MarkerFelt-Wide", size: 34)
                label.frame.size.width = 300
            }
        }// Это все нужно для того чтобы изменить цвет и шрифт тайтла навигейшн бара
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
    
    private func checkValueLabel() {// тут оптимизировать, потому что проверка идет каждый раз
        
        if labelValue < 100 {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 200)
        } else if labelValue >= 100 && labelValue < 1000 {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 150)
        } else {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 100)
        }
    }
    
    @objc func goToSettingsVC() {
        let vc = SettingsViewController()
        present(vc, animated: true)
    }
    
    @objc func addCounterValue() {
        labelValue += 1
        counterLabel.text = labelValue.formatted()
        checkValueLabel()
        
    }
    
    @objc func minusLabelValue() {
        if labelValue > 0 {
            labelValue -= 1
            counterLabel.text = labelValue.formatted()
        }
        checkValueLabel()
    }
   
}

