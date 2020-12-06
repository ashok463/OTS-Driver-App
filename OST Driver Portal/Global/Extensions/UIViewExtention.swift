//
//  UIViewExtention.swift
//  OTS Manager
//
//  Created by Ashok Kumar on 10/08/20.
//  Copyright © 2020 Ashok Kumar. All rights reserved.
//

import Foundation
import UIKit


extension UIView {

    func applyShadowWithCornerRadius(color:UIColor, opacity:Float, cornerRadius: CGFloat, radius: CGFloat, edge:AIEdge, shadowSpace:CGFloat)    {

        var sizeOffset:CGSize = CGSize.zero
        switch edge {
        case .Top:
            sizeOffset = CGSize(width: 0, height: -shadowSpace)
        case .Left:
            sizeOffset = CGSize(width: -shadowSpace, height: 0)
        case .Bottom:
            sizeOffset = CGSize(width: 0, height: shadowSpace)
        case .Right:
            sizeOffset = CGSize(width: shadowSpace, height: 0)


        case .Top_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: -shadowSpace)
        case .Top_Right:
            sizeOffset = CGSize(width: shadowSpace, height: -shadowSpace)
        case .Bottom_Left:
            sizeOffset = CGSize(width: -shadowSpace, height: shadowSpace)
        case .Bottom_Right:
            sizeOffset = CGSize(width: shadowSpace, height: shadowSpace)


        case .All:
            sizeOffset = CGSize(width: 0, height: 0)
        case .None:
            sizeOffset = CGSize.zero
        }

        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true

        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = sizeOffset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false

//        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
}

enum AIEdge:Int {
    case
    Top,
    Left,
    Bottom,
    Right,
    Top_Left,
    Top_Right,
    Bottom_Left,
    Bottom_Right,
    All,
    None
}


extension UIView{
    
    func cornerRadius(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addTopRoundedCornerToView(targetView:UIView?, desiredCurve:CGFloat?)
    {
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds
        
        //Top side curve
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y+bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)
        
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        
        //Top side curve
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        targetView!.layer.mask = maskLayer
    }
    
    func setTopCurve(){
        let offset = CGFloat(self.frame.size.height/4)
        let bounds = self.bounds
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y + bounds.size.height/2  , width:  bounds.size.width, height: bounds.size.height / 2)
        
        let rectPath = UIBezierPath(rect: rectBounds)
        
        let ovalBounds = CGRect(x: bounds.origin.x , y: bounds.origin.y - offset / 2, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func addBottomRoundedCornerToView(targetView:UIView?, desiredCurve:CGFloat?)
    {
        let offset:CGFloat =  targetView!.frame.width/desiredCurve!
        let bounds: CGRect = targetView!.bounds
        
        //Bottom side curve
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        
        //Bottom side curve
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        // Set the newly created shape layer as the mask for the view's layer
        targetView!.layer.mask = maskLayer
    }
    
    func setBottomCurve(){
        let offset = CGFloat(self.frame.size.height/1)
        let bounds = self.bounds
        
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y  , width:  bounds.size.width, height: bounds.size.height / 2)
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
    

        func dropShadow(scale: Bool = true) {
            layer.masksToBounds = true
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOpacity = 0.8
            layer.shadowOffset = CGSize(width: 0, height: 5)
            layer.shadowRadius = 2
            layer.borderWidth = 1
            layer.shouldRasterize = true
            layer.rasterizationScale = scale ? UIScreen.main.scale : 1
            layer.borderColor =  UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
       }

        func addBottomRoundedEdge() {
            let offset: CGFloat = (self.frame.width * 1.5)
            let bounds: CGRect = self.bounds

            let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width , height: bounds.size.height / 2)
            let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
            let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset , height: bounds.size.height)
            let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
            rectPath.append(ovalPath)

            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = rectPath.cgPath

