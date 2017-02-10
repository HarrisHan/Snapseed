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
    var maxHeight:CGFloat  = 0
    var minHeight:CGFloat  = 0
    
    var delegate:SnapMenueProtocal?
    
    var itemWidth:Double?
    var itemHeight:Double?
    
    var panGesture:SnapPanGestureRecognizer?
    
    fileprivate var items:Array<UILabel>?
    fileprivate var values:Array<UILabel>?
    
    fileprivate var positions:Array<Any>?
    fileprivate var labelNames:Array<String>?
    fileprivate var labelValues:Array<Double>?
    
    fileprivate var noOfElements:Int?
    
    fileprivate var chooseBar:UIView?
    fileprivate var chooseBarName:UILabel?
    fileprivate var chooseBarValue:UILabel?
    
    fileprivate var preTranslate = CGPoint(x: 0, y: 0)
    
    fileprivate var view:UIView?
    
    init(itemArray:Array<String>, valueArray:Array<Double>, height:Double, width:Double,viewController:UIViewController) {
        
        itemWidth  = width
        itemHeight = height
        
        noOfElements = itemArray.count
        
        labelNames  = itemArray
        labelValues = valueArray
        
        view = viewController.view
        
        maxHeight = view!.center.y + CGFloat((Double(noOfElements!) - 0.5) * height)
        minHeight = view!.center.y - (maxHeight - view!.center.y)
        
        positions  = Array()
        items      = Array()
        values     = Array()
        
        let totalHeight = Double(noOfElements!) * height
        
        let noOfHalfElements = noOfElements! / 2
        
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: totalHeight))
        
        panGesture = SnapPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        panGesture?.direction = .snapPanGestureRecognizerDirectionVertical
        self.backgroundColor = UIColor.white
        
        // each menue item's position
        for (index, _) in itemArray.enumerated() {
            if noOfElements! % 2 == 0 {
                positions?.append(CGFloat(noOfHalfElements - index) * CGFloat(height) - CGFloat(height / 2))
            } else {
                positions?.append(CGFloat(noOfHalfElements - index) * CGFloat(height))
            }
        }
        
        self.center = view!.center
        
        var frame = self.frame
        frame.origin.x = 0
        frame.origin.y = -25
        frame.size.height += 50
        
        let bottomView = UIView.init(frame: frame)
        bottomView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(bottomView)
        
        
        for (index, _) in itemArray.enumerated() {
            
            let containerView = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
            containerView.center = CGPoint(x: width / 2, y: (Double(index) * 2 + 1) * height / 2)
            
            let label = UILabel.init(frame: CGRect(x: 30, y: 12, width: 0, height: 0))
            label.text = itemArray[index]
            label.sizeToFit()
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.black.withAlphaComponent(0.6)
            
            let valueLabel = UILabel.init(frame: CGRect(x: 196, y: 12, width: 0, height: 0))
            valueLabel.text = String(format:"%.f",valueArray[index])//"\(valueArray[index])"
            valueLabel.sizeToFit()
            valueLabel.font = UIFont.systemFont(ofSize: 13)
            valueLabel.textColor = UIColor.black.withAlphaComponent(0.6)
            
            containerView.addSubview(label)
            containerView.addSubview(valueLabel)
            
            addSubview(containerView)
            
            items?.append(label)
            values?.append(valueLabel)
        }
        
        chooseBar = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        chooseBar?.center = view!.center;
        chooseBar?.backgroundColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        viewController.view.addSubview(chooseBar!)
        viewController.view.addSubview(self)
        viewController.view.bringSubview(toFront: chooseBar!)
        
        chooseBarName  = UILabel.init(frame: CGRect(x: 30,  y: 12, width: 0, height: 0))
        chooseBarName?.font = UIFont.systemFont(ofSize: 13)
        chooseBarName?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        chooseBarValue = UILabel.init(frame: CGRect(x: 196, y: 12, width: 0, height: 0))
        chooseBarValue?.font = UIFont.systemFont(ofSize: 13)
        chooseBarValue?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        chooseBar?.addSubview(chooseBarName!)
        chooseBar?.addSubview(chooseBarValue!)
        
        self.alpha = 0
        chooseBar?.alpha = 0
        
    }
    
    
    
    func pan(sender: UIPanGestureRecognizer) {
        
        let translate = sender.translation(in:view)
        
        // appear animation
        UIView.animate(withDuration: 0.2, delay: 0, options: .beginFromCurrentState, animations: {
            self.alpha = 1
            self.chooseBar?.alpha = 1
        }, completion: nil)
        
        var newFrame = self.frame
        newFrame.origin.y += (translate.y - preTranslate.y)
        
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
        chooseBarName?.text  = labelNames?[lastIndex]
        chooseBarValue?.text = String(format:"%.f",(labelValues?[lastIndex])!)
        chooseBarName?.sizeToFit()
        chooseBarValue?.sizeToFit()
        
        for (index, _) in (items?.enumerated())! {
            let nameLable  = items?[index]
            let valueLable = values?[index]
            
            if index == lastIndex {
                nameLable?.text  = ""
                valueLable?.text = ""
            } else {
                nameLable?.text  = labelNames?[index]
                valueLable?.text = String(format:"%.f",(labelValues?[index])!)
                valueLable?.sizeToFit()
            }
            
        }
        
        preTranslate = translate
        
        if sender.state == .ended {
            
            // hidden
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.alpha = 0
                self.chooseBar?.alpha = 0
            }, completion: nil)
            
            preTranslate = CGPoint(x: 0, y: 0)
            
            //adjust menue position
            UIView.animate(withDuration: 0.0, delay: 0.2, options: .beginFromCurrentState, animations: {
                self.center = CGPoint(x: self.center.x, y: (self.view?.center.y)! + ((self.positions?[lastIndex])! as! CGFloat))
            }, completion: nil)
            
            self.delegate?.menueSelectedWithIndex(index: lastIndex)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setValueAtIndex(index:Int, value:Double) {
        labelValues?[index] = Double(value)
        items?[index].text  = "\(value)"
    }
    
    
    
}
