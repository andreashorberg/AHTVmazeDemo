//
//  TVShowCell.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-12.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class TVShowCell: UICollectionViewCell {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        updateWith(nil)
        title.text = ""
    }

    func updateWith(_ image: UIImage?) {
        if let image = image {
            self.image.image = image
            loader.stopAnimating()
        } else {
            loader.startAnimating()
            self.image.image = nil
        }
    }
}
