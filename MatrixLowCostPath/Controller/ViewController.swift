//
//  ViewController.swift
//  MatrixLowCostPath
//
//  Created by Emayavaramban Srinivasan on 4/10/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    //  Lazy variable which usd to get the number of rows and columns (closure)
    //  inputAlert variable of type UIAlertController
    private lazy var inputAlert:UIAlertController = {
        let inputAlert = UIAlertController(title: "Input the number of rows and columns", message: nil, preferredStyle: .alert)
        inputAlert.addTextField(configurationHandler: {(numberOfRowsTextField) in
            numberOfRowsTextField.keyboardType = .numberPad
            numberOfRowsTextField.placeholder = "Enter the number of rows"
        })
        inputAlert.addTextField(configurationHandler: {(numberOfColumnsTextField) in
            numberOfColumnsTextField.keyboardType = .numberPad
            numberOfColumnsTextField.placeholder = "Enter the number of columns"
        })
        
        return inputAlert
    }()
    
    // Lazy variable which is used to get he collection view
    // inputOutputCollectionView variable of type UICollectionView
    private lazy var inputOutputCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 44, height: 44)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()
    
    
    fileprivate var inputArray:[[Int]] = Array(repeating: Array(repeating: 0, count: 6), count: 5)
    fileprivate let sumLabel = UILabel()
    fileprivate let pathCompletedLabel = UILabel()
    fileprivate let pathLabel = UILabel()
    
    /*
     Notifies the view controller that its view was added to a view hierarchy.
     You can override this method to perform additional tasks associated with presenting the view.
     If you override this method, you must call super at some point in your implementation.
     
     - parameter
     - animated :If true, the view was added to the window using an animation
     
     
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showInputAlert()
        view.addSubview(inputOutputCollectionView)
        view.addSubview(sumLabel)
        view.addSubview(pathCompletedLabel)
        view.addSubview(pathLabel)
        view.backgroundColor = UIColor.green
        let priority = UILayoutPriority(1000)
        inputOutputCollectionView.setTopInSuperview(65,priority:priority)
        inputOutputCollectionView.setLeadingInSuperview(0,priority:priority)
        inputOutputCollectionView.setTrailingInSuperview(0,priority:priority)
        inputOutputCollectionView.setBottomInSuperview(0,priority:priority)
        inputOutputCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        inputOutputCollectionView.dataSource = self
        inputOutputCollectionView.delegate = self
        sumLabel.backgroundColor = UIColor.white
        sumLabel.textAlignment = .center
        sumLabel.setLeadingInSuperview(0, priority: priority)
        sumLabel.setTopInSuperview(20, priority: priority)
        sumLabel.setWidthConstraint(100,priority:priority)
        sumLabel.setHeightConstraint(44,priority:priority)
        pathCompletedLabel.backgroundColor = UIColor.white
        pathCompletedLabel.textAlignment = .center
        pathCompletedLabel.setLeadingInSuperview(105, priority: priority)
        pathCompletedLabel.setTopInSuperview(20, priority: priority)
        pathCompletedLabel.setWidthConstraint(100, priority: priority)
        pathCompletedLabel.setHeightConstraint(44, priority: priority)
        pathLabel.backgroundColor = UIColor.white
        pathLabel.textAlignment = .center
        pathLabel.setLeadingInSuperview(210, priority: priority)
        pathLabel.setTopInSuperview(20, priority: priority)
        pathLabel.setWidthConstraint(200, priority: priority)
        pathLabel.setHeightConstraint(44, priority: priority)
    }
    
    
    // Method show an alert when user provide input with appropriate message,if any
    // No input parameter
    private func showInputAlert(){
        inputAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned inputAlert] Void in
            guard let numberOfRowsText = inputAlert.textFields?[0].text, let numberOfRows = Int(numberOfRowsText),numberOfRows > 1 || numberOfRows <= 10 else{
                self.showWarningAlert("Enter a number of rows that is mininum 1 and maximum 10")
                return
            }
            guard let numberOfColumnsText = inputAlert.textFields?[1].text, let numberOfColumns = Int(numberOfColumnsText), numberOfColumns >=  1 else{
                self.showWarningAlert("Enter a number of columns that is minimum 1")
                return
            }
            
            self.inputArray = Array(repeating: Array(repeating: 0, count: numberOfColumns), count: numberOfRows)
            self.inputOutputCollectionView.reloadData()
        }))
        self.present(inputAlert, animated: true, completion: nil)
    }
    
    // Method show Error Mesage when user enter incorrect input
    private func showWarningAlert(_ message:String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: {[unowned self] (_)->Void in
            self.present(self.inputAlert, animated: true, completion: nil)
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion:nil)
    }
}
/*
 Keeps track the user input using textFieldDidEndEditing and throw warning/Error message if any
 MARK : - UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate inherited
 
 */
