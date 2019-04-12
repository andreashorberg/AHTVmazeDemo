//
//  LoadingView.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import UIKit

class LoadingView {
    private static var shared: LoadingView = LoadingView()
    
    private var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.style = .whiteLarge
        return activity
    }()
    
    private init() {
        setup()
    }
    
    private func setup() {
        view.addSubview(activityIndicator)
        view.addConstraints([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        activityIndicator.startAnimating()
    }
    
    private static let window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = .alert + 1
        window.isHidden = true
        window.addSubview(shared.view)
        window.addConstraints([
            shared.view.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            shared.view.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            shared.view.topAnchor.constraint(equalTo: window.topAnchor),
            shared.view.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
        return window
    }()
    
    static func open() {
        DispatchQueue.main.async {
            window.makeKeyAndVisible()
        }
    }
    
    internal static func close() {
        DispatchQueue.main.async {
            window.isHidden = true
        }
    }
}
