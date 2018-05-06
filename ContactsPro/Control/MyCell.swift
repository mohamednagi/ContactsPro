//
//  MyCell.swift
//  ContactsPro
//
//  Created by Sierra on 5/6/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit

//protocol MyCellDelegate:class {
//    func delete(cell: MyCell)
//}
protocol DataCollectionProtocol {
//    func passData(index:Int)
    func deleteData(index:Int)
}

class MyCell: UICollectionViewCell {
    
    @IBOutlet weak var DeleteButtonBackgroundView: UIVisualEffectView!
//    weak var delegate:MyCellDelegate?
    
    var delegate:DataCollectionProtocol?
    var index:IndexPath?
    
    func EditMe(){
        ViewsShap.rounded(view: DeleteButtonBackgroundView, radius: 10)
        DeleteButtonBackgroundView.isHidden = !isEditing
    }
    
    var isEditing:Bool = false {
        didSet{
        DeleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    
    @IBAction func DeletebuttonDidTapped(_ sender: UIButton) {
//        delegate?.delete(cell: self)
        delegate?.deleteData(index: (index?.row)!)
        
    }
    
}
