//
//  SnapTopSlider.swift
//  Snapseed
//
//  Created by harris on 10/02/2017.
//  Copyright © 2017 harris. All rights reserved.
//

import UIKit

class SnapTopSlider: UIView {
    
    fileprivate let screenWidth = UIScreen.main.bounds.size.width
    fileprivate var coverLayer: CALayer?
    fileprivate var textLayer: CATextLayer?
    fileprivate var leftProgressLayoutWidth: NSLayoutConstraint?
    fileprivate var rightProgressLayoutWidth: NSLayoutConstraint?
    
    override func draw(_ rect: CGRect) {
        
        let fillColor  = UIColor(red: 0.180, green: 0.180, blue: 0.180, alpha: 1.000)
        let fillColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.800)
        let fillColor3 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.200)
        
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: screenWidth, height: 5))
        fillColor.setFill()
        rectanglePath.fill()
        
        let rectangle2Path = UIBezierPath(rect: CGRect(x: screenWidth / 2, y: 0, width: 1, height: 11))
        fillColor2.setFill()
        rectangle2Path.fill()
        
        let rectangle3Path = UIBezierPath(rect: CGRect(x: screenWidth / 4, y: 0, width: 1, height: 5))
        fillColor3.setFill()
        rectangle3Path.fill()
        
        let rectangle4Path = UIBezierPath(rect: CGRect(x: screenWidth / 4 * 3, y: 0, width: 1, height: 5))
        fillColor3.setFill()
        rectangle4Path.fill()
    }
    
    init(name:String,value:Double) {
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 11))
        
        let coverLayerHight: CGFloat = 40
        
        coverLayer = CALayer.init()
        coverLayer!.frame = CGRect(x: 0, y: 5, width: screenWidth, height: coverLayerHight)
        coverLayer!.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.addSublayer(coverLayer!)
        
        let textLayerWidth:  CGFloat = 75
        let textLayerHeight: CGFloat = 18
        
        textLayer = CATextLayer.init()
        textLayer?.fontSize = 13
        textLayer?.alignmentMode = "center"
        textLayer?.contentsScale = UIScreen.main.scale
        textLayer?.frame = CGRect(x: (screenWidth - textLayerWidth) / 2, y: (coverLayerHight - textLayerHeight) / 2, width: textLayerWidth, height: textLayerHeight)
        coverLayer?.addSublayer(textLayer!)
        
        coverLayer?.opacity = 0
        
        let margin = self.layoutMarginsGuide
        
        let rightProgressView = UIView.init()
        rightProgressView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        rightProgressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rightProgressView)
        rightProgressView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        rightProgressView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        rightProgressView.leadingAnchor.constraint(equalTo: margin.leadingAnchor, constant: screenWidth / 2 - 8).isActive = true
        rightProgressLayoutWidth = rightProgressView.widthAnchor.constraint(equalToConstant: 0)
        rightProgressLayoutWidth?.isActive = true

        let leftProgressView = UIView.init()
        leftProgressView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        leftProgressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftProgressView)
        leftProgressView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        leftProgressView.topAnchor.constraint(equalTo: margin.topAnchor).isActive = true
        leftProgressView.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -screenWidth / 2 + 8).isActive = true
        leftProgressLayoutWidth = leftProgressView.widthAnchor.constraint(equalToConstant: 0)
        leftProgressLayoutWidth?.isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(name:String, value:Double) {
        coverLayer?.opacity = 1
        textLayer?.string = name + String(format:" %.f",value)
        if value >= 0 {
            leftProgressLayoutWidth?.constant = 0
            rightProgressLayoutWidth?.constant = CGFloat(value)
        }
        else {
            rightProgressLayoutWidth?.constant = 0
            leftProgressLayoutWidth?.constant = abs(CGFloat(value))
        }
        
    }
    
    func coverHidden() {
        coverLayer?.opacity = 0
    }
    
}
