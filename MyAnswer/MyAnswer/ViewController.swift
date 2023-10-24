//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

class Person: Codable {
    private(set) var name: String
    private(set) var isSelected: Bool = false
    
    init(_ name: String) {
        self.name = name
    }
    
    func set(isSelected: Bool) {
        self.isSelected = isSelected
    }
}

class PersonButton: UIButton {
    private(set) var data: Person!
    
    override var isSelected: Bool {
        didSet {
            data.set(isSelected: isSelected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func set(data: Person) {
        self.data = data
    }
}

class ViewController: UIViewController {
    
    private let deboucer = Debouncer()
    
    var group: [[Person]] = []
    
    private let verticalHorizontal = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        read()
        
        view.backgroundColor = .white
        view.addSubview(verticalHorizontal)
        verticalHorizontal.distribution = .fillEqually
        verticalHorizontal.axis = .vertical
        verticalHorizontal.frame = view.bounds
        verticalHorizontal.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        group.forEach {
            let stackHorizontal = addHorizontalStack()
            $0.forEach { person in
                let button = createButton(with: person)
                button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
                stackHorizontal.addArrangedSubview(button)
            }
            verticalHorizontal.addArrangedSubview(stackHorizontal)
        }
    }
    
    private func save() {
        print("SAVING")
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(group.self)
            let json = String(data: jsonData, encoding: .utf8)
            UserDefaults.standard.set(json, forKey: "Cache")
        } catch {
            //TODO: throw error if needed
            print("SAVING FAILURE")
        }
    }
    
    private func read() {
        guard
            let json = UserDefaults.standard.string(forKey: "Cache"), !json.isEmpty,
            let jsonData = json.data(using: .utf8)
        else {
            initDataIfNeeded()
            return
        }
        let decoder = JSONDecoder()
        do {
            let group = try decoder.decode([[Person]].self, from: jsonData)
            self.group = group
        } catch {
            initDataIfNeeded()
            //TODO: throw error if needed
        }
    }
    
    private func initDataIfNeeded() {
        group = [
            [.init("Liam"), .init("Noah"), .init("Oliver"), .init("James")],
            [.init("Elijah"), .init("William"), .init("Lucas"), .init("Mateo")]
        ]
    }
    
    @objc private func toggle(_ sender: PersonButton) {
        sender.isSelected.toggle()
        sender.backgroundColor = sender.isSelected ? .red : .blue
        
        let fn = deboucer.debounce(delay: .milliseconds(500)) {
            self.save()
        }
        fn()
    }
    
    private func addHorizontalStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.frame = CGRect(x: 0, y: 0, width: 0, height: 50)
        return stack
    }
    
    private func createButton(with person: Person) -> UIButton {
        let button = PersonButton()
        button.set(data: person)
        button.setTitle(person.name, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = person.isSelected ? .red : .blue
        button.isSelected = person.isSelected
        return button
    }
}

class Debouncer {
    
    private var currentWorkItem: DispatchWorkItem?
    
    func debounce(delay: DispatchTimeInterval, queue: DispatchQueue = .main, action: @escaping (() -> Void)) -> () -> Void {
        return {  [weak self] in
            guard let self = self else { return }
            self.currentWorkItem?.cancel()
            self.currentWorkItem = DispatchWorkItem { action() }
            queue.asyncAfter(deadline: .now() + delay, execute: self.currentWorkItem!)
        }
    }
}
