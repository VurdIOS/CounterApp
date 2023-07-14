//
//  SettingsViewController.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 16.06.2023.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func setCountingStartAt(number: Int?)
}

class SettingsViewController: UIViewController {
    
    weak var delegate: SettingViewControllerDelegate?
    
    
    let textFieldForInt: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .systemGray5
        tf.layer.borderWidth = 2
        tf.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        tf.textAlignment = .center
        tf.layer.cornerRadius = 10
        
        tf.attributedPlaceholder = NSAttributedString(
            string: "Start counting from",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.orange])
        
        tf.keyboardType = .numberPad
        tf.autocorrectionType = .no
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let setButton: UIButton = {
        let button = UIButton()
        button.setTitle("Setup", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    let developerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Developer", for: .normal)
        button.setTitleColor(.systemGray5, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeConstraints()
        setupTargetsForButtons()
    }
    private func makeConstraints() {
        view.addSubview(textFieldForInt)
        view.addSubview(setButton)
        view.addSubview(developerButton)
        
        NSLayoutConstraint.activate([
            textFieldForInt.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 100
            ),
            textFieldForInt.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            textFieldForInt.leftAnchor.constraint(
                equalTo: view.leftAnchor,
                constant: 50
            ),
            textFieldForInt.rightAnchor.constraint(
                equalTo: view.rightAnchor,
                constant: -50
            ),
            textFieldForInt.heightAnchor.constraint(
                equalToConstant: 50
            )
        ])
        
        NSLayoutConstraint.activate([
            setButton.topAnchor.constraint(
                equalTo: textFieldForInt.bottomAnchor,
                constant: 50
            ),
            setButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            setButton.widthAnchor.constraint(
                equalToConstant: 200
            )
        ])
        
        NSLayoutConstraint.activate([
            developerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            developerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            developerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
    }
    private func setupTargetsForButtons() {
        
        setButton.addTarget(self,
                            action: #selector(SetupCounter),
                            for: .touchUpInside)
        
        developerButton.addTarget(self,
                                  action: #selector(goToDevView),
                                  for: .touchUpInside)
        
    }
    
    @objc private func SetupCounter() {
        guard let number = Int(textFieldForInt.text!) else {
            showAlert()
            textFieldForInt.text = ""
            return
        }
        
        delegate?.setCountingStartAt(number: number)
        self.dismiss(animated: true)
    }
    
    @objc private func goToDevView() {
        let devView = DeveloperViewController()
        present(devView, animated: true)
        
    }
}

extension SettingsViewController {
    func showAlert() {
        let alert = UIAlertController(
            title: nil,
            message: "You can only enter numbers" ,
            preferredStyle: .alert
        )
        let gotItAction = UIAlertAction(title: "OK",
                                        style: .default)
        
        alert.addAction(gotItAction)
        
        present(alert, animated: true)
    }
}
