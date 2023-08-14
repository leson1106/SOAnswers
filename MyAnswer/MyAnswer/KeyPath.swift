//
//  ViewController2.swift
//  MyAnswer
//
//  Created by Son Le on 17/07/2023.
//

import UIKit

struct Person {
    let name: String
    let age: Int
}

class ViewController2: UIViewController {
    
    private let service = Service()
    
    private var persons: [Person] = [] {
        didSet {
            printInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.fetch { [weak self] persons in
            self?.persons = persons
        }
        
        service.fetch(completion: setter(for: self, keyPath: \.persons))
    }
    
    private func printInfo() {
        persons.forEach { print($0.name) }
    }
}

class Service {
    func fetch(completion: ((_ persons: [Person]) -> Void)) {
        completion([
            .init(name: "Son", age: 30),
            .init(name: "Duong", age: 30)
        ])
    }
}

func setter<Object: AnyObject, Value>(for object: Object,
                                      keyPath: ReferenceWritableKeyPath<Object, Value>)
-> (Value) -> Void
{
    return { [weak object] value in
        object?[keyPath: keyPath] = value
    }
}
