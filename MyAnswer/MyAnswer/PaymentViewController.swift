//
//  PaymentViewController.swift
//  MyAnswer
//
//  Created by Son Le on 11/11/2023.
//

import UIKit

//https://stackoverflow.com/questions/77464180/uitableviewcell-self-sizing-mess-up
struct Payment {
    var type: String
    var amount: Double
}

class PaymentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentAmountCell") as! PaymentAmountCell
        cell.selectionStyle = .none
        let data = array[indexPath.row]
        cell.type.text = data.type
        cell.amount.text = "$\(data.amount)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath)")
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselected \(indexPath)")
    }
    
    var array: [Payment] = [
        .init(type: "Minimum Payment Due", amount: 152.17),
        .init(type: "Lastest Statement Balance", amount: 5319.49),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "PaymentAmountCell", bundle: .main), forCellReuseIdentifier: "PaymentAmountCell")
        tableView.allowsMultipleSelection = false
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    @IBAction func tapAction(_ sender: Any) {
        if let selectedIndex = tableView.indexPathsForSelectedRows {
            print(selectedIndex)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
