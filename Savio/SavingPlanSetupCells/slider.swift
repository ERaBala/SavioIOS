//
//  slider.swift
//  Savio
//
//  Created by Maheshwari on 07/06/16.
//  Copyright © 2016 Prashant. All rights reserved.
//

import UIKit

class slider: UISlider {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        var bounds: CGRect = self.bounds
        bounds = CGRectInset(bounds, -10, -15)
        return CGRectContainsPoint(bounds, point)
    }
}
