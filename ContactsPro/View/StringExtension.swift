//
//  StringExtension.swift
//  ContactsPro
//
//  Created by Sierra on 5/5/18.
//  Copyright © 2018 Nagiz. All rights reserved.
//

import Foundation
extension String{
    
func removeSpaces()->String{
    return self.replacingOccurrences(of: " ", with: "")
}
}
