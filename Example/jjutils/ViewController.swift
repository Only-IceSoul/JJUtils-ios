//
//  ViewController.swift
//  jjutils
//
//  Created by only-icesoul on 04/29/2021.
//  Copyright (c) 2021 only-icesoul. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var mView = DrawableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(mView)
        
        mView.translatesAutoresizingMaskIntoConstraints = false
        mView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        mView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        
        mView.backgroundColor = UIColor.white
        
    }

   

}

