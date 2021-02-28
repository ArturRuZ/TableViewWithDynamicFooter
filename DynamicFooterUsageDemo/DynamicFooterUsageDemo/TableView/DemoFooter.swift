//
//  DemoFooter.swift
//  DynamicHeaderUsageDemo
//
//  Created by Artur Ruzhnikov on 27.02.2021.
//

import UIKit

protocol DemoFooterDelegate: class {
   func onUpdateRequest()
}

final class DemoFooter: UIView {
   weak var delegate: DemoFooterDelegate?
   
   @objc private func requstUpdatePressed() {
      delegate?.onUpdateRequest()
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      setupUI()
   }
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

//MARK:- Setting UI
extension DemoFooter {
   private func setupUI() {
      let button = UIButton(type: .system)
      button.setTitle("Update", for: .normal)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.layer.borderColor = button.titleColor(for: .normal)?.cgColor
      button.layer.borderWidth = 1
      button.layer.cornerRadius = 10
      button.addTarget(self, action: #selector(requstUpdatePressed), for: .touchUpInside)
      
      self.addSubview(button)
      
      let topSpacing = button.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 10)
      let bottomSpacing = button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
      topSpacing.priority = .init(900)
      bottomSpacing.priority = .init(1000)
      
      NSLayoutConstraint.activate([
         topSpacing, bottomSpacing,
         button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
         button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
      ])
   }
}