            self.layer.mask = maskLayer
        }
    
    func applyGradient(){
            let gradient: CAGradientLayer = CAGradientLayer()
            
            gradient.colors = [UIColor.init(red: 0.5144, green: 0.1524, blue: 0.5675, alpha: 1.0000).cgColor, UIColor.init(red: 0.7608, green: 0.2980, blue: 0.8235, alpha: 1.0000).cgColor]
            gradient.locations = [0, 0.8, 1]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
            
            self.layer.insertSublayer(gradient, at: 0)
        }
        
        func setViewBackgroundImg(){
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "bg_ic")
            backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
            self.insertSubview(backgroundImage, at: 0)
        }
        
        func roundTop(radius:CGFloat = 40){
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            if #available(iOS 11.0, *) {
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else {
                //self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            }
        }
        
        func view_cornerRadius(cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat){
            self.layer.cornerRadius = cornerRadius
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
            self.layer.masksToBounds = true
        }
        
        func viewShadowwithRaduis(title: String) -> UIButton {
            
            self.backgroundColor = UIColor.clear
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 4.0
            
            let borderView = UIButton()
            borderView.frame = self.bounds
            borderView.layer.cornerRadius = borderView.frame.size.height/2
            borderView.layer.masksToBounds = true
            borderView.backgroundColor = UIColor.clear
            borderView.titleLabel?.font =  UIFont(name: "Raleway-Bold", size: 18)
            borderView.setTitle(title, for: .normal)
            borderView.applyGradient()
            self.addSubview(borderView)
            
            return borderView
        }
        
        func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                       shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                       shadowOpacity: Float = 0.5,
                       shadowRadius: CGFloat = 3.0) {
            layer.shadowColor = shadowColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
}


class BottomCurveView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        let rect = bounds
        let y = rect.size.height - 50.0
        let curveTo = rect.size.height

        let myBez = UIBezierPath()
        myBez.move(to: CGPoint(x: 0.0, y: y))
        myBez.addQuadCurve(to: CGPoint(x: rect.size.width, y: y), controlPoint: CGPoint(x: rect.size.width / 2.0, y: curveTo))
        myBez.addLine(to: CGPoint(x: rect.size.width, y: 0.0))
        myBez.addLine(to: CGPoint(x: 0.0, y: 0.0))
        myBez.close()

        let maskForPath = CAShapeLayer()
        maskForPath.path = myBez.cgPath
        self.layer.mask = maskForPath
    }
}


protocol ReadMoreLessViewDelegate: class {
    func didChangeState(_ readMoreLessView: ReadMoreLessView, buttonTittle: String)
}

@IBDesignable class ReadMoreLessView : UIView {
    
    @IBInspectable var maxNumberOfLinesCollapsed: Int = 5
    fileprivate var kvoContext = 0
    
    @IBInspectable var titleColor: UIColor = .black {
        didSet{
            titleLabel.textColor = titleColor
        }
    }
    
    @IBInspectable var bodyColor: UIColor = .darkGray {
        didSet{
            bodyLabel.textColor = bodyColor
        }
    }
    
    @IBInspectable var buttonColor: UIColor = .orange {
        didSet{
            moreLessButton.setTitleColor(buttonColor, for: UIControl.State())
        }
    }
    
//    @IBInspectable var cornerRadius: CGFloat = 0.0 {
//        didSet{
//             layer.cornerRadius = cornerRadius
//        }
//    }
    
    @IBInspectable var titleLabelFont: UIFont = .systemFont(ofSize: 15) {
        didSet{
            titleLabel.font = titleLabelFont
        }
    }
    
    @IBInspectable var bodyLabelFont: UIFont = .systemFont(ofSize: 14) {
        didSet{
            bodyLabel.font = bodyLabelFont
        }
    }
    
    @IBInspectable var moreLessButtonFont: UIFont = .systemFont(ofSize: 12) {
        didSet{
            moreLessButton.titleLabel!.font = moreLessButtonFont as UIFont
        }
    }
    
    var moreText = NSLocalizedString("SHOW MORE", comment: "Show More")
    var lessText = NSLocalizedString("SHOW LESS", comment: "Show Less")

    fileprivate enum ReadMoreLessViewState {
        case collapsed
        case expanded
        
        mutating func toggle() {
            switch self {
            case .collapsed:
                self = .expanded
            case .expanded:
                self = .collapsed
            }
        }
    }
    
    weak var delegate: ReadMoreLessViewDelegate?
    
