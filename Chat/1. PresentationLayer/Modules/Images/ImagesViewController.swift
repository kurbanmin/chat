//
//  ImagesViewController.swift
//  
//
//  Created by Qurban on 12.04.2019.
//

import UIKit

protocol IImagesViewControllerDelegate: class {
    func didSelect(image: UIImage)
}

class ImagesViewController: UIViewController, IImagesModelDelegate, IImagesDataSourceDelegate {
    @IBOutlet var colletionView: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    weak var delegate: IImagesViewControllerDelegate?

    var imagesModel: ImagesModel?
    var presentationAssembly: PresentationAssembly?
    var dataSource: ImagesDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        dataSource = ImagesDataSource(collectionView: colletionView)
        dataSource?.delegate = self
        imagesModel?.loadImages(page: 1)
    }

    func configure(imagesModel: ImagesModel, presentationAssembly: PresentationAssembly) {
        self.imagesModel = imagesModel
        self.presentationAssembly = presentationAssembly
    }

    func setup(hits: [Hit]) {
        dataSource?.setup(hits: hits)
        colletionView.reloadData()
        self.activityIndicator.stopAnimating()
    }

    func didSelect(image: UIImage) {
        delegate?.didSelect(image: image)
        self.dismiss(animated: true, completion: nil)
    }

    func loadImages(page: Int) {
        imagesModel?.loadImages(page: page)
    }
}
