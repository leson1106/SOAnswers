//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

//https://stackoverflow.com/questions/77285208/how-to-turn-off-device-rotation-programmatically-ios
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Hello"
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)
        
        label.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        label.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        label.center = view.center
        label.backgroundColor = .yellow
    }
}
