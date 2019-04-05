//
//  Lope.swift
//  Lope
//
//  Created by Olar's Mac on 4/5/19.
//  Copyright © 2019 Adie Olami. All rights reserved.
//

import UIKit


@objc public class Lope: UIView {
    
    open var sliderBackgroundColor: UIColor? = .black
    
    open var baseViewBackgroundColor: UIColor? = .gray
    
    open var titleTextColor: UIColor? = .black
    
    open lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.translatesAutoresizingMaskIntoConstraints = false
        return baseView
    }()
    
    open lazy var sliderImage: UIImageView = {
        let sliderImage = UIImageView()
        sliderImage.translatesAutoresizingMaskIntoConstraints = false
        sliderImage.layer.cornerRadius = 10
        sliderImage.isUserInteractionEnabled = true
        sliderImage.clipsToBounds = true
        return sliderImage
    }()
    
    open lazy var title: UILabel = {
        let title = UILabel()
        title.text = "Slide Me"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private var startingFrame: CGRect?
    weak var delegate: LopeDelegate?
    
    let screenSize = UIScreen.main.bounds
    override init(frame: CGRect) {
        super.init(frame: frame)
        sliderImage.backgroundColor = sliderBackgroundColor
        baseView.backgroundColor = baseViewBackgroundColor
        title.textColor = titleTextColor


        self.addSubview(baseView)
        baseView.addSubview(sliderImage)
        constraints()
        swipeFunc()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func constraints() {
        
        NSLayoutConstraint.activate([
            baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            sliderImage.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: 0),
            sliderImage.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 4),
            sliderImage.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8),
            sliderImage.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -8),
            sliderImage.aspectRation(1.0/1.0),
            
            
            title.centerXAnchor.constraint(equalTo: baseView.centerXAnchor, constant: 0),
            title.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: 0),
            ])
        
    }
    
    private func swipeFunc() {
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(acknowledgeSwiped(sender:)))
        sliderImage.addGestureRecognizer(swipeGesture)
        swipeGesture.delegate = self as? UIGestureRecognizerDelegate
    }
    
    @objc func acknowledgeSwiped(sender: UIPanGestureRecognizer) {
        if let sliderView = sender.view {
            let translation = sender.translation(in: self.baseView)
            switch sender.state {
            case .began:
                startingFrame = sliderImage.frame
                fallthrough
            case .changed:
                if let startFrame = startingFrame  {
                    
                    var movex = translation.x
                    
                    if movex < -startFrame.origin.x {
                        movex = -startFrame.origin.x
                    }
                    
                    let xMax = self.baseView.frame.width - startFrame.origin.x - startFrame.width
                    if movex > xMax {
                        movex = xMax
                    }
                    
                    sliderView.transform = CGAffineTransform(translationX: movex, y: 0)
                }
                
            default:
                UIView.animate(withDuration: 0.1, animations: {
                    if (Double(self.sliderImage.frame.origin.x) > 0) {
                        self.delegate?.endSlide(true)
                    }
                    sliderView.transform = CGAffineTransform.identity
                    
                })
            }
        }
    }
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return sliderImage.frame.contains(point)
    }
}

extension UIView {
    func aspectRation(_ ratio: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: ratio, constant: 0)
    }
}
