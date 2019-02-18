//
//  ViewController.swift
//  Chat
//
//  Created by Qurban on 09.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func photoAction(_ sender: UIButton) {
        showAlert()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Ошибка: в данном методе кнопка не создана
        // print(editButton.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.log(#function)
        // Расположение кнопки до вычисления констрейнтов
        print(editButton.frame)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger.log(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Logger.log(#function)
        // Расположение кнопки после вычисления констрейнтов
        print(editButton.frame)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Logger.log(#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Logger.log(#function)
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger.log(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger.log(#function)
    }
    
    func setupUI() {
        photoButton.layer.cornerRadius = photoButton.frame.size.width / 2
        photoButton.clipsToBounds = true
        
        profileImageView.layer.cornerRadius = photoButton.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        editButton.layer.cornerRadius = 10
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 2
        editButton.setTitleColor(.black, for: .normal)
        
        nameLabel.text = "Курбан Минкаилов"
        descriptionLabel.text = "👨‍💻Люблю программировать под IOS\n👨‍🎓Изучать новые технологии\n👨‍🏫Помогаю развиваться другим"
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Выберите изображение профиля", preferredStyle: .actionSheet)
        
        let galeryAction = UIAlertAction(title: "Установить из галлереи", style: .default) { action in
            self.showImagePicker(sourceType: .photoLibrary)
        }
        
        let cameraAction = UIAlertAction(title: "Сделать фото", style: .default) { action in
            self.showImagePicker(sourceType: .camera)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(galeryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

