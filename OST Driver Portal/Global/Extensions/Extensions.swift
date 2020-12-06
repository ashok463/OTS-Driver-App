//
//  UIView+Extension.swift
//  Zon Bau
//
//  Created by Gulfam Khan on 04/09/2019.
//  Copyright © 2019 AcclivousByte. All rights reserved.
//

import UIKit

extension UIView {
    
    func changeRTL() {
        if UserDefaultsManager.shared.currentLocale == "en" {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }else {
            self.flipImages()
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
    }
    
    func flipImages() {
        for subview in self.subviews {
            if subview.isKind(of: UIImageView.self) {
                let imageView = subview as! UIImageView
                imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            
            if subview.isKind(of: UIButton.self) {
                let button = subview as! UIButton
                if let imageView = button.imageView {
                    imageView.transform = CGAffineTransform(scaleX: -1, y: 1)
                }
            }
            
            if subview.subviews.count > 0 {
                subview.flipImages()
            }
        }
    }
    
    func setBorderLayer(width: CGFloat, color: UIColor, cornerRadius:CGFloat? = nil) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        
        if let radius = cornerRadius {
            self.layer.cornerRadius = radius
        }else {
            self.layer.cornerRadius = self.bounds.size.width / 2
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func rotate(withRadian radian: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(rotationAngle: radian)
        })
    }
    
    func rotate(withAngle angle: CGFloat) {
        let radian = angle * .pi / 180
        rotate(withRadian: radian)
    }
    
    func setupImageGradient(colors: [CGColor], start: CGPoint? = nil, end: CGPoint? = nil, position:UInt32? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = bounds
        if let start = start, let end = end {
            gradientLayer.startPoint = start
            gradientLayer.endPoint = end
        }else {
            gradientLayer.locations = [0, 1]
        }
        
        if let position = position {
            layer.insertSublayer(gradientLayer, at: position)
        }else {
            layer.addSublayer(gradientLayer)
        }
    }
    
//    func dropShadow(scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: -1, height: 1)
//        layer.shadowRadius = 1
//        
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize = CGSize(width: -1, height: 1), radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    func switchVisibility(_ duration:Double = 0.5) {
        if self.isHidden {
            self.isHidden = false
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1
            }, completion: nil)
        }else {
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
            }) { (finished) in
                self.isHidden = finished
            }
        }
    }
}

extension UIImage {
    private func rotateImage(withRadian radian: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size).applying(.init(rotationAngle: radian)).integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radian)
            draw(in: .init(x: -origin.x, y: -origin.y, width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            return rotatedImage ?? self
        }
        return self
    }
    
    func rotateImage(withAngle angle: CGFloat) -> UIImage {
        let radian = angle * .pi / 180
        return self.rotateImage(withRadian: radian)
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }}

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [.font:font])
    }
    
    func boldString(fontSize : CGFloat ,font : UIFont?) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: 8)]
        return NSMutableAttributedString(string:self, attributes:attrs)
    }
    
    func strstr(needle: String, beforeNeedle: Bool = false) -> String? {
        guard let range = self.range(of: needle) else { return nil }
        
        if beforeNeedle {
            return self.substring(to: range.lowerBound)
        }
        
        return self.substring(from: range.upperBound)
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    class func initializeFromNib(_ name: String? = nil) -> Self {
        return initializeFromNib(name, type: self)
    }
    
    class func initializeFromNib<T: UIView>(_ name: String? = nil, type: T.Type) -> T {
        return initializeFromNib(name, type: type)!
    }
    
    class func initializeFromNib<T: UIView>(_ name: String? = nil, type: T.Type) -> T? {
        var nibName = ""
        if let name = name {
            nibName = name
        }else {
            nibName = String(describing: type)
        }
        
        let nibViews = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
        
        for view in nibViews ?? [] {
            if let matchView = view as? T {
                return matchView
            }
        }
        
        return nil
    }
}


extension UITextField {
    @IBInspectable var textInsets: CGPoint {
        get {
            return CGPoint.zero
        }
        set {
            layer.sublayerTransform = CATransform3DMakeTranslation(newValue.x, newValue.y, 0);
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        if UserDefaultsManager.shared.currentLocale == "ar" {
            if textAlignment == .natural {
                self.textAlignment = .right
            }
        }
    }
}

extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIColor {
    convenience init(rgbValues red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    convenience init(hexFromString value: String, alpha: CGFloat = 1) {
        var hexValue = value.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }
        
        if hexValue.hasPrefix("0x".uppercased()) {
            hexValue.removeSubrange(hexValue.range(of: "0x".uppercased())!)
        }
        
        if hexValue.count != 6 {
            self.init(white: 0.5, alpha: 0.8)
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: hexValue).scanHexInt32(&rgbValue)
        
        self.init(hexFromInt: rgbValue, alpha: alpha)
    }
    
    convenience init(hexFromInt value: UInt32, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255,
            green: CGFloat((value & 0x00FF00) >> 8) / 255,
            blue: CGFloat(value & 0x0000FF) / 255,
            alpha: alpha)
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
