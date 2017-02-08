//
//  ViewController.swift
//  Snapseed
//
//  Created by harris on 08/02/2017.
//  Copyright © 2017 harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var items:Array<Any>?
    var values:Array<Any>?
    
    var panGes:SnapPanGestureRecognizer?
    
    var menu:SnapMenue?
    
    var selectedIndex:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menueTesting()
    }
    
    func menueTesting() {
    items  = Array.init(arrayLiteral: "1","2","3","4")
    values = Array.init(arrayLiteral: "0","0","0","0")
        
        menu = SnapMenue.init(itemArray: items as! Array<String>, valueArray: values as! Array<String>, height: 50, width: 250, viewController: self)
        
        self.view.addGestureRecognizer((menu?.panGesture)!)
        
        panGes = SnapPanGestureRecognizer(target: self, action: #selector(changeValue(sender:)))
        panGes?.direction = .snapPanGestureRecognizerDirectionHorizental
        
        self.view.addGestureRecognizer(panGes!)
        
    }

    
    
    
    
    func changeValue(sender: UIPanGestureRecognizer) {
    
        var preTranslate = CGPoint(x: 0, y: 0)
        
        let translate = sender.translation(in: self.view)
        
        values?[selectedIndex!] = values![selectedIndex!] as! CGFloat + (translate.x - preTranslate.x)
        
        menu?.setValueAtIndex(index: selectedIndex!, value: values?[selectedIndex!] as! CGFloat)
        
        preTranslate = translate
        
        if sender.state == .ended {
            preTranslate = CGPoint(x: 0, y: 0)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: SnapMenueProtocal {
    
    func menueSelectedWithIndex(index: Int) {
        selectedIndex = index
    }
}


