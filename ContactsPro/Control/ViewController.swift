//
//  ViewController.swift
//  ContactsPro
//
//  Created by Sierra on 5/5/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit

var ContactsArray = [Contact]()
var userDefaults = UserDefaults.standard

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
   
    @IBOutlet weak var AddButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var contactimgview: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let unarchivedData = userDefaults.object(forKey: "contacts") as? Data
        if let unarchivedData = unarchivedData{
            ContactsArray = NSKeyedUnarchiver.unarchiveObject(with: unarchivedData) as! [Contact]
            if ContactsArray.count > 0 {
                let singleContact = ContactsArray[0]
                nameLabel.text = singleContact.name
                phoneLabel.text = singleContact.phone
                let imagepath = imagePath(imageName: singleContact.imageName)
                let image = UIImage(contentsOfFile: imagepath.path)
                contactimgview.image = image
            }
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        ViewsShap.rounded(view: contactimgview, radius: 110)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ContactsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "contactCell", for: indexPath) as! MyCell
        cell.EditMe()
        cell.index = indexPath
        cell.delegate=self
        let imgView = cell.viewWithTag(10) as! UIImageView
        let contact = ContactsArray[indexPath.row]
        let imageName = contact.imageName
        let imagepath = imagePath(imageName: imageName)
        let image = UIImage(contentsOfFile: imagepath.path)
        imgView.image = image
        ViewsShap.rounded(view: imgView, radius: 50)
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 3.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contact = ContactsArray[indexPath.row]
        let imageName = contact.imageName
        let imagepath = imagePath(imageName: imageName)
        let name = contact.name
        let phone = contact.phone
        let image = UIImage(contentsOfFile: imagepath.path)
        
        nameLabel.text = name.uppercased()
        phoneLabel.text = phone
        contactimgview.image = image
    }
    
    func imagePath(imageName:String) -> URL {
        let urlpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let directory = urlpath[0]
        let imagepath = directory.appendingPathComponent(imageName)
        return imagepath
    }
    
//    Delete Items's mark shows
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        AddButton.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexpath in indexPaths{
                if let cell = collectionView?.cellForItem(at: indexpath) as? MyCell{
                    cell.isEditing=true
                }
            }
        }
    }
}
extension ViewController:DataCollectionProtocol{
    func deleteData(index: Int) {
        ContactsArray.remove(at: index)
        collectionView.reloadData()
    }
}
