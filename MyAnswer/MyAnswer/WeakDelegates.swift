//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 06/07/2023.
//

import UIKit

class WeakType<T: AnyObject> {
    weak var value: T?
    
    init(_ value: T) {
        self.value = value
    }
}

class User {
    let name: String
    
    var friends: [WeakType<User>] = []
    
    init(name: String) {
        self.name = name
        print("Initialized user")
    }
    
    deinit {
        print("Deallocating user")
    }
    
    lazy var unownedGreeting: () -> String = { [unowned self] in
        return "Hi, \(name)"
    }
    
    lazy var weakGreeting: () -> String = { [weak self] in
        return "Hi, \(self?.name)"
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    weak var user: User?
    
    var greetingMaker: (() -> String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let greetingMaker: () -> String
        
        do {
            let user = User(name: "Son")
            greetingMaker = user.weakGreeting
        }
        
        print(greetingMaker?())

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.user = nil
        }
        
        var sonle = User(name: "Son")
        var duong = User(name: "Duong")
        sonle.friends.append(WeakType(duong))
        duong.friends.append(WeakType(sonle))
        print("Hi There")
    }
}
