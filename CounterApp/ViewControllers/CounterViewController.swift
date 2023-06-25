//
//  ViewController.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 16.06.2023.
//

import UIKit

class CounterViewController: UIViewController {
    
    
    
    private let storageManager = StorageManager.shared
    
    lazy var counter = storageManager.fetchCounter()
    
    var stepCounting = 1
    
    var labelValue = 0 {
        didSet {
            checkValueLabel()
            saveCurrentCounter()// Излишне сохраняет данные при каждом изменении. Оптимизировать.
        }
    }
    
    
    let plusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("+", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.clear, for: .highlighted)
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 150)
        
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let minusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: 150)
        button.setTitleColor(.orange, for: .normal)
        button.setTitleColor(.clear, for: .highlighted)
        
        
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
    
    let stepWithTwo: UIButton = {
        let button = UIButton()
        button.setTitle("+ 2", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.cornerRadius = 30
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var stepWithTwoIsActive = false
    
    let stepWithFive: UIButton = {
        let button = UIButton()
        button.setTitle("+ 5", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.cornerRadius = 30
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var stepWithFiveIsActive = false
    
    let stepWithTen: UIButton = {
        let button = UIButton()
        button.setTitle("+ 10", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.cornerRadius = 30
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var stepWithTenIsActive = false
    
    
    
    let horizontalStackForButtons: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 16.0
        
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
    
    let horizontalStackForStepButtons: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16.0
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchCounter()

        
        setupNavigationBar()
        setupConstraints()
        setupTargetsForButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBarTitle()
    }
    
    private func fetchCounter() {
        let counter = storageManager.fetchCounter()
        labelValue = counter
        counterLabel.text = String(counter)
    }
    
    func saveCurrentCounter() {
        storageManager.saveCurrent(counter: labelValue)
    }
    
    private func setupNavigationBar() {
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(goToSettingsVC))
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.triangle.2.circlepath"), style: .plain, target: self, action: #selector(showAlert))
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(goToSaveVC))
        
        settingsButton.tintColor = .orange
        refreshButton.tintColor = .red
        saveButton.tintColor = .orange
        refreshButton.largeContentSizeImage = UIImage(systemName: "arrow.triangle.2.circlepath")
        
        
        
        navigationItem.rightBarButtonItems = [settingsButton, refreshButton, saveButton]
    }
    
    private func setupNavigationBarTitle() {
        self.title = "Counter"
        navigationController?.navigationBar.prefersLargeTitles = true
        for view in self.navigationController?.navigationBar.subviews ?? [] {
            let subviews = view.subviews
            if subviews.count > 0, let label = subviews[0] as? UILabel {
                label.textColor = .orange
                label.font = UIFont(name: "MarkerFelt-Wide", size: 34)
                label.frame.size.width = 300
            }
        }// Это все нужно для того чтобы изменить цвет и шрифт тайтла навигейшн бара
    }
    
    private func setupTargetsForButtons() {
        
        plusButton.addTarget(self, action: #selector(addCounterValue), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusLabelValue), for: .touchUpInside)
        
        stepWithTwo.addTarget(self, action: #selector(changeStepCountingOnTwo), for: .touchUpInside)
        stepWithFive.addTarget(self, action: #selector(changeStepCountingOnFive), for: .touchUpInside)
        
        stepWithTen.addTarget(self, action: #selector(changeStepCountingOnTen), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        
        
        horizontalStackForButtons.addArrangedSubview(minusButton)
        horizontalStackForButtons.addArrangedSubview(plusButton)
        
        verticalStackForButtonsAndLabel.addArrangedSubview(counterLabel)
        verticalStackForButtonsAndLabel.addArrangedSubview(horizontalStackForButtons)
        
        horizontalStackForStepButtons.addArrangedSubview(stepWithTwo)
        horizontalStackForStepButtons.addArrangedSubview(stepWithFive)
        horizontalStackForStepButtons.addArrangedSubview(stepWithTen)
        
        view.addSubview(verticalStackForButtonsAndLabel)
        view.addSubview(horizontalStackForStepButtons)
        
        NSLayoutConstraint.activate([
            verticalStackForButtonsAndLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackForButtonsAndLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            verticalStackForButtonsAndLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            verticalStackForButtonsAndLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            horizontalStackForStepButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            horizontalStackForStepButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            horizontalStackForStepButtons.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            horizontalStackForStepButtons.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            horizontalStackForStepButtons.heightAnchor.constraint(equalToConstant: 75),
            horizontalStackForStepButtons.widthAnchor.constraint(equalToConstant: 75)
        ])
        
    }
    
    private func checkValueLabel() {// тут оптимизировать, потому что проверка идет каждый раз
        
        if labelValue < 100 {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 200)
        } else if labelValue >= 100 && labelValue < 1_000 {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 150)
        } else if labelValue >= 1000 && labelValue < 10000 {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 100)
        } else {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 70)
        }
    }
    
    @objc func goToSettingsVC() {
        let vc = SettingsViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc func goToSaveVC() {
        let vc = SavingViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func addCounterValue() {
        labelValue += stepCounting
        counterLabel.text = labelValue.formatted()
        
    }
    
    @objc func minusLabelValue() {
        if labelValue > 0 {
            labelValue -= stepCounting
            counterLabel.text = labelValue.formatted()
        }
    }
    
    @objc func refreshButtonTapped() {
        labelValue = 0
        counterLabel.text = "0"
    }
    
    @objc func changeStepCountingOnTwo() {
        stepWithTwoIsActive.toggle()
        stepWithFiveIsActive = false
        stepWithTenIsActive = false
        stepCounting = stepWithTwoIsActive ? 2 : 1
        
        stepWithTwo.backgroundColor = stepWithTwoIsActive ? .orange : .white
        stepWithTwo.setTitleColor(stepWithTwoIsActive ? .white : .orange , for: .normal)
        stepWithFive.backgroundColor = .clear
        stepWithFive.setTitleColor(.orange, for: .normal)
        stepWithTen.backgroundColor = .clear
        stepWithTen.setTitleColor(.orange, for: .normal)
        
    }
    
    @objc func changeStepCountingOnFive() {
        stepWithFiveIsActive.toggle()
        stepWithTwoIsActive = false
        stepWithTenIsActive = false
        stepCounting = stepWithFiveIsActive ? 5 : 1
        
        stepWithTwo.backgroundColor = .clear
        stepWithTwo.setTitleColor(.orange , for: .normal)
        stepWithFive.backgroundColor = stepWithFiveIsActive ? .orange : .white
        stepWithFive.setTitleColor(stepWithFiveIsActive ? .white : .orange, for: .normal)
        stepWithTen.backgroundColor = .clear
        stepWithTen.setTitleColor(.orange, for: .normal)
        
    }
    
    @objc func changeStepCountingOnTen() {
        stepWithTenIsActive.toggle()
        stepWithTwoIsActive = false
        stepWithFiveIsActive = false
        stepCounting = stepWithTenIsActive ? 10 : 1
        
        stepWithTwo.backgroundColor = .clear
        stepWithTwo.setTitleColor(.orange , for: .normal)
        stepWithFive.backgroundColor = .clear
        stepWithFive.setTitleColor(.orange , for: .normal)
        stepWithTen.backgroundColor = stepWithTenIsActive ? .orange : .white
        stepWithTen.setTitleColor(stepWithTenIsActive ? .white : .orange, for: .normal)
        
    }
}

extension CounterViewController: SettingViewControllerDelegate {
    func setCountingStartAt(number: String) {
        labelValue = Int(number) ?? labelValue
        counterLabel.text = number
    }
}

extension CounterViewController {
    @objc func showAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Are you sure, you want to reset your counter" ,
                                      preferredStyle: .alert)
        let gotItAction = UIAlertAction(title: "Yes",
                                        style: .default) {_ in
            self.labelValue = 0
            self.counterLabel.text = "0"
            self.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "No!", style: .destructive) {_ in
            self.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(gotItAction)
        
        present(alert, animated: true)
    }
}

