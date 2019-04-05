//
//  ViewController.swift
//  LopeExample
//
//  Created by Olar's Mac on 4/5/19.
//  Copyright © 2019 Adie Olami. All rights reserved.
//

import UIKit
import Lope

class ViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        baseView.backgroundColor = .gray
        return baseView
    }()
    
    lazy var sliderImage: UIImageView = {
        let sliderImage = UIImageView()
        sliderImage.translatesAutoresizingMaskIntoConstraints = false
        sliderImage.backgroundColor = .blue
        sliderImage.layer.cornerRadius = 10
        sliderImage.clipsToBounds = true
        return sliderImage
    }()
    
    var lope: Lope!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        lope = Lope(frame: CGRect.zero)
        lope.delegate = self
        lope.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(lope)
        setup()
        
    }
    
    func setup() {
        
        NSLayoutConstraint.activate([
            //            lope.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            //            lope.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            
//            lope.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//
//            lope.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            lope.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            lope.heightAnchor.constraint(equalToConstant: 64),
            ])
    }
    
    
}

extension ViewController: LopeDelegate {
    func startSlide(_ start: Bool) {
        print("startSlide Lope")
    }

    func endSlide(_ end: Bool) {
        print("endSlide Lope")
    }

}




