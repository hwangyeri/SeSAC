//
//  ShoppingTableViewController.swift
//  Setting
//
//  Created by 황예리 on 2023/07/27.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var shoppingList = ["토너", "필링젤", "폰케이스", "모자"]
    let mainTextFieldPlaceholder = "무엇을 구매하실 건가요?"

    @IBOutlet var mainTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var checkboxButton: UIButton!
    @IBOutlet var starButton: UIButton!
    @IBOutlet var shoppingItemLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTextFieldStyle()
        addButtonStyle()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return shoppingList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: " checkList")!
        
        if indexPath.section == 0 {
            cell.textLabel?.text = .none
            cell.imageView?.image = .none
        } else if indexPath.section == 1 {
            cell.textLabel?.text = shoppingList[indexPath.row]
        }
        
        cell.textLabel?.font = .systemFont(ofSize: 15)
        
        return cell
    }
    
    
    func mainTextFieldStyle() {
        mainTextField.backgroundColor = .none
        mainTextField.placeholder = mainTextFieldPlaceholder
        mainTextField.textColor = .black
        mainTextField.font = .systemFont(ofSize: 13)
        mainTextField.borderStyle = .none
    }
    
    func addButtonStyle() {
        addButton.tintColor = .black
        addButton.setTitle("추가", for: .normal)
        addButton.backgroundColor = .systemGray6
        addButton.layer.cornerRadius = 12
        //button font size
        
    }

    @IBAction func clickedAddButton(_ sender: UIButton) {
        shoppingList.append("\(mainTextField.text ?? "error")")
        tableView.reloadData()
    }
    
    
}
