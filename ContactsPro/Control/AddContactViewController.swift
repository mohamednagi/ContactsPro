//
//  AddContactViewController.swift
//  ContactsPro
//
//  Created by Sierra on 5/5/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTF.delegate=self
        phoneTF.delegate=self
        nameTF.becomeFirstResponder()
        
        ViewsShap.rounded(view: nameTF, radius: 5)
        ViewsShap.rounded(view: phoneTF, radius: 5)
        ViewsShap.rounded(view: image, radius: 50)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTF.resignFirstResponder()
        phoneTF.resignFirstResponder()
        return true
    }
    
    @IBAction func SelectPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate=self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerEditedImage]
        image.image = selectedImage as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any) {
        if (nameTF.text?.isEmpty)! || (phoneTF.text?.isEmpty)! || image.image == nil {
            let alert = UIAlertController(title: "All Required", message: "Please Provide name , phone number and photo to the new contact", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let name = nameTF.text!
        let phone = phoneTF.text!
        let imageName = name.removeSpaces()
        let randomInt = arc4random_uniform(1000)
        let finalimageName = "\(imageName)\(randomInt)"
        let newContact = Contact(name: name, phone: phone, imageName: finalimageName)
        ContactsArray.insert(newContact, at: 0)
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: ContactsArray)
        userDefaults.set(archivedData, forKey: "contacts")
        
        let selectedimage = image.image!
        if let jpgimage = UIImageJPEGRepresentation(selectedimage, 0.8){
            let urlpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let directory = urlpath[0]
            let imagepath = directory.appendingPathComponent(finalimageName)
            
            try? jpgimage.write(to: imagepath)
        }
        nameTF.text = ""
        phoneTF.text = ""
        image.image = nil
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BackMe(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
