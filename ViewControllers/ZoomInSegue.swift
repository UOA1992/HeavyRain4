//
//  ZoomInSegue.swift
//  HeavyRain4
//
//  Created by Edward L Richardson on 8/22/18.
//  Copyright © 2018 Edward L Richardson. All rights reserved.
//

import Foundation
import UIKit

class ZoomInSegue : UIStoryboardSegue {
    
    override func perform() {
        zoomIn()
    }
    
    func zoomIn() {
        let superView = self.source.view.superview
        let center = self.source.view.center
        
        self.destination.view.transform = CGAffineTransform.init(scaleX: 0.05, y: 0.05).rotated(by: 90 * .pi / 180)
        self.destination.view.center = center
        
        superView?.addSubview(self.destination.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.destination.view.transform = CGAffineTransform.identity
        }, completion: { success in
            self.source.present(self.destination, animated: false, completion: nil)
        })
    }
}
