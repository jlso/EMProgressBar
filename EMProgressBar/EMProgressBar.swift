//
//  EMProgressBar.swift
//  Example
//
//  Created by Jeonglim So on 2015. 11. 24..
//  Copyright © 2015년 estmob. All rights reserved.
//

import UIKit

public class EMProgressBar: UIView {

    private var _progress:Float = 0 {
        didSet {
            self.progressLayer.strokeEnd = CGFloat(_progress)
        }
    }
    
    private var _progressTintColor:UIColor = UIColor.whiteColor()
    
    public var contentInset:UIEdgeInsets = UIEdgeInsetsZero
    
    public var trackTintColor:UIColor {
        set {
            self.backgroundColor = newValue
        }
        get {
            return self.backgroundColor ?? UIColor.lightGrayColor()
        }
    }
    
    public var progressTintColor:UIColor  {
        set {
            _progressTintColor = newValue
            self.progressLayer.strokeColor = newValue.CGColor
        }
        get {
            return  _progressTintColor
        }
    }
    
    
    public var progress:Float {
        set {
            _progress = newValue
        }
        get {
            return _progress
        }
    }
    
    private lazy var progressLayer:CAShapeLayer = {
        let result =  CAShapeLayer()
        return result
    }()
    
    private lazy var maskLayer:CAShapeLayer = {
        let result = CAShapeLayer()
        let bounds = self.maskFrame()
        result.frame = bounds
        result.path = self.linePathWithBounds(bounds, capStyle: .Round).CGPath
        result.fillRule = kCAFillRuleNonZero;
        result.lineWidth = bounds.size.height
        result.strokeColor = UIColor.whiteColor().CGColor
        result.lineCap = kCALineCapRound
        result.strokeEnd = 1
        return result
    } ()
    
    public init() {
        super.init(frame:CGRectZero)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateLayerAttribute()
    }
    

    func updateLayerAttribute() {
        self.layer.cornerRadius = self.frame.height/2
        self.updateProgressLayerAttribute()
        self.updateMaskLayerAttribute()
    }
    
    func updateMaskLayerAttribute() {
        let maskBounds = self.maskFrame()
        self.maskLayer.frame = maskBounds
        self.maskLayer.lineWidth = maskBounds.height
        self.maskLayer.path = self.linePathWithBounds(maskBounds, capStyle: .Round).CGPath
    }
    
    
    func maskFrame() -> CGRect {
        var result = self.layer.bounds
        result.size.height -= self.contentInset.top + self.contentInset.bottom
        result.origin.x += (result.height/2)
        result.size.width -= self.contentInset.left + self.contentInset.right + result.height
        return  result
    }
    
    func updateProgressLayerAttribute() {
        let progressBounds = self.progressFrame()
        self.progressLayer.frame = progressBounds
        self.progressLayer.path = self.linePathWithBounds(progressBounds, capStyle: .Butt).CGPath
        self.progressLayer.lineWidth = progressBounds.height
        self.progressLayer.strokeColor = self.progressTintColor.CGColor
    }
    
    func progressFrame() -> CGRect {
        var result = self.bounds
        result.origin.y += self.contentInset.top
        result.size.height -= self.contentInset.top + self.contentInset.bottom
        result.origin.x += self.contentInset.left
        result.size.width -= self.contentInset.left + self.contentInset.right
        return result
    }
    
    func linePathWithBounds(bounds:CGRect, capStyle:CGLineCap) -> UIBezierPath {
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: 0, y: bounds.height/2))
        linePath.addLineToPoint(CGPoint(x: bounds.width, y: bounds.height/2))
        linePath.lineCapStyle = capStyle
        return linePath
    }
    
    private func commonInit() {
        self.layer.masksToBounds = true
        self.progressLayer.strokeEnd = 0
        self.layer.addSublayer(self.progressLayer)
        self.layer.addSublayer(self.maskLayer)
        self.progressLayer.mask = self.maskLayer
        updateLayerAttribute()

    }
}
