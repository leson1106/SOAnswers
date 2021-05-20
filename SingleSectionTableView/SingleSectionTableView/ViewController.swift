//
//  ViewController.swift
//  SingleSectionTableView
//
//  Created by Son Le on 20/05/2021.
//

import UIKit
import SnapKit

class CellData {
    let title: String?
    var isRadioSelected: Bool = false
    
    init(title: String?) {
        self.title = title
    }
}

class TextCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return "TextCell"
    }
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    private let tableView = UITableView()
    private var previousIndexPath: IndexPath?
    private var list = [
        CellData(title: "1"),
        CellData(title: "2"),
        CellData(title: "3"),
        CellData(title: "4"),
        CellData(title: "5"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TextCell.self, forCellReuseIdentifier: "TextCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as! TextCell
        cell.label.text = list[indexPath.row].title
        cell.label.textColor = list[indexPath.row].isRadioSelected ? .red : .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndexPath = indexPath
        var indexesToReload: [IndexPath] = []
        
        if previousIndexPath != currentIndexPath {
            if let previousIndex = previousIndexPath?.row {
                //reset previous selection if needed
                list[previousIndex].isRadioSelected = false
                indexesToReload.append(previousIndexPath!)
            }
            previousIndexPath = currentIndexPath
            indexesToReload.append(currentIndexPath)
        } else {
            list[currentIndexPath.row].isRadioSelected.toggle()
            indexesToReload.append(currentIndexPath)
        }
        
        list[indexPath.row].isRadioSelected.toggle()
        tableView.reloadRows(at: indexesToReload, with: .none)
    }
}
