//
//  SnapTopSlider.swift
//  Snapseed
//
//  Created by harris on 10/02/2017.
//  Copyright © 2017 harris. All rights reserved.
//

import UIKit

class SnapTopSlider: UIControl {

    fileprivate let screenWidth = UIScreen.main.bounds.size.width
    fileprivate var coverLayer: CALayer?
    fileprivate var textLayer: CATextLayer?
    fileprivate var progressLayer: CALayer?
    
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
        textLayer?.string = "亮度 100"
        textLayer?.alignmentMode = "center"
        textLayer?.contentsScale = UIScreen.main.scale
        textLayer?.frame = CGRect(x: (screenWidth - textLayerWidth) / 2, y: (coverLayerHight - textLayerHeight) / 2, width: textLayerWidth, height: textLayerHeight)
        coverLayer?.addSublayer(textLayer!)
        
        coverLayer?.opacity = 0
        
        progressLayer = CALayer.init()
        progressLayer?.backgroundColor = UIColor.orange.cgColor
        progressLayer?.frame = CGRect(x: screenWidth / 2, y: 0, width: 0, height: 5)
        
        layer.addSublayer(progressLayer!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(name:String, value:Double) {
        coverLayer?.opacity = 1
        textLayer?.string = name + String(format:" %.f",value)
        var frame = progressLayer?.frame
        if value >= 0 {
        frame?.size.width = CGFloat(value)
        frame?.origin.x = screenWidth / 2
        progressLayer?.frame = frame!
        }
        else {
        frame?.size.width = abs(CGFloat(value))
        frame?.origin.x = (screenWidth / 2) - abs(CGFloat(value))
            progressLayer?.frame = frame!
        }
        
    }
    
    func coverHidden() {
    coverLayer?.opacity = 0
    }
    
}
