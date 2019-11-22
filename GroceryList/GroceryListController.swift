//
//  ViewController.swift
//  GroceryList
//
//  Created by Alex Paul on 11/21/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

enum SectionTitle: String, CaseIterable {
  case unpurchased = "Unpurchased"
  case purchased = "Purchased"
}

class GroceryListController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var groceryItems = Array(repeating: [GroceryItem](), count: 2)

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
  }

  @IBAction func addItem(segue: UIStoryboardSegue) {
    guard let addGroceryItemController = segue.source as? AddGroceryItemController,
      let groceryItem = addGroceryItemController.groceryItem else {
      fatalError("could not cast to AddGroceryIemController")
    }
    let indexPath = IndexPath(row: groceryItems[0].count, section: 0)
    groceryItems[0].append(groceryItem)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
}

extension GroceryListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groceryItems[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "groceryItemCell", for: indexPath)
    let groceryItem = groceryItems[indexPath.section][indexPath.row]
    cell.textLabel?.text = groceryItem.item
    cell.detailTextLabel?.text = groceryItem.price.description
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return groceryItems.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return SectionTitle.allCases[section].rawValue
  }
}

extension GroceryListController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var item = groceryItems[indexPath.section][indexPath.row]
    item.isPurchased.toggle()
    groceryItems[indexPath.section].remove(at: indexPath.row)
    if item.isPurchased {
      let idxPath = IndexPath(row: groceryItems[1].count, section: 1) // 0, 1
      groceryItems[1].insert(item, at: idxPath.row)
    } else {
      let idxPath = IndexPath(row: groceryItems[0].count, section: 0)
      groceryItems[0].insert(item, at: idxPath.row)
    }
    tableView.reloadData()
  }
}
