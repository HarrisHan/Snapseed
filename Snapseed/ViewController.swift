//
//  ViewController.swift
//  Snapseed
//
//  Created by harris on 08/02/2017.
//  Copyright © 2017 harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var items: Array<String>?
    var values:Array<Double>?
    
    var panGes: SnapPanGestureRecognizer?
    
    var menu: SnapMenue?
    
    var topSlider: SnapTopSlider?
    
    
    var selectedIndex: Int?
    
    var preTranslate = CGPoint(x: 0, y: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.96465832, blue: 0.8430851102, alpha: 1)
        selectedIndex = 2
        menueTesting()
    }
    
    func menueTesting() {
    items  = Array.init(arrayLiteral: "亮度","高光","阴影","强度","锐度","饱和度","对比度")
    values = Array.init(arrayLiteral: 0,0,0,0,0,0,0)
        
        menu = SnapMenue.init(itemArray: items!, valueArray: values!, height: 42, width: 245, viewController: self)
        menu?.delegate = self
        
        self.view.addGestureRecognizer((menu?.panGesture)!)
        
        panGes = SnapPanGestureRecognizer(target: self, action: #selector(changeValue(sender:)))
        panGes?.direction = .snapPanGestureRecognizerDirectionHorizental
        self.view.addGestureRecognizer(panGes!)
        
        topSlider = SnapTopSlider.init(name: "", value: 0)
        topSlider?.backgroundColor = UIColor.clear
        topSlider?.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 11)
        self.view.addSubview(topSlider!)
    }

    
        
    func changeValue(sender: UIPanGestureRecognizer) {
    
        let translate = sender.translation(in: self.view)
        
        values?[selectedIndex!] = values![selectedIndex!] + Double(suitableValue(point: translate).x - preTranslate.x)
        
        menu?.setValueAtIndex(index: selectedIndex!, value: (values?[selectedIndex!])!)
        
        topSlider?.update(name: (items?[selectedIndex!])!, value: (values?[selectedIndex!])!)
        
        preTranslate = suitableValue(point: translate)
        
        if sender.state == .ended {
            preTranslate = CGPoint(x: 0, y: 0)
            topSlider?.coverHidden()
        }
        
    }

    // reduce the sliding speed
    func suitableValue(point: CGPoint) -> CGPoint {
        var suitablePoint = point
        suitablePoint.x = (point.x / 3)
        return suitablePoint
    }
    

    @IBAction func Appear(_ sender: UIButton) {
     menu!.appear()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: SnapMenueProtocal {
    
    func menueSelectedWithIndex(index: Int) {
        selectedIndex = index
       topSlider?.coverHidden()
    }
    
    func selectWhileTracking(index: Int) {
        topSlider?.update(name: (items?[index])!, value: (values?[index])!)
    }
}


