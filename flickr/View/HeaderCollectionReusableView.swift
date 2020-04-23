//
//  HeaderCollectionReusableView.swift
//  flickr
//
//  Created by Devesh Tyagi on 21/04/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    var page : AllPhotos?{
        didSet{
            updateHeaderText()
           
        }
    }
    
    func updateHeaderText(){
        
        if let pageNum = page?.page{
              headerLabel.text = "Page \(pageNum)"
        }
    }
}

