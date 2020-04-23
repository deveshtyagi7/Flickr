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
     let mainUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&per_page=21&api_key=6f102c62f41998d151e5a1b48713cf13&format=json&nojsoncallback=1&extras=url_s"
    
 
    
    lazy var refresher : UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(urlGenerator), for: .valueChanged)
        
        return refreshControl
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.refreshControl = refresher
        urlGenerator()
        self.imageCollectionView.reloadData()
        
        
    }
    

   // var photos = [Photo]()
    var all = [AllPhotos]()

    @objc public func urlGenerator(){
        let param1 : [String : Any] = ["page" : 1 ]
        let param2 : [String : Any] = ["page" : 2 ]
        let param3 : [String : Any] = ["page" : 3 ]
     //   photos.removeAll()
        all.removeAll()
            self.loadImages(url: self.mainUrl, parameters: param1)
            print("method 1 is called")
      
            sleep(1)
     
            self.loadImages(url: self.mainUrl, parameters: param2)
            print("method 2 is called")
       
               sleep(1)
      
//
       
            self.loadImages(url: self.mainUrl, parameters: param3)
            print("method 3 is called")

              sleep(1)


    }
    

    
    func loadImages(url : String ,parameters :[String : Any]){
        
             
           
        Alamofire.request(url , method: .get , parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess{
                print(parameters)
                let photoJSON : JSON = JSON(response.result.value!)
                let tempAll = photoJSON["photos"].object
                if let dict = tempAll as? [String : Any]{
                    let newAll = AllPhotos.transformAll(dict: dict , json : photoJSON)
                    
                    //self.downloadPhotosData(json: photoJSON ,newAll: newAll){
                        self.all.append(newAll)
                    self.imageCollectionView.reloadData()
                    //}
                    
                    
                }
            }
            else{
                print("error\(String(describing: response.result.error))")
                   
            }
          
             
            
            
        }.resume()
        
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return all.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
       
        
        return 21
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! ImageCollectionViewCell
        let allNumber = all[indexPath.section]
    
        print("all number ----------->\(indexPath.section)")
        let photo = allNumber.photo![indexPath.row]
       
      
        cell.photo = photo
    
      
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderCollectionReusableView
        let pagenumber = all[indexPath.section]
        sectionHeaderView.page = pagenumber
        return sectionHeaderView
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
