//
//  ViewController.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 16.06.2023.
//

import UIKit

class CounterViewController: UIViewController {
    
    
    
    
    private var viewModel: CounterViewModelProtocol! {
        didSet {
            viewModel.viewModelDidChange = { viewModel in
                
                self.counterLabel.text = viewModel.counter.formatted()
                self.checkCounterSize()
//                self.checkWhichStepButtonTupped()  // why does it not work?
            }
            self.counterLabel.text = viewModel.counter.formatted()
            self.checkCounterSize()
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
        view.backgroundColor = .systemGray5
    
        viewModel = CounterViewModel()

        navigationController?.navigationBar.prefersLargeTitles = true

        setupNavigationBar()
        setupConstraints()
        setupTargetsForButtons() // remove
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBarTitle()
    }
    
    
    private func setupNavigationBar() {
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(goToSettingsVC))
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.triangle.2.circlepath"), style: .plain, target: self, action: #selector(showAlert))
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(showSavingAlertAction))
        
        settingsButton.tintColor = .orange
        refreshButton.tintColor = .red
        saveButton.tintColor = .orange
        
        
        
        
        navigationItem.rightBarButtonItems = [settingsButton, refreshButton, saveButton]
    }
    
    private func setupNavigationBarTitle() {
        self.title = "Counter"
        navigationController?.navigationBar.prefersLargeTitles = true
        for view in self.navigationController?.navigationBar.subviews ?? [] {
            let subviews = view.subviews
            if subviews.count > 0, let label = subviews[0] as? UILabel {
                label.textColor = .orange
                label.font = UIFont(name: "MarkerFelt-Wide", size: 39)
                label.frame.size.width = 500
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
    
    private func checkWhichStepButtonTupped(){
        switch viewModel.stepCounter {
        case 2:
            stepWithTwo.backgroundColor = .orange
            stepWithTwo.setTitleColor(.white, for: .normal)
            stepWithFive.backgroundColor = . clear
            stepWithFive.setTitleColor(.orange, for: .normal)
            stepWithTen.backgroundColor = .clear
            stepWithTen.setTitleColor(.orange, for: .normal)
        case 5:
            stepWithTwo.backgroundColor = .clear
            stepWithTwo.setTitleColor(.orange, for: .normal)
            stepWithFive.backgroundColor = .orange
            stepWithFive.setTitleColor(.white, for: .normal)
            stepWithTen.backgroundColor = .clear
            stepWithTen.setTitleColor(.orange, for: .normal)
        case 10:
            stepWithTwo.backgroundColor = .clear
            stepWithTwo.setTitleColor(.orange, for: .normal)
            stepWithFive.backgroundColor = .clear
            stepWithFive.setTitleColor(.orange, for: .normal)
            stepWithTen.backgroundColor = .orange
            stepWithTen.setTitleColor(.white, for: .normal)
        default:
            stepWithTwo.backgroundColor = .clear
            stepWithTwo.setTitleColor(.orange, for: .normal)
            stepWithFive.backgroundColor = .clear
            stepWithFive.setTitleColor(.orange, for: .normal)
            stepWithTen.backgroundColor = .clear
            stepWithTen.setTitleColor(.orange, for: .normal)
            
            
            
            
        }
        //        stepWithTwoIsActive.toggle()
        //        stepWithFiveIsActive = false
        //        stepWithTenIsActive = false
        //        stepCounting = stepWithTwoIsActive ? 2 : 1
        //
        //        stepWithTwo.backgroundColor = stepWithTwoIsActive ? .orange : .clear
        //        stepWithTwo.setTitleColor(stepWithTwoIsActive ? .white : .orange , for: .normal)
        //        stepWithFive.backgroundColor = .clear
        //        stepWithFive.setTitleColor(.orange, for: .normal)
        //        stepWithTen.backgroundColor = .clear
        //        stepWithTen.setTitleColor(.orange, for: .normal)
    }
    
    
    private func checkCounterSize() {
        
        if counterLabel.text!.count < 3 {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 200)
        } else if counterLabel.text!.count >= 3 && counterLabel.text!.count < 4 {
            counterLabel.font = UIFont(name: "MarkerFelt-Wide", size: 150)
        } else if counterLabel.text!.count >= 5 && counterLabel.text!.count < 6 { // need to remove zap9taya and change limits
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
    
    @objc func showSavingAlertAction() {
        showSavingAlertAction()
        
    }
    
    @objc func addCounterValue() {
        viewModel.changeCounterValue(on: true)
    }
    
    @objc func minusLabelValue() {
        viewModel.changeCounterValue(on: false)
    }
    
    @objc func changeStepCountingOnTwo() {
//        stepWithTwoIsActive.toggle()
//        stepWithFiveIsActive = false
//        stepWithTenIsActive = false
//        stepCounting = stepWithTwoIsActive ? 2 : 1
//
//        stepWithTwo.backgroundColor = stepWithTwoIsActive ? .orange : .clear
//        stepWithTwo.setTitleColor(stepWithTwoIsActive ? .white : .orange , for: .normal)
//        stepWithFive.backgroundColor = .clear
//        stepWithFive.setTitleColor(.orange, for: .normal)
//        stepWithTen.backgroundColor = .clear
//        stepWithTen.setTitleColor(.orange, for: .normal)
        viewModel.changeStepCounterValue(with: 2)
        
    }
    
    @objc func changeStepCountingOnFive() {
//        stepWithFiveIsActive.toggle()
//        stepWithTwoIsActive = false
//        stepWithTenIsActive = false
//        stepCounting = stepWithFiveIsActive ? 5 : 1
//
//        stepWithTwo.backgroundColor = .clear
//        stepWithTwo.setTitleColor(.orange , for: .normal)
//
//        stepWithFive.backgroundColor = stepWithFiveIsActive ? .orange : .clear
//        stepWithFive.setTitleColor(stepWithFiveIsActive ? .white : .orange, for: .normal)
//
//        stepWithTen.backgroundColor = .clear
//        stepWithTen.setTitleColor(.orange, for: .normal)
        viewModel.changeStepCounterValue(with: 5)
        
    }
    
    @objc func changeStepCountingOnTen() {
//        stepWithTenIsActive.toggle()
//        stepWithTwoIsActive = false
//        stepWithFiveIsActive = false
//        stepCounting = stepWithTenIsActive ? 10 : 1
//
//        stepWithTwo.backgroundColor = .clear
//        stepWithTwo.setTitleColor(.orange , for: .normal)
//
//        stepWithFive.backgroundColor = .clear
//        stepWithFive.setTitleColor(.orange , for: .normal)
//
//        stepWithTen.backgroundColor = stepWithTenIsActive ? .orange : .clear
//        stepWithTen.setTitleColor(stepWithTenIsActive ? .white : .orange, for: .normal)
        viewModel.changeStepCounterValue(with: 10)
            
    }
}

extension CounterViewController: SettingViewControllerDelegate {
    func setCountingStartAt(number: String) {
//        labelValue = Int(number) ?? labelValue
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

            self.viewModel.refreshCounterValue()
            self.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "No!", style: .destructive) {_ in
            self.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        alert.addAction(gotItAction)
        
        present(alert, animated: true)
    }
    
    private func showSavingAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Are you want to save this Counter?" ,
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Yes",
                                        style: .default) {_ in
            self.showCreateNameAlert() { [self] newCounterName in
                viewModel.counterName = newCounterName
            }
        }
        
        let cancelAction = UIAlertAction(title: "No!", style: .destructive) {_ in
            self.dismiss(animated: true)
        }
        
        let showCountersAction = UIAlertAction(title: "Show Counters", style: .default) { _ in
            let vc = SavingViewController()          
            let navBarOnModal: UINavigationController = UINavigationController(rootViewController: vc)
            self.present(navBarOnModal, animated: true, completion: nil)
        }
        
        alert.addAction(saveAction)
        alert.addAction(showCountersAction)
        alert.addAction(cancelAction)
        
        
        present(alert, animated: true)
    }
    
    @objc func showCreateNameAlert(complition: @escaping(String) -> Void) {
        let alert = UIAlertController(title: nil, message: "Create name for Counter", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save Counter", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else { return }
            complition(task)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        alert.addTextField { textField in
            textField.placeholder = "Write here..."
        }
        present(alert, animated: true)
    }
    
}

