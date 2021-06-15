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
    var view2 = UIView()
    let other = "M18.258,3.266c-0.693,0.405-1.46,0.698-2.277,0.857c-0.653-0.686-1.586-1.115-2.618-1.115c-1.98,0-3.586,1.581-3.586,3.53c0,0.276,0.031,0.545,0.092,0.805C6.888,7.195,4.245,5.79,2.476,3.654C2.167,4.176,1.99,4.781,1.99,5.429c0,1.224,0.633,2.305,1.596,2.938C2.999,8.349,2.445,8.19,1.961,7.925C1.96,7.94,1.96,7.954,1.96,7.97c0,1.71,1.237,3.138,2.877,3.462c-0.301,0.08-0.617,0.123-0.945,0.123c-0.23,0-0.456-0.021-0.674-0.062c0.456,1.402,1.781,2.422,3.35,2.451c-1.228,0.947-2.773,1.512-4.454,1.512c-0.291,0-0.575-0.016-0.855-0.049c1.588,1,3.473,1.586,5.498,1.586c6.598,0,10.205-5.379,10.205-10.045c0-0.153-0.003-0.305-0.01-0.456c0.7-0.499,1.308-1.12,1.789-1.827c-0.644,0.28-1.334,0.469-2.06,0.555C17.422,4.782,17.99,4.091,18.258,3.266"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
//        view.addSubview(view2)
//        view2.backgroundColor = UIColor.green
//        view2.translatesAutoresizingMaskIntoConstraints = false
//        view2.widthAnchor.constraint(equalToConstant: 240).isActive = true
//        view2.heightAnchor.constraint(equalToConstant: 240).isActive = true
//        view2.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        view2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
//        

       
        view.addSubview(mView)
      
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        mView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        mView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        
//        let mDisplay = CADisplayLink(target: self, selector: #selector(self.displayAnimation(_:)))
//        mDisplay.add(to: .main, forMode: .defaultRunLoopMode)

        
//        let b = VisualEffectView(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
//        b.blurRadius = 5
//        var v = b.subviews.first { type(of: $0) == NSClassFromString("_UIVisualEffectBackdropView") }
//        print("layer ",v?.layer)
//        print("bg filters",v?.layer.backgroundFilters)
//        print("bg",v?.layer.backgroundColor)
//        if v != nil { mView.addSubview(v!) }
//    
//      
        
    }
    
    var percent:CGFloat = 0
    var mFirst = false
    @objc func displayAnimation(_ link:CADisplayLink){
//        if !mFirst{
//            mFirst = true
//          let framerate =   Int(round(1.0 / Double(link.duration)))
//            print(framerate)
//        }
//
        if !mFirst{
            percent += 0.003333333
            if percent > 1{
//                mFirst = true
                percent = 0
            }
            mView.setStrokeEnd(percent)
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
    }
   
  


}

