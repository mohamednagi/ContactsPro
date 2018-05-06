//
//  ViewsShap.swift
//  ContactsPro
//
//  Created by Sierra on 5/6/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import UIKit
class ViewsShap{
   class func rounded(view:UIView, radius:CGFloat){
        view.layer.borderColor = UIColor(red: 0.27, green: 0.69, blue: 0.60, alpha: 1.00).cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
}

