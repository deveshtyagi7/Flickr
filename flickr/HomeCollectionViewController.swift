//
//  HomeCollectionViewController.swift
//  flickr
//
//  Created by Devesh Tyagi on 19/04/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON


class HomeCollectionViewController: UICollectionViewController {
    

        
        
    
    @IBOutlet var imageCollectionView: UICollectionView!
    
     let photoCell = "photoCell"
    
    lazy var refresher : UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(loadImages), for: .valueChanged)
        
        return refreshControl
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.refreshControl = refresher
        loadImages()
        
       
        
    }
    

    
    var photos = [Photo]()
    
    @objc public func loadImages(){
        let mainUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&per_page=20&page=1&api_key=6f102c62f41998d151e5a1b48713cf13&format=json&nojsoncallback=1&extras=url_s"
           
        Alamofire.request(mainUrl , method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                let photoJSON : JSON = JSON(response.result.value!)
                self.downloadPhotosData(json: photoJSON)
                self.imageCollectionView.reloadData()
                self.refresher.endRefreshing()
            }
            else{
                print("error\(response.result.error)")
                   
            }
        }
           
    }
    func downloadPhotosData(json : JSON){
           let tempResult = json["photos"]["photo"].arrayObject
    
          
           for i in 0...json["photos"]["photo"].count-1{
               if let dict = tempResult![i] as? [String : Any]{
                    let newPhoto = Photo.transformPhoto(dict:dict)
                    self.photos.append(newPhoto)
               }
            print(photos[i].url_s)
            
               print(photos.count)
               
           }
           
               
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return photos.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCell, for: indexPath) as! ImageCollectionViewCell
        let photo = photos[indexPath.row]
        cell.photo = photo
    
      
    
        return cell
    }

   
    
}
extension HomeCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollectionView.frame.width/3-1, height: imageCollectionView.frame.width/3-1)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
