//
//  FlickerSearchNSaveViewController.swift
//  manageImages
//
//  Created by Pratik Anilkumar Parmar on 10/11/17.
//  Copyright © 2017 Pratik Anilkumar Parmar. All rights reserved.
//

import UIKit
import CoreData

let tt = ""
var imageURL = URL(string: tt)
var req = URLRequest(url: imageURL!)


class FlickerSearchNSaveViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITextViewDelegate{

    
    @IBOutlet weak var textFlickerField: UITextField!
    
    @IBOutlet weak var longitudeTextField: UITextField!
    
    @IBOutlet weak var lantitudeTextField: UITextField!
   
    
    @IBOutlet weak var ImageViewFlicker: UIImageView!
    
    @IBOutlet weak var TitleOfImageTextFiled: UITextField!
    
    @IBOutlet weak var discriptionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        longitudeTextField.delegate = self as? UITextFieldDelegate
        longitudeTextField.keyboardType = .numberPad
        
        lantitudeTextField.delegate = self as? UITextFieldDelegate
        lantitudeTextField.keyboardType = .numberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchFlickerButton(_ sender: UIButton) {
    
        var flag = true
        if(textFlickerField.text == "")
        {
            //showing alert 
            let alertwindoew = UIAlertController(title: "ALERT", message: "Please add search value", preferredStyle: .alert)
            alertwindoew.addAction(UIAlertAction(title: "Ok", style:UIAlertActionStyle.default ,handler: {(action) in alertwindoew.dismiss(animated: true, completion: nil) }))
            self.present(alertwindoew, animated: true, completion:nil)
        }
        else
        {
            if(longitudeTextField.text != "")
            {
                let val_longitudeTextField = Double(longitudeTextField.text!)
                if(val_longitudeTextField! > 0 && val_longitudeTextField! < 181)
                    {}
                    else
                {
                    //showing alert
                    self.longitudeTextField.becomeFirstResponder()
                    let alertwindoew = UIAlertController(title: "ALERT", message: "Longitude value should be between 1 to 180", preferredStyle: .alert)
                    alertwindoew.addAction(UIAlertAction(title: "Ok", style:UIAlertActionStyle.default ,handler: {(action) in alertwindoew.dismiss(animated: true, completion: nil) }))
                    self.present(alertwindoew, animated: true, completion:nil)
                    flag = false
                   
                }
            }
            if(lantitudeTextField.text != "")
            {
                let val_lantitudeTextField = Double(lantitudeTextField.text!)
                if( val_lantitudeTextField!  > 0 && val_lantitudeTextField! < 91)
                {}
                else
                {
                    //showing alert
                    self.lantitudeTextField.becomeFirstResponder()
                    let alertwindoew = UIAlertController(title: "ALERT", message: "Lantitude value should be between 1 to 90", preferredStyle: .alert)
                    alertwindoew.addAction(UIAlertAction(title: "Ok", style:UIAlertActionStyle.default ,handler: {(action) in alertwindoew.dismiss(animated: true, completion: nil) }))
                    self.present(alertwindoew, animated: true, completion:nil)
                    flag = false

                }
            }
            
            if(flag==true)
            {
                urlNameSet()
                photoGet()
            }
            
        }
        
    }
    
    
    func urlNameSet()
    {
        
        let escapedSearchText: String = textFlickerField.text!.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
        let text = escapedSearchText   //textFlickerField.text!
        let longitude = longitudeTextField.text!
        let latitude = lantitudeTextField.text!
        var bbox = ""
        if(longitude.characters.count > 0 && latitude.characters.count > 0)
        {
            bbox="-\(longitude)%2C+-\(latitude)%2C+\(longitude)%2C+\(latitude)"
        }
        let api_key = "d7054e0325c0b81e33d1347c608e16bc"
        
        let urlname="https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(api_key)&text=\(text)&bbox=\(bbox)&per_page=25&format=json&nojsoncallback=1&extras=url_m%2Ctags%2Ctext"
        
        
        //print(urlname);
        imageURL = URL(string: urlname)
        req = URLRequest(url: imageURL!)
    }
    func photoGet()
    {
        let task = URLSession.shared.dataTask(with: req) {
            
            (data,response,error) in
            
           // print(data);
            //qrgcd to use for fst download
            if(error == nil || data?.count != 0)
            {
                let dta = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                let stat = try! dta["stat"] as! String
                
                if(stat == "ok")
                {
                    
                    print(dta);
                    let Photoes = try! dta["photos"] as! [String:AnyObject]
                    let libPhotoes = Photoes["photo"] as! [[String:AnyObject]]
                    
                    if(libPhotoes.count > 0)
                    {
                        DispatchQueue.global(qos: .userInitiated).async {
                            
                            let randon = Int(arc4random_uniform(UInt32(libPhotoes.count)))
                            if(libPhotoes.count > 0)
                            {
                                let urlName1 = libPhotoes[randon]["url_m"] as! String
                                let title = libPhotoes[randon]["title"] as! String
                                let discri = libPhotoes[randon]["tags"] as! String
                                
                                print(urlName1);
                                
                                //tcq study
                                DispatchQueue.main.async {
                                    
                                    let imageURLss = URL(string: urlName1)
                                    self.TitleOfImageTextFiled.text = title
                                    self.discriptionTextField.text = discri
                                    
                                    let imgdata = try! Data(contentsOf: imageURLss!)
                                    let imageView = UIImage(data: imgdata )!
                                    self.ImageViewFlicker.image = imageView;
                                }
                            }
                        }
                    }
                    else
                    {
                        
                        
                       // print("Zero result found ,please change search key words");
                        //if i dont add DispatchQueue here it shows error here ,Why? Idont know
                        DispatchQueue.main.async {
                        self.textFlickerField.becomeFirstResponder()
                        //showing alert on if photoes get are les then 0
                        let alertwindoew = UIAlertController(title: "ALERT", message: "No result found ,please try diffrent search key words", preferredStyle: .alert)
                        alertwindoew.addAction(UIAlertAction(title: "Ok", style:UIAlertActionStyle.default ,handler: {(action) in  alertwindoew.dismiss(animated: true, completion: nil) }))
                        self.present(alertwindoew, animated: true, completion:nil)
                        }
                        
                    }
                }
                else
                {
                    print("error in  stat : \(dta)");
                }
                
            }
            else
                
            {
                //print(error ?? "nnnnn")
            }
        }
        task.resume()
        
    }
    @IBAction func saveDataButton(_ sender: UIButton) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "PhotoLibraryDb", into: context)
        
        entity.setValue(TitleOfImageTextFiled.text,forKey: "dbTitle")
        entity.setValue(discriptionTextField.text,forKey: "dbDescription")
        
        let image = UIImageJPEGRepresentation(ImageViewFlicker.image!, 1)
        entity.setValue(image, forKey: "dbPic")
        
        
        do{
            try context.save()
            //print("Done");
            
            //showing alert on completing
            let alertwindoew = UIAlertController(title: "Saved", message: "Your image has been saved to Photo Library!", preferredStyle: .alert)
            alertwindoew.addAction(UIAlertAction(title: "Ok", style:UIAlertActionStyle.default ,handler: {(action) in alertwindoew.dismiss(animated: true, completion: nil) }))
            self.present(alertwindoew, animated: true, completion:nil)
            
        }
        catch{
            print("Error in data save");
        }

    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