    fileprivate var state: ReadMoreLessViewState = .collapsed {
        didSet {
            switch state {
            case .collapsed:
                bodyLabel.lineBreakMode = .byTruncatingTail
                bodyLabel.numberOfLines = maxNumberOfLinesCollapsed
                moreLessButton.setTitle(moreText, for: UIControl.State())
            case .expanded:
                bodyLabel.lineBreakMode = .byWordWrapping
                bodyLabel.numberOfLines = 0
                moreLessButton.setTitle(lessText, for: UIControl.State())
            }
            
            invalidateIntrinsicContentSize()
            delegate?.didChangeState(self, buttonTittle: moreLessButton?.currentTitle ?? "")
        }
    }
    
    @objc func buttonTouched(_ sender: UIButton) {
        state.toggle()
    }
    
    lazy fileprivate var moreLessButton: UIButton! = {
        let button = UIButton(frame: CGRect.zero)
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ReadMoreLessView.buttonTouched(_:)), for: .touchUpInside)
        button.setTitleColor(.orange, for: UIControl.State())
        return button
    }()
    
    lazy fileprivate var titleLabel: UILabel! = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        
        return label
    }()
    
    lazy fileprivate var bodyLabel: UILabel! = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    
    // MARK: Initialisers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }
    
    
    fileprivate func initComponents() {
        titleLabel.font = titleLabelFont
        titleLabel.textColor = titleColor
        
        bodyLabel.font = bodyLabelFont
        bodyLabel.textColor = bodyColor
        
        moreLessButton.titleLabel!.font = moreLessButtonFont
        moreLessButton.setTitleColor(buttonColor, for: UIControl.State())
        bodyLabel.layer.addObserver(self, forKeyPath: "bounds", options: [], context: &kvoContext)
    }
    
    // MARK: Private
    
    fileprivate func configureViews() {
        state = .collapsed
        
        addSubview(titleLabel)
        addSubview(bodyLabel)
        addSubview(moreLessButton)
        
        let views = ["titleLabel": titleLabel ?? "", "bodyLabel": bodyLabel ?? "", "moreLessButton": moreLessButton ?? ""] as [String : Any]
        let horizontalConstraintsTitle = NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[titleLabel]-6-|", options: .alignAllLastBaseline, metrics: nil, views: views)
        let horizontalConstraintsBody = NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[bodyLabel]-6-|", options: .alignAllLastBaseline, metrics: nil, views: views)
        let horizontalConstraintsButton = NSLayoutConstraint.constraints(withVisualFormat: "H:|-6-[moreLessButton]-6-|", options: .alignAllLastBaseline, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-6-[titleLabel]-4-[bodyLabel]-4-[moreLessButton]-4-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        NSLayoutConstraint.activate(horizontalConstraintsTitle + horizontalConstraintsBody + horizontalConstraintsButton + verticalConstraints )
        
        initComponents()
    }
    
    func setText(_ title: String, body: String) {
        guard let titleLabel = titleLabel, let bodyLabel = bodyLabel else { return }
        titleLabel.text = title
        bodyLabel.text = body
        
        if body.isEmpty {
            titleLabel.text = nil
            moreLessButton.isHidden = true
            moreLessButton.isEnabled = false
        } else {
            moreLessButton.isHidden = false
            moreLessButton.isEnabled = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &kvoContext {
            if let bodyLabel = bodyLabel, let text = bodyLabel.text, !text.isEmpty {
                if countLabelLines(label: bodyLabel) <= maxNumberOfLinesCollapsed {
                    moreLessButton.isHidden = true
                }
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    fileprivate func countLabelLines(label: UILabel) -> Int {
        layoutIfNeeded()
        let myText = label.text! as NSString
        let attributes = [NSAttributedString.Key.font : label.font as UIFont]
        let labelSize = myText.boundingRect(with: CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
    }
    
    deinit {
        bodyLabel.layer.removeObserver(self, forKeyPath: "bounds", context: &kvoContext)
    }
    
    // MARK: Interface Builder
    
    override func prepareForInterfaceBuilder() {
        self.layoutSubviews()
        let titleText = "Text for Title label"
        let bodytext = "Lorem ipsum dolor sit amet, eam eu veri corpora, eu sit zril eirmod integre, his purto quaestio ut."
        setText(titleText, body: bodytext)
    }

}
