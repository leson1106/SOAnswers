//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

//https://stackoverflow.com/questions/77556252/is-there-an-option-to-apply-single-strikethrough-line-for-nsmutableattributedstr
extension UIView {
    func addCenterStrikeThrough(color: UIColor, width: CGFloat = 0.5) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: frame.size.height / 2))
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height / 2))
        
        let layer = CAShapeLayer()
        layer.strokeColor = color.cgColor
        layer.lineWidth = width
        layer.path = path.cgPath
        
        self.layer.addSublayer(layer)
    }
}

class ViewController: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(label)
        label.center = view.center
        
        let currency = "P".painted(color: UIColor.black, font: UIFont.systemFont(ofSize: 17))
        let price = "1985".painted(color: UIColor.red, font: UIFont.systemFont(ofSize: 17))
        let subPrice = ".35".painted(color: UIColor.black, font: UIFont.systemFont(ofSize: 13))
        let result = NSMutableAttributedString()
        result.append(currency)
        result.append(price)
        result.append(subPrice)
        label.attributedText = result
        label.sizeToFit()
        
        label.addCenterStrikeThrough(color: .gray)
    }
}

extension String {
    func painted(
        color: UIColor,
        font: UIFont,
        underline: Bool = false,
        lineSpacing : CGFloat? = nil,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        strikethroughStyle: Bool = false
    ) -> NSMutableAttributedString {
        var atb = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.underlineStyle: underline, NSAttributedString.Key.strikethroughStyle: strikethroughStyle] as [NSAttributedString.Key : Any]
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        paragraphStyle.lineBreakMode = lineBreakMode
        
        atb[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        
        return NSMutableAttributedString(string:self, attributes:atb)
    }
}
