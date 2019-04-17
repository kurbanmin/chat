//
//  ImageCell.swift
//  Chat
//
//  Created by Qurban on 11.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityindicator: UIActivityIndicatorView!

    var hit: Hit?
    var image: UIImage?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(hit: Hit) {
        self.activityindicator.startAnimating()
        self.hit = hit
        self.image = nil
        self.imageView.image = nil

        guard let url = self.hit?.webformatURL else { return }

        self.imageView.setImage(url: url) { [weak self] (image, _, url) in
            if let image = image, self?.hit?.webformatURL == url {
                DispatchQueue.main.async {
                    self?.setup(image: image)
                }
            }
        }
    }

    func setup(image: UIImage) {
        self.image = image
        self.imageView.image = image
        self.activityindicator.stopAnimating()
    }
}
