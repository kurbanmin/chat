//
//  ImagesDataSource.swift
//  Chat
//
//  Created by Qurban on 12.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation
protocol IImagesDataSource {
    var delegate: IImagesDataSourceDelegate? {get set}
}
protocol IImagesDataSourceDelegate: class {
    func loadImages(page: Int)
    func didSelect(image: UIImage)
}
class ImagesDataSource: NSObject, IImagesDataSource {
    weak var delegate: IImagesDataSourceDelegate?
    let space: CGFloat = 10
    var hits: [Hit] = []
    var collectionView: UICollectionView
    var page = 1
    var loading = true

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.collectionViewLayout = layout(space: space)
    }

    private func layout(space: CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        let width = (collectionView.frame.size.width - (space * 4)) / 3
        let height = width
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }

    func setup(hits: [Hit]) {
        self.hits += hits
        collectionView.performBatchUpdates({
            let indexPaths = (self.hits.count-20..<self.hits.count).map { IndexPath(row: $0, section: 0) }
            collectionView.insertItems(at: indexPaths)
        }, completion: nil)
        loading = false
    }
}
extension ImagesDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hits.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ImageCell",
            for: indexPath
            ) as? ImageCell
        else {
            return UICollectionViewCell()
        }

        let hit = self.hits[indexPath.row]
        cell.configure(hit: hit)

        return cell
    }
}

extension ImagesDataSource: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
        ) {
        if indexPath.row == hits.count-10 && !loading {
            loading = true
            page += 1
            delegate?.loadImages(page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ImageCell
        if let image = cell?.image {
            delegate?.didSelect(image: image)
        }
    }
}
