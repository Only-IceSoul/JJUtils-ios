//
//  JJRegisterCompletedView.swift
//  RegistroCompletado
//
//  Created by Juan J LF on 13/4/19.
//  Copyright © 2019 Juan J LF. All rights reserved.
//

import UIKit


class JJRegistrationCompletedView : UIView {
    
    let containerView = UIView()
    let tickCorrectLayer = CAShapeLayer()
    let tickCorrectLayerBg = CAShapeLayer()
    
    let textLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("called normal init")
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        setupContainerView()
        setupTrickCorrectLayerBg()
        setupTrickCorrectLayer(color: nil)
         setupLabel(text: nil, font: nil)
    }
    
    convenience init(frame: CGRect, pathColor: UIColor?, text: String?, font: UIFont?){
        self.init(frame: frame)
        print("called conv init")
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        setupContainerView()
        setupTrickCorrectLayerBg()
        setupTrickCorrectLayer(color: pathColor)
        setupLabel(text: text, font: font)
   
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupContainerView(){
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: -5, height: 5)
        containerView.layer.shadowOpacity = 0.1
        
        self.addSubview(containerView)
        
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
         containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupLabel(text: String?, font: UIFont?){
        
        textLabel.text = text ?? "Registro Completado"
        textLabel.textAlignment = .center
        textLabel.textColor = .lightGray
        textLabel.font = font ?? UIFont.systemFont(ofSize: 12)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(textLabel)
        
        textLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -5).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        textLabel.widthAnchor.constraint(equalTo: self.containerView.widthAnchor).isActive = true
    }
    
    func setupTrickCorrectLayerBg(){
        
        
        let path = CGMutablePath()
    
        path.move(to: CGPoint(x: 78, y: 50))
        path.addLine(to: CGPoint(x: 85, y: 58))
        path.addLine(to: CGPoint(x: 100, y: 43))
        
        tickCorrectLayerBg.path = path
        tickCorrectLayerBg.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        tickCorrectLayerBg.fillColor = UIColor.clear.cgColor
        tickCorrectLayerBg.lineWidth = 3
        tickCorrectLayerBg.lineCap = .round
    
        
        self.containerView.layer.addSublayer(tickCorrectLayerBg)
    }
    
    func setupTrickCorrectLayer(color: UIColor?){
        
        
        let path = UIBezierPath(arcCenter: CGPoint(x: 90, y: 50), radius: 20, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        
        path.move(to: CGPoint(x: 78, y: 50))
        path.addLine(to: CGPoint(x: 85, y: 58))
        
        path.addLine(to: CGPoint(x: 100, y: 43))
        
        tickCorrectLayer.path = path.cgPath
        print("setupcolor")
        tickCorrectLayer.strokeColor = color?.cgColor ?? UIColor.red.cgColor
        tickCorrectLayer.fillColor = UIColor.clear.cgColor
        tickCorrectLayer.lineWidth = 3
        tickCorrectLayer.lineCap = .round
        
        tickCorrectLayer.strokeEnd = 0.79
        
        self.containerView.layer.addSublayer(tickCorrectLayer)
    }
    
    func startAnimation(completion: @escaping () -> ()){
        
        let strokeAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        
        strokeAnimation.fromValue = 0.79
        strokeAnimation.toValue = 1
        strokeAnimation.fillMode = .forwards
        strokeAnimation.isRemovedOnCompletion = false
        strokeAnimation.beginTime = CACurrentMediaTime() + 0.1
        strokeAnimation.duration = 0.18
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            completion()
        }
        
        self.tickCorrectLayer.add(strokeAnimation, forKey: nil)
        
        CATransaction.commit()
        
    }
    
}
