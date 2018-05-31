//
//  PhotoClass.swift
//  manageImages
//
//  Created by Pratik Anilkumar Parmar on 7/11/17.
//  Copyright © 2017 Pratik Anilkumar Parmar. All rights reserved.
//

import UIKit

class PhotoClass: NSObject {
    
    var Title:String = ""
    var Date:String = ""
    var Location:String = ""
    
    init(Title:String,Location:String,Date:String) {
        self.Title = Title
        self.Date = Date
        self.Location = Location
    }
    
    class func generateModelArray() -> [PhotoClass]{
        var PhotoClassArray = [PhotoClass]()       
       
        
        return PhotoClassArray
    }


}
