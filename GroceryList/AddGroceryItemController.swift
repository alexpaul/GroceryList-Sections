//
//  AddGroceryItemController.swift
//  GroceryList
//
//  Created by Alex Paul on 11/21/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class AddGroceryItemController: UIViewController {
  
  @IBOutlet weak var itemTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  
  var groceryItem: GroceryItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    itemTextField.delegate = self
    priceTextField.delegate = self
    groceryItem = GroceryItem(item: "Item name", price: 0.00, isPurchased: false)
  }
}

extension AddGroceryItemController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    groceryItem?.item = itemTextField.text ?? ""
    groceryItem?.price = Double(priceTextField.text ?? "") ?? 0.00
    
    
    return true
  }
}
