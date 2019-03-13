//
//  ProfileViewController.swift
//  Chat
//
//  Created by Qurban on 09.02.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var operationButton: UIButton!
    @IBOutlet weak var gcdButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let gcdDataManager: DataManagerProtocol = GCDDataManager()
    let operationDataManager: DataManagerProtocol = OperationDataManager()
    
    var profile = Profile()
    var tmpProfile = Profile()
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoAction(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        editMode(enabled: true)
    }
    
    @IBAction func gcdAction(_ sender: UIButton) {
        gcdSave()
    }
    
    @IBAction func operationAction(_ sender: UIButton) {
        operationSave()
    }
    
    @IBAction func textFieldDidChanged(_ sender: UITextField) {
        check()
    }
    
    func editMode(enabled: Bool) {
        gcdButton.isHidden = !enabled
        operationButton.isHidden = !enabled
        photoButton.isEnabled = enabled
        descriptionTextView.isEditable = enabled
        nameTextField.isEnabled = enabled
        editButton.isHidden = enabled
    }
    
    func enableButtons(enabled: Bool) {
        gcdButton.isEnabled = enabled
        operationButton.isEnabled = enabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.delegate = self
        
        activityIndicator.startAnimating()
        
        operationDataManager.loadProfile { [weak self] (profile) in
            if let profile = profile {
                self?.profile = profile
                self?.nameTextField.text = self?.profile.name
                self?.descriptionTextView.text = self?.profile.description
                self?.profileImageView.image = self?.profile.image
                self?.check()
                self?.activityIndicator.stopAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
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
    }
    
    func gcdSave() {
        tmpProfile = profile
        profile.name = nameTextField.text
        profile.description = descriptionTextView.text
        profile.image = profileImageView.image
        
        activityIndicator.startAnimating()
        enableButtons(enabled: false)
        
        gcdDataManager.save(profile: profile) { [weak self] success in
            if success {
                self?.showSuccessAlert()
            } else {
                self?.showErrorAlert(gcd: true)
                if let tmpProfile = self?.tmpProfile {
                    self?.profile = tmpProfile
                }
            }
        }
    }
    
    func operationSave() {
        tmpProfile = profile
        profile.name = nameTextField.text
        profile.description = descriptionTextView.text
        profile.image = profileImageView.image
        
        activityIndicator.startAnimating()
        enableButtons(enabled: false)
        
        operationDataManager.save(profile: profile) { [weak self] success in
            if success {
                self?.showSuccessAlert()
            } else {
                self?.showErrorAlert(gcd: false)
                if let tmpProfile = self?.tmpProfile {
                    self?.profile = tmpProfile
                }
            }
        }
    }
    
    func check() {
        if profile.name == nameTextField.text && profile.description == descriptionTextView.text && profile.image?.pngData() == profileImageView.image?.pngData() {
            enableButtons(enabled: false)
        }
        else {
            enableButtons(enabled: true)
        }
    }
    
    func showSuccessAlert() {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default) { [weak self] (action) in
            self?.editMode(enabled: false)
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showErrorAlert(gcd: Bool) {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok", style: .default) { (action) in
            self.editMode(enabled: false)
        }
        
        let repeatAction = UIAlertAction(title: "Повторить", style: .default) { [weak self] (action) in
            self?.activityIndicator.startAnimating()
            if gcd {
                self?.gcdSave()
            } else {
                self?.operationSave()
            }
        }
        alert.addAction(alertAction)
        alert.addAction(repeatAction)
        present(alert, animated: true)
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
            check()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
extension ProfileViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        check()
    }
}
