//
//  ViewController.swift
//  manageImages
//
//  Created by Pratik Anilkumar Parmar on 2/11/17.
//  Copyright © 2017 Pratik Anilkumar Parmar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var takephotoButton: NSLayoutConstraint!
    @IBAction func takePhotoButtonAction(_ sender: UIButton) {
        
       
    }
    
    @IBAction func searchPhotoButton(_ sender: Any) {
    }
}

