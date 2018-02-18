//
//  RoundedCornerView.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 18/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class RoundedCornerView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 15.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5.0
    }
}
