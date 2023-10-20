//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

class ParentClass {
    deinit {
        print("DEINIT PARENT")
    }
    
    lazy var child: ChildClass = ChildClass()
    
    init() { }
}

class ChildClass {
    deinit {
        print("DEINIT CHILD")
    }
    
    lazy var parent: ParentClass = ParentClass()
    
    init() { }
}

class ViewController: UIViewController {
    
    private let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(nameLabel)
        
        view.backgroundColor = .blue
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentVC)))
    }
    
    @objc private func presentVC() {
        let vc = ViewController2()
        vc.completion = { text in
            self.nameLabel.text = text
            print("Completion get called")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

class ViewController2: UIViewController {
    
    var parentC = ParentClass()
    var child = ChildClass()
    
    var completion: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        parentC.child = child
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        completion?("Did Appear")
    }
}
