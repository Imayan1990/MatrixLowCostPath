//
//  CollectionViewCell.swift
//  MatrixLowCostPath
//
//  Created by Emayavaramban Srinivasan on 4/10/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//

import Foundation
import UIKit

// MARK : - A single data item when that item is within the collection view’s visible bounds.
class CollectionViewCell:UICollectionViewCell{
    let inputTextField = UITextField()
    private let keyboardToolbar = KeyboardToolbar()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //MARK :- Method will override the super class method.Performs any clean up necessary to prepare the view for use again.
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK : - Method will add all content into the view
    
    private func setupView(){
        
        self.contentView.layer.borderColor = UIColor.red.cgColor
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(inputTextField)
        let priority = UILayoutPriority(1000)
        inputTextField.setTopInSuperview(5, priority: priority)
        inputTextField.setLeadingInSuperview(5, priority: priority)
        inputTextField.setTrailingInSuperview(-5, priority: priority)
        inputTextField.setBottomInSuperview(-5, priority: priority)
        inputTextField.inputAccessoryView = keyboardToolbar
        inputTextField.textAlignment = .center
        inputTextField.font = UIFont.systemFont(ofSize: 10)
        keyboardToolbar.doneButton.target = self
        keyboardToolbar.doneButton.action = #selector(handleReturn)
    }
    
    // MARK : - Method notifies this object that it has been asked to relinquish its status as first responder in its window.
    @objc private func handleReturn(){
        inputTextField.resignFirstResponder()
    }
}

