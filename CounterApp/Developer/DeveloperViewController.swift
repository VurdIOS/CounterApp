//
//  DeveloperViewController.swift
//  CounterApp
//
//  Created by Камаль Атавалиев on 14.07.2023.
//

import UIKit

class DeveloperViewController: UIViewController {
    
    var scrollView : UIScrollView!
    
    var uiview = UIView()
    
    var imageContainer: UIView = {
        // Создаем контейнер для того чтобы поместить в него картинку
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        container.clipsToBounds = false
        container.layer.shadowColor = UIColor.orange.cgColor
        container.layer.shadowOpacity = 1
        container.layer.shadowOffset = CGSize(width: 5, height: 5)
        container.layer.shadowRadius = 5
        
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    let developerImage = UIImage(named: "Developer1")
    
    var developerImageView: UIImageView!

    let developerFirstLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Спасибо, дорогой друг, что скачал и пользуешься моим приложением. Меня зовут Камаль и это мое первое приложение, оно абсолютно бесплатное и в нем не будет рекламы."
        
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let developerSecondLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Приложение действительно специфично, и им будут пользоваться только те, кому оно действительно необходимо. Поэтому, если вдруг тебе не хватает функционала, возможно какой то приятной мелочи, ты можешь мне написать и скорее всего я ее добавлю))) Напиши мне в телеграм @jun_dev_ios"
        
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.font = UIFont(name: "MarkerFelt-Wide", size: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var contentSize: CGSize {
        var size = CGSize()
        if view.frame.height < 800 {
            size = CGSize(width: view.frame.width, height: view.frame.height + 250)
        } else if view.frame.height < 900 {
            size = CGSize(width: view.frame.width, height: view.frame.height + 50)
        } else {
            size = CGSize(width: view.frame.width, height: view.frame.height)
        }
        
        return size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        setupConstraints()
        
    }
    
    func SetupUI() {
        //Настраиваем картинку которую поместим в контейнер
        developerImageView = UIImageView(frame: imageContainer.bounds)
        developerImageView.image = developerImage
        developerImageView.clipsToBounds = true
        let cornerRadius = developerImageView.frame.height / 2
        developerImageView.layer.cornerRadius = cornerRadius
        
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = contentSize
        

        uiview.backgroundColor = .systemGray5
        uiview.frame.size = contentSize
    }
    
    func setupConstraints() {
        //Добавляем контейнер на Вьюху
        view.addSubview(scrollView)
        scrollView.addSubview(uiview)
        uiview.addSubview(imageContainer)
        uiview.addSubview(developerFirstLabel)
        uiview.addSubview(developerSecondLabel)
        
        scrollView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        // Расставляем ограничения для контейнера
        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: uiview.topAnchor, constant: 30),
            imageContainer.centerXAnchor.constraint(equalTo: uiview.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            developerFirstLabel.centerXAnchor.constraint(equalTo: uiview.centerXAnchor),
            developerFirstLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 50),
            developerFirstLabel.leftAnchor.constraint(equalTo: uiview.leftAnchor, constant: 30),
            developerFirstLabel.rightAnchor.constraint(equalTo: uiview.rightAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            developerSecondLabel.centerXAnchor.constraint(equalTo: uiview.centerXAnchor),
            developerSecondLabel.topAnchor.constraint(equalTo: developerFirstLabel.bottomAnchor, constant: 50),
            developerSecondLabel.leftAnchor.constraint(equalTo: uiview.leftAnchor, constant: 30),
            developerSecondLabel.rightAnchor.constraint(equalTo: uiview.rightAnchor, constant: -30)
        ])
        
        imageContainer.addSubview(developerImageView)
        
        // Расставляем ограничения для картинки в контейнере. Думаю можно оптимизировать
        NSLayoutConstraint.activate([
            developerImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            developerImageView.leftAnchor.constraint(equalTo: imageContainer.leftAnchor),
            developerImageView.rightAnchor.constraint(equalTo: imageContainer.rightAnchor),
            developerImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            developerImageView.heightAnchor.constraint(equalToConstant: 200),
            developerImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
