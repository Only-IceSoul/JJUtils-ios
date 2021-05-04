//
//  ViewController.swift
//  jjutils
//
//  Created by only-icesoul on 04/29/2021.
//  Copyright (c) 2021 only-icesoul. All rights reserved.
//

import UIKit
import jjutils
private enum Constants {
       static let blurRadiusKey = "blurRadius"
       static let colorTintKey = "colorTint"
       static let colorTintAlphaKey = "colorTintAlpha"
   }

class ViewController: UIViewController {
    
    var mView = DrawableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        view.addSubview(mView)
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        mView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        mView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
       

        
//        let b = VisualEffectView(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
//        b.blurRadius = 5
//       let v = b.subviews.first { type(of: $0) == NSClassFromString("_UIVisualEffectSubview") }
//        print("layer ",v?.layer)
//        print("bg filters",v?.layer.backgroundFilters)
//        print("bg",v?.layer.backgroundColor)
//        mView.addSubview(b)
//      
        
    }
    
    


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
     
    }

   
    @objc func fireTimer(){
        print("timer fired")
      
        
    }


}

