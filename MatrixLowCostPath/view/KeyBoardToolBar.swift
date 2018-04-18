//
//  KeyBoardToolBar.swift
//  MatrixLowCostPath
//
//  Created by Emayavaramban Srinivasan on 4/10/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//

import Foundation
import UIKit
//MARK : - keyboardToolbar class used to  placement place a button on a toolbar or tab bar.
class KeyboardToolbar:UIToolbar{
    
    let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    //MARK : - Method will add the buttons into the tool bar
    func setupView(){
        sizeToFit()
        barTintColor = UIColor.groupTableViewBackground
        setItems([flexible,doneButton], animated: true)
        
    }
}


