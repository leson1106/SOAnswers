//
//  ViewController.swift
//  MyAnswer
//
//  Created by Son Le on 18/08/2023.
//

import UIKit

//https://stackoverflow.com/questions/77568223/uitableviewcell-programmatical-constrain-issue
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private lazy var tableView: UITableView = {
    
        let view = UITableView()
        
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
    }
 
     
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell: Cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
 
private final class Cell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor  = .clear
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cardView: UIView = {
       
        let view = UIView()
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 18),
            view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 9),
            view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -18),
            view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -9),
//            view.heightAnchor.constraint(equalToConstant: 60)
        ])
        //Changed height priority from 1000 to 999
        var height = view.heightAnchor.constraint(equalToConstant: 60)
        height.priority = .init(999)
        height.isActive = true
        
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
 
    private(set) lazy var buttonOptions: UIButton = {
       
        let button = UIButton()
        self.cardView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
         
            button.widthAnchor.constraint(equalToConstant: 22),
            button.heightAnchor.constraint(equalToConstant: 18),
            button.centerXAnchor.constraint(equalTo: self.cardView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.cardView.centerYAnchor)
        ])
        
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
        button.setImage(UIImage(systemName: "ellipsis")!, for: .normal)
        button.imageView?.tintColor = UIColor.lightGray //<- Constraint warning is here
        return button
    }()
     
     
    func configure() {
         
        self.cardView.backgroundColor = .white
        self.buttonOptions.isHidden = false
    }
}