extension ViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
        guard let text = textField.text,let value = Int(text) else{
            showWarningAlert("\(String(describing: textField.text!)) is not valid number.please enter int values")
            return
        }
        guard let cell = textField.superview?.superview as? CollectionViewCell,let indexPath = inputOutputCollectionView.indexPath(for: cell) else{
            return
        }
        inputArray[indexPath.row][indexPath.section] = value
        guard let result = findPathOfLowestCost(inputArray,maximumCost: 50) else{
            return
        }
        pathCompletedLabel.text = result.0 ? "YES" : "NO"
        sumLabel.text = "SUM = " + String(result.1)
        pathLabel.text = String(describing: result.2)
        for (rowIndex,row) in inputArray.enumerated(){
            for (columnIndex,_) in row.enumerated(){
                let cell = inputOutputCollectionView.cellForItem(at: IndexPath(row: rowIndex, section: columnIndex))
                cell?.contentView.layer.borderWidth = 0
            }
        }
        for (column,row) in result.2.enumerated(){
            let indexPath = IndexPath(row: row - 1, section: column)
            guard let cell = inputOutputCollectionView.cellForItem(at: indexPath) else{
                return
            }
            cell.contentView.layer.borderWidth = 2
        }
    }
    
    /*
     MARK: - Asks your data source object for the cell that corresponds to the specified item in the collection view.
     
     - Parameters:
     - collectionView:The collection view requesting this information.
     - indexPath: The index path that specifies the location of the item.
     - Returns:
     -cell: A configured cell object. You must not return nil from this method.
     */
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.inputTextField.text = String(self.inputArray[indexPath.row][indexPath.section])
        cell.inputTextField.delegate = self
        return cell
    }
    
    /*
     MARK: - Asks your data source object for the number of items in the specified section.
     
     - Parameters:
     - collectionView: The collection view requesting this information.
     - section: An index number identifying a section in collectionView. This index value is 0-based.
     - Returns:
     - inputArray.Count Count of an Array .The number of rows in section.
     
     */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.inputArray.count
    }
    
    
    /*
     Asks your data source object for the number of sections in the collection view.
     If you do not implement this method, the collection view uses a default value of 1.
     
     - Parameters:
     - collectionView- The collection view requesting this information.
     - Returns:
     - inputArray[0].count .The number of sections in collectionView.
     
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.inputArray[0].count
    }
    
    /*
     MARK :- Asks the delegate for the margins to apply to content in the specified section.
     
     - Parameters:
     - collectionView: The collection view object displaying the flow layout.
     - collectionViewLayout: The layout object requesting the information.
     - section:- The index number of the section whose insets are needed.
     - Returns:
     - The margins to apply to items in the section.
     
     
     */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 1)
    }
    /*
     
     MARKS : - Asks the delegate for the spacing between successive items in the rows or columns of a section.
     
     - Parameters:
     - collectionView: The collection view object displaying the flow layout.
     - collectionViewLayout: The layout object requesting the information.
     - section: The index number of the section whose inter-item spacing is needed.
     - Returns
     - The minimum space (measured in points) to apply between successive items in the lines of a section.
     
     
     
     */
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}


