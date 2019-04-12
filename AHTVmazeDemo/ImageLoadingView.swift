//
//  ImageLoadingView.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-12.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class LoadingView: UIView, CAAnimationDelegate {
    
    let gradientLayer = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient = 0
    
    let greenish = UIColor(red: CGFloat.random(in: 0.0...0.2), green: CGFloat.random(in: 0.8...1.0), blue: CGFloat.random(in: 0.5...0.8), alpha: 1.0).cgColor
    let blueish = UIColor(red: CGFloat.random(in: 0.05...0.1), green: CGFloat.random(in: 0.4...0.6), blue: CGFloat.random(in: 0.8...1.0), alpha: 1.0).cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createGradientView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createGradientView()
    }
    
    func createGradientView() {
        translatesAutoresizingMaskIntoConstraints = false
        gradientSet.append([greenish, blueish])
        gradientSet.append([blueish, greenish])
        
        gradientLayer.frame = bounds
        gradientLayer.colors = gradientSet[currentGradient]
        
        gradientLayer.startPoint = CGPoint(x: CGFloat.random(in: 0.0...0.25), y: CGFloat.random(in: 0.0...0.25))
        gradientLayer.endPoint = CGPoint(x: CGFloat.random(in: 0.75...1.0), y: CGFloat.random(in: 0.75...1.0))
        gradientLayer.drawsAsynchronously = true
        
        layer.insertSublayer(gradientLayer, at: 0)
        
        animateGradient()
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 3.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradientChangeAnimation.delegate = self
        gradientLayer.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
    }
    
    func animationDidStop(_ animation: CAAnimation, finished flag: Bool) {
        if flag {
            gradientLayer.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}

