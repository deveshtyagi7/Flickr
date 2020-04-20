//
//  Model.swift
//  flickr
//
//  Created by Devesh Tyagi on 18/04/20.
//  Copyright © 2020 Devesh Tyagi. All rights reserved.
//

import Foundation


class All{
    var page : Int?
    var pages : Int?
    var perpage : Int?
    var total : Int?
    var photo : [Photo]?

}
class Photo{
        
    var id : String?
    var owner : String?
    var secret : String?
    var server : String?
    var farm : Int?
    var title : String?
    var ispublic : Int?
    var isfriend : Int?
    var isfamily : Int?
    var url_s : String?
    var height_s : Int?
    var width_s : Int?
    


    
}

extension Photo{
    
    public static func transformPhoto(dict : [String : Any]) -> Photo{
       
        let photo = Photo()
        photo.owner = dict["owner"] as? String
        photo.secret = dict["secret"] as? String
        photo.server = dict["server"] as? String
        photo.farm = dict["farm"] as? Int
        photo.title = dict["title"] as? String
        photo.ispublic = dict["ispublic"] as? Int
        photo.isfriend = dict["isfriend"] as? Int
        photo.url_s = dict["url_s"] as? String
        photo.height_s = dict["height_s"] as? Int
        photo.width_s = dict["width_s"] as? Int
        
        

            return photo
        
    }
}

