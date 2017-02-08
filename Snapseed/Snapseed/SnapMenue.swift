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
    var maxHeight:CGFloat  = 100.0
    var minHeight:CGFloat  = 100.0
    
    var delegate:SnapMenueProtocal?
    
    var itemWidth:Double?
    var itemHeight:Double?
    
    var panGesture:SnapPanGestureRecognizer?
    
    fileprivate var items:Array<Any>?
    fileprivate var values:Array<Any>?
    
    fileprivate var positions:Array<Any>?
    fileprivate var nameLabels:Array<String>?
    fileprivate var valueLabels:Array<Any>?
    
    fileprivate var noOfElements:Int?
    
    fileprivate var chooseBar:UIView?
    fileprivate var chooseBarName:UILabel?
    fileprivate var chooseBarValue:UILabel?
    
    fileprivate var view:UIView?
    
    init(itemArray:Array<String>, valueArray:Array<String>, height:Double, width:Double,viewController:UIViewController) {
        
        itemWidth  = width
        itemHeight = height
        
        noOfElements  = itemArray.count
        
        items  = itemArray
        values = valueArray
        
        view = viewController.view
        
        values     = Array()
        positions  = Array()
        nameLabels = Array()
        
        let totalHeight = Double(noOfElements!) * height
        
        super.init(frame: CGRect(x: 0, y: 0, width: Int(width), height: Int(totalHeight)))
        
        panGesture = SnapPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        panGesture?.direction = .snapPanGestureRecognizerDirectionVertical
        self.backgroundColor = UIColor.blue
        
        // each menue item's position
        for (index, _) in itemArray.enumerated() {
            if noOfElements! % 2 == 0 {
                positions?.append(Double(noOfElements! - index) * height - height / 2)
            } else {
                positions?.append(Double(noOfElements! - index) * height)
            }
        }
        
        self.center = viewController.view.center
        
        for (index, _) in itemArray.enumerated() {
            let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
            label.text = itemArray[index]
            label.center = CGPoint(x: width / 2, y: (Double(index) * 2 + 1) * height / 2)
            
            let valueLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
            valueLabel.text = valueArray[index]
            valueLabel.textAlignment = .right
            valueLabel.center = CGPoint(x: width / 2, y: (Double(index) * 2 + 1) * height / 2)
            
            addSubview(label)
            addSubview(valueLabel)
            
            items?.append(label)
            values?.append(valueLabel)
        }
        
        chooseBar = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        chooseBar?.center = viewController.view.center;
        chooseBar?.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        viewController.view.addSubview(chooseBar!)
        viewController.view.addSubview(self)
        viewController.view.bringSubview(toFront: chooseBar!)
        
        
        self.alpha = 0
        chooseBar?.alpha = 0
        
    }
    
    
    
    func pan(sender: UIPanGestureRecognizer) {
        var preTranslate :CGPoint?
        
        let translate = sender.translation(in:view)
        
        // appear animation
        UIView.animate(withDuration: 0.2, delay: 0, options: .beginFromCurrentState, animations: {
            self.alpha = 1
            self.chooseBar?.alpha = 1
        }, completion: nil)
        
        var newFrame = self.frame
        newFrame.origin.y += (translate.y - (preTranslate?.y)!)
        
        if !(newFrame.origin.y < minHeight || newFrame.origin.y + newFrame.size.height > maxHeight) {
            self.frame = newFrame
        }
        
        let currentCenterY = self.center.y
        var pointIndex = 0
        var lastValue:CGFloat = 99999.0
        
        for (index, _) in (positions?.enumerated())! {
            
            let positonY = (view?.center.y)! - ((positions?[index])! as! CGFloat)
            let newValue = fabs(positonY - currentCenterY)
            if newValue < lastValue {
                lastValue = newValue
                pointIndex = index
            }
        }
        
        let lastIndex = Int(noOfElements! - pointIndex - 1)
        // here to set the chooseBar text and value
        
        for (index, _) in (nameLabels?.enumerated())! {
            
            
        }
        
        preTranslate = translate
        
        // end of pan
        if sender.state == .ended {
            // hidden
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.alpha = 0
                
            }, completion: nil)
            preTranslate = CGPoint(x: 0, y: 0)
            
            //adjust menue position
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .beginFromCurrentState, animations: { 
                self.center = CGPoint(x: self.center.x, y: (self.view?.center.y)! + ((self.positions?[lastIndex])! as! CGFloat))
            }, completion: nil)
            
            self.delegate?.menueSelectedWithIndex(index: lastIndex)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setValueAtIndex(index:Int, value:CGFloat) {
        values?[index] = value
        
    }
    
    
    
}
