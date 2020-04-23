//
//  ImageCollectionViewCell.swift
//  flickr
//
//  Created by Devesh Tyagi on 19/04/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo : Photo?{
        didSet{
            updateImageCollection()
        }
    }
    
    func updateImageCollection(){
        if let photoUrlString = photo?.url_s{
            let photoURL = URL(string: photoUrlString)
            photoImageView.sd_setImage(with: photoURL)
            }
    }
    
}
