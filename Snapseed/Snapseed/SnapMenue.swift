//
//  SnapMenue.swift
//  Snapseed
//
//  Created by harris on 08/02/2017.
//  Copyright © 2017 harris. All rights reserved.
//

import UIKit

protocol SnapMenueProtocal {
    func menueSelectedWithIndex(index:Int)
}

class SnapMenue: UIView {
    var maxHeight = 100
    var maxWidth  = 100
    
    var delegate:SnapMenueProtocal?
    
    var itemWidth:Float?
    var itemHeight:Float?
    
    var panGesture:SnapPanGestureRecognizer?
    
    fileprivate var items:Array<Any>?
    fileprivate var values:Array<Any>?
    
    fileprivate var positions:Array<Any>?
    fileprivate var nemeLabels:Array<Any>?
    fileprivate var valueLabels:Array<Any>?
    
    fileprivate var noOfElements:Int?
    
    fileprivate var chooseBar:UIView?
    fileprivate var chooseBarName:UILabel?
    fileprivate var chooseBarValue:UILabel?
    
    init(itemArray:Array<Any>, valueArray:Array<Any>, height:Float, width:Float,delegate:SnapMenueProtocal) {
        super.init(frame: UIScreen.main.bounds)
        itemWidth  = width
        itemHeight = height
        
        self.delegate = delegate
        noOfElements  = itemArray.count
        
        items  = itemArray
        values = valueArray
        
        values     = Array()
        positions  = Array()
        nemeLabels = Array()
        
        let totalHeight = Float(noOfElements!) * height
        let noOfHalfOfItems = noOfElements! / 2
        
        panGesture = SnapPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        panGesture?.direction = .snapPanGestureRecognizerDirectionVertical
        self.backgroundColor = UIColor.blue
        
        // each menue item's position
        
    }

    
    func pan(sender: UIPanGestureRecognizer) {
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
    func setValueAtIndex(index:Int, value:CGFloat) {
    
    }

    
    
}
