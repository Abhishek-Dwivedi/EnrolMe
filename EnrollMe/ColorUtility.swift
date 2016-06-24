//
//  ColorUtility.swift
//  QuotesApp
//
//  Created by Abhishek Dwivedi on 09/05/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

import UIKit
/*
A UIColor extension to add randomColor function to UIColot
*/
extension UIColor {

    static func randomColor() -> UIColor {
        
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
        let randomAlpha = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue:randomBlue, alpha: randomAlpha)
    }
}
