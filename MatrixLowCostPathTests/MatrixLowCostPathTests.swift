//
//  MatrixLowCostPathTests.swift
//  MatrixLowCostPathTests
//
//  Created by Emayavaramban Srinivasan on 4/10/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//

import XCTest
@testable import MatrixLowCostPath

class MatrixLowCostPathTests: XCTestCase {
    
    let grid1 = [[3,4,1,2,8,6],[6,1,8,2,7,4],[5,9,3,9,9,5],[8,4,1,3,2,6],[3,7,2,8,6,4]] // 6 * 5 matrix normal Flow
    let grid2 = [[3,4,1,2,8,6],[6,1,8,2,7,4],[5,9,3,9,9,5],[8,4,1,3,2,6],[3,7,2,1,2,3]] //6 * 5 Matrix normal flow
    let grid3 = [[19,10,19,10,19],[21,23,20,19,12],[20,12,20,11,10]]  // 5 * 3 with no path <  50
    let grid4 = [[5,8,5,3,5]] // 1 * 5  matrix normal flow
    let grid5 = [[5],[8],[5],[3],[5]] //  5 * 1 matrix noraml flow
    let grid6 = [[5,4,0],[8,"M",7],[5,7,5]] // Non Numeric input - optional
    let grid7 = [[]] // Empty matrix - optional
    let grid8 = [[69,10,19,10,19],[51,23,20,19,12],[60,12,20,11,10]] // Straing with > 50
    let grid9 = [[60,3,3,6],[6,3,7,9],[5,6,8,3]] // one value  > 50
    let grid10 = [[6,3,-5,9],[-5,2,4,10],[3,-2,6,10],[6,-1,-2,10]] // Negative values
    let grid11 = [[51,51],[0,51],[51,51],[5,5]] // complete path vs low cost incomplete path
    let grid12 = [[51,51,51],[0,51,51],[51,51,51],[51,51,51]] //Longer incomplete path VS Shorter Lower cost incomplete path
    let grid13 = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]]  // Larger number of column
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK : -  Test 6 * 5 matrix normal Flow
    func testGrid1() {
        let output = findPathOfLowestCost(grid1, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertTrue(output!.0)
        XCTAssertEqual(16,output!.1)
        XCTAssertEqual([1,2,3,4,4,5], output!.2)
    }
    
    //MARK :- //6 * 5 Matrix normal flow
    
    func testGrid2(){
        let output = findPathOfLowestCost(grid2, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertTrue(output!.0)
        XCTAssertEqual(11,output!.1)
        XCTAssertEqual([1,2,1,5,4,5], output!.2)
    }
    
    //MARK :- Test  5 * 3 with no path <  50
    func testGrid3(){
        let output = findPathOfLowestCost(grid3, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertFalse(output!.0)
        XCTAssertEqual(48,output!.1)
        XCTAssertEqual([1,1,1], output!.2)
    }
    
    //MARK :- // 1 * 5  matrix normal flow
    func testGrid4(){
        let output = findPathOfLowestCost(grid4, maximumCost: 50)
        XCTAssertNotNil(output)
        print("the array 0 is \(output!.0)")
        print(output!.1)
        print(output!.2)
        XCTAssertTrue(output!.0)
        XCTAssertEqual(26,output!.1)
        XCTAssertEqual([1,1,1,1,1], output!.2)
    }
    
    //MARK :- Test  5 * 1 matrix noraml flow
    func testGrid5(){
        let output = findPathOfLowestCost(grid5, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertTrue(output!.0)
        XCTAssertEqual(3,output!.1)
        XCTAssertEqual([4], output!.2)
    }
    // MARK :- Test Empty matrix - optional
    func testGrid7(){
        let output = findPathOfLowestCost(grid7 as! [[Int]], maximumCost: 50)
        XCTAssertNil(output)
        
    }
    
    //MARK :- // Straing with > 50
    func testGrid8(){
        let output = findPathOfLowestCost(grid8, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertFalse(output!.0)
        XCTAssertEqual(0,output!.1)
        XCTAssertEqual([], output!.2)
    }
    
    //MARK :- // one value  > 50
    func testGrid9(){
        let output = findPathOfLowestCost(grid9, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertTrue(output!.0)
        XCTAssertEqual(14,output!.1)
        XCTAssertEqual([3,2,1,3], output!.2)
    }
    // MARK :- test the Negative values
    func testGrid10(){
        let output = findPathOfLowestCost(grid10, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertTrue(output!.0)
        XCTAssertEqual(0,output!.1)
        XCTAssertEqual([2,3,4,1], output!.2)
    }
    // MARK :- Test one value  is greater than 50
    func testGrid11(){
        let output = findPathOfLowestCost(grid11, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertTrue(output!.0)
        XCTAssertEqual(10,output!.1)
        XCTAssertEqual([4,4], output!.2)
    }
    // MARK :- Test the complete path vs low cost incomplete path
    func testGrid12(){
        let output = findPathOfLowestCost(grid12, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertFalse(output!.0)
        XCTAssertEqual(0,output!.1)
        XCTAssertEqual([2], output!.2)
    }
    //MARK :- Test the Longer incomplete path VS Shorter Lower cost incomplete path
    func testGrid113(){
        let output = findPathOfLowestCost(grid13, maximumCost: 50)
        XCTAssertNotNil(output)
        XCTAssertTrue(output!.0)
        XCTAssertEqual(20,output!.1)
        XCTAssertEqual([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], output!.2)
    }
}


