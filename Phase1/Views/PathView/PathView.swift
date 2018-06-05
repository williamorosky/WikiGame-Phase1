//
//  PathView.swift
//  Phase1
//
//  Created by William O'Rosky on 5/31/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import UIKit

@IBDesignable
class PathView: UIView {
    
    var titles:[String] = [] {
        didSet { layoutSubviews() }
    }
    
    private var steps:[StepView] = []
    private var isExpanded:Bool = false
    private weak var heightConstraint: NSLayoutConstraint?
    
    @IBInspectable open var startStepColor: UIColor = UIColor.blue {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable open var endStepColor: UIColor = UIColor.green {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable open var moreStepColor: UIColor = UIColor.purple {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = 3.0 {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable open var stepSpacing: CGFloat = 30.0 {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable open var stepXPadding: CGFloat = 20.0 {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable open var stepYPadding: CGFloat = 10.0 {
        didSet { setNeedsDisplay() }
    }
    
    
    // Initialize
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentMode = .redraw
        associateConstraints()
    }
    
    private func associateConstraints() {
        for constraint in constraints {
            if (constraint.firstAttribute == .height) {
                if (constraint.relation == .equal) {
                    heightConstraint = constraint
                }
            }
        }
    }
    
    // Calculate and adjust textview's height
    private var oldText: String = ""
    private var oldSize: CGSize = .zero
    
    private func forceLayoutSubviews() {
        oldSize = .zero
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if isExpanded {
            drawSteps()
        } else {
            drawEndpoints()
        }
        oldSize = bounds.size
        
        let size = sizeThatFits(CGSize(width: bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
        var height = size.height
        
        if steps.count > 0 {
            height = steps[steps.count-1].frame.maxY
        }
        
        // Add height constraint if it is not found
        if (heightConstraint == nil) {
            heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: height)
            addConstraint(heightConstraint!)
        }
        
        heightConstraint!.constant = height
    }
    
    func drawSteps() {
        self.removeAllSubviews()
        steps = []
        let stepFont = UIFont(name: "Roboto-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20)
        
        for (index,title) in titles.enumerated() {
            if index == 0 {
                let stepFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
                let step = StepView(title: title, backgroundColor: startStepColor, titleColor: .white, titleFont: stepFont, cornerRadius: cornerRadius, xPadding: stepXPadding, yPadding:stepYPadding, frame: stepFrame)
                self.addSubview(step)
                steps.append(step)
            } else {
                let previousStep = steps[index-1]
                let stepFrame = CGRect(x: 0, y: previousStep.frame.maxY+stepSpacing, width: self.frame.width, height: 40)
                let color = index == (titles.count-1) ? endStepColor : moreStepColor
                let step = StepView(title: title, backgroundColor: color, titleColor: .white, titleFont: stepFont, cornerRadius: cornerRadius, xPadding: stepXPadding, yPadding:stepYPadding, frame: stepFrame)
                drawLine(startY: previousStep.frame.maxY, endY: step.frame.minY, thiccness: 6, color: moreStepColor)
                self.addSubview(step)
                steps.append(step)
            }
        }
    }
    
    func drawEndpoints() {
        self.removeAllSubviews()
        steps = []
        let stepFont = UIFont(name: "Roboto-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20)

        if titles.count > 2 {
            let startFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
            let startStep = StepView(title: titles[0], backgroundColor: startStepColor, titleColor: .white, titleFont: stepFont, cornerRadius: cornerRadius, xPadding: stepXPadding, yPadding:stepYPadding, frame: startFrame)
            self.addSubview(startStep)
            steps.append(startStep)

            let moreFrame = CGRect(x: 0, y: startStep.frame.maxY+stepSpacing, width: self.frame.width, height: 6)
            let moreStep = StepView(image: "ellipsis-h", backgroundColor: moreStepColor, xPadding: 15, yPadding: 15, frame: moreFrame)
            drawLine(startY: startStep.frame.maxY, endY: moreStep.frame.minY, thiccness: 6, color: moreStepColor)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.expand(_:)))
            moreStep.addGestureRecognizer(tap)
            moreStep.isUserInteractionEnabled = true
            self.addSubview(moreStep)
            steps.append(moreStep)

            let endFrame = CGRect(x: 0, y: moreStep.frame.maxY+stepSpacing, width: self.frame.width, height: 40)
            let title = titles[titles.count-1]
            let endStep = StepView(title: title, backgroundColor: endStepColor, titleColor: .white, titleFont: stepFont, cornerRadius: cornerRadius, xPadding: stepXPadding, yPadding:stepYPadding, frame: endFrame)
            drawLine(startY: moreStep.frame.maxY, endY: endStep.frame.minY, thiccness: 6, color: moreStepColor)
            self.addSubview(endStep)
            steps.append(endStep)

        } else if titles.count == 2 {
            let startFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
            let startStep = StepView(title: titles[0], backgroundColor: startStepColor, titleColor: .white, titleFont: stepFont, cornerRadius: cornerRadius, xPadding: stepXPadding, yPadding:stepYPadding, frame: startFrame)
            self.addSubview(startStep)
            steps.append(startStep)

            let endFrame = CGRect(x: 0, y: startStep.frame.maxY+stepSpacing, width: self.frame.width, height: 40)
            let endStep = StepView(title: titles[titles.count-1], backgroundColor: endStepColor, titleColor: .white, titleFont: stepFont, cornerRadius: cornerRadius, xPadding: stepXPadding, yPadding:stepYPadding, frame: endFrame)
            drawLine(startY: startStep.frame.maxY, endY: endStep.frame.minY, thiccness: 6, color: moreStepColor)
            self.addSubview(endStep)
            steps.append(endStep)
        }
    }
    
    func drawLine(startY: CGFloat, endY: CGFloat, thiccness: CGFloat, color: UIColor) {
        let lineView = UIView(frame: CGRect(x: (self.frame.width/2) - (thiccness/2), y: startY, width: thiccness, height: endY-startY))
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    @objc func expand(_ sender: UITapGestureRecognizer) {
        isExpanded = true
        layoutSubviews()
    }
    
}
