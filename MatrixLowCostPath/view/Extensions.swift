//
//  Extensions.swift
//  MatrixLowCostPath
//
//  Created by Emayavaramban Srinivasan on 4/10/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//


import Foundation
import UIKit
extension UIView{
    
    //MARK : - Set the width constraint
    
    func setWidthConstraint(_ width:CGFloat,priority:UILayoutPriority){
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        widthConstraint.priority = priority
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([widthConstraint])
    }
    
    //MARK :- Set the height Constraint
    
    func setHeightConstraint(_ height:CGFloat,priority:UILayoutPriority){
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        heightConstraint.priority = priority
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([heightConstraint])
    }
    
    //MARK :- set top,bottom,leading and trailing constraint with super view
    
    func pinToSuperView(){
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview, attribute: .trailing, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1, constant: 0)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingConstraint,leadingConstraint,topConstraint,bottomConstraint])
    }
    
    //Mark : -  Set the leading constraint of the view
    
    func setLeadingInSuperview(_ margin:CGFloat,priority:UILayoutPriority){
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview!, attribute: .leading, multiplier: 1, constant: margin)
        leadingConstraint.priority = priority
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([leadingConstraint])
    }
    
    //MARK :- Set the trailing Constraint of the view
    
    func setTrailingInSuperview(_ margin:CGFloat,priority:UILayoutPriority){
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview!, attribute: .trailing, multiplier: 1, constant: margin)
        trailingConstraint.priority = priority
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([trailingConstraint])
    }
    
    //MARK :- Set the top constraint with it super view
    
    func setTopInSuperview(_ margin:CGFloat,priority:UILayoutPriority){
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview!, attribute: .top, multiplier: 1, constant: margin)
        topConstraint.priority = priority
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topConstraint])
    }
    
    //MARK :- Set the Bottom constraint with it super view
    
    func setBottomInSuperview(_ margin:CGFloat,priority:UILayoutPriority){
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview!, attribute: .bottom, multiplier: 1, constant: margin)
        bottomConstraint.priority = priority
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bottomConstraint])
    }
}


