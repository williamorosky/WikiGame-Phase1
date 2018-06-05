//
//  StepView.swift
//  Phase1
//
//  Created by William O'Rosky on 5/31/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit

class StepView: UIView {

    // Initialize
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    init(title: String, backgroundColor: UIColor, titleColor: UIColor, titleFont: UIFont, cornerRadius: CGFloat, xPadding: CGFloat, yPadding: CGFloat, frame: CGRect) {
        
        let titleFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width-xPadding, height: frame.height)
        let titleLabel = UILabel(frame: titleFrame)
        titleLabel.textAlignment = .center
        titleLabel.text = title
        titleLabel.font = titleFont
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textColor = titleColor
        titleLabel.sizeToFit()
        
        let newSize = CGSize(width: titleLabel.frame.width+xPadding, height: titleLabel.frame.height+yPadding)
        let newX = (frame.width-newSize.width)/2
        let newFrame = CGRect(x: newX, y: frame.origin.y, width: newSize.width, height: newSize.height)

        super.init(frame: newFrame)
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        
        titleLabel.frame = CGRect(x: xPadding/2, y: yPadding/2, width: titleLabel.frame.width, height: titleLabel.frame.height)
        self.addSubview(titleLabel)
    }
    
    init(image: String, backgroundColor: UIColor, xPadding: CGFloat, yPadding: CGFloat, frame: CGRect) {
        
        let ratio = CGFloat(70/21)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.height*ratio, height: frame.height))
        imageView.image = UIImage(named: image)
        
        let newSize = CGSize(width: imageView.frame.width+xPadding, height: imageView.frame.height+yPadding)
        let newX = (frame.width-newSize.width)/2
        let newFrame = CGRect(x: newX, y: frame.origin.y, width: newSize.width, height: newSize.height)
        
        super.init(frame: newFrame)
        
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = (imageView.frame.height+yPadding)/2
        
        imageView.frame = CGRect(x: xPadding/2, y: yPadding/2, width: imageView.frame.width, height: imageView.frame.height)
        self.addSubview(imageView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
