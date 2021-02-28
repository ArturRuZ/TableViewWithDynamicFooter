//
//  ViewController.swift
//  DynamicHeaderUsageDemo
//
//  Created by Artur Ruzhnikov on 27.02.2021.
//

import UIKit

class ViewController: UIViewController {
   
   @IBOutlet weak var demoTableView: TableViewWithDynamicFooter!
   private let mockDataGenerator = MockDataGenerator()
   private let minDataCount: Int = 3
   private let maxDataCount: Int = 50
   private let demoCellId = "CellIdentifier"
   private lazy var demoData: [String] = {
      return mockDataGenerator.generate(count: minDataCount)
   }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      demoTableView.delegate = self
      demoTableView.dataSource = self
      
      let footer =  DemoFooter(frame: .zero)
      footer.delegate = self
      demoTableView.tableFooterView = footer
   }
}

//MARK:-  UITableViewDelegate, UITableViewDataSource implementation
extension ViewController: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      demoData.count
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: UITableViewCell =
         tableView.dequeueReusableCell(withIdentifier: demoCellId) ?? UITableViewCell(style: .default, reuseIdentifier: demoCellId)
      
      let model = demoData[indexPath.row]
      cell.textLabel?.text = model
      
      return cell
   }
}

//MARK:- DemoFooterDelegate implementation
extension ViewController: DemoFooterDelegate {
   func onUpdateRequest() {
      let random = Int.random(in: 1..<30)
      demoData = mockDataGenerator.generate(count: random)
      demoTableView.reloadData()
   }
}

//MARK:- Tmp dataModel helper
fileprivate class MockDataGenerator {
   private let basePart: String = "Mock record"
   
   func generate(count: Int) -> [String] {
      var result: [String] = []
      for index in 0..<count {
         result.append(basePart + " \(index)")
      }
      return result
   }
}
