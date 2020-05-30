//
//  UITableViewMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2020/5/30.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple
class UITableViewMPTests: XCTestCase {

    let tableView = UITableView()
    let emptyTableView = UITableView()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        tableView.dataSource = self
        emptyTableView.dataSource = self
        tableView.reloadData()
    }
    
    func testIndexPathForLastRow() {
        XCTAssertNotNil(tableView.mp.indexPathForLastRow)
        XCTAssertEqual(tableView.mp.indexPathForLastRow, IndexPath(row: 7, section: 1))
        XCTAssertNil(emptyTableView.mp.indexPathForLastRow)
        XCTAssertNil(emptyTableView.mp.indexPathForLastRow(inSection: 0))
    }
    
    func testLastSection() {
        XCTAssertEqual(tableView.mp.lastSection, 1)
        XCTAssertNil(emptyTableView.mp.lastSection)
    }
    
    func testNumberOfRows() {
        XCTAssertEqual(tableView.mp.numberOfRows(), 13)
        XCTAssertEqual(emptyTableView.mp.numberOfRows(), 0)
    }
    
    func testIndexPathForLastRowInSection() {
        XCTAssertNil(tableView.mp.indexPathForLastRow(inSection: -1))
        XCTAssertNil(emptyTableView.mp.indexPathForLastRow(inSection: -1))
        XCTAssertEqual(tableView.mp.indexPathForLastRow(inSection: 0), IndexPath(row: 4, section: 0))
        XCTAssertEqual(UITableView().mp.indexPathForLastRow(inSection: 0), IndexPath(row: 0, section: 0))
    }
    
    func testReloadData() {
        let exp = expectation(description: "reloadCallback")
        tableView.mp.reloadData {
            XCTAssert(true)
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testRemoveTableFooterView() {
        tableView.tableFooterView = UIView()
        XCTAssertNotNil(tableView.tableFooterView)
        tableView.mp.removeTableFooterView()
        XCTAssertNil(tableView.tableFooterView)
    }

    func testRemoveTableHeaderView() {
        tableView.tableHeaderView = UIView()
        XCTAssertNotNil(tableView.tableHeaderView)
        tableView.mp.removeTableHeaderView()
        XCTAssertNil(tableView.tableHeaderView)
    }
    
    func testScrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height)
        tableView.mp.scrollToBottom()
        XCTAssertEqual(bottomOffset, tableView.contentOffset)
    }

    func testScrollToTop() {
        tableView.mp.scrollToTop()
        XCTAssertEqual(CGPoint.zero, tableView.contentOffset)
    }
    
    func testDequeueReusableCellWithClass() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        let cell = tableView.mp.dequeueReusableCell(withClass: UITableViewCell.self)
        XCTAssertNotNil(cell)
    }
    
    func testDequeueReusableCellWithClassForIndexPath() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        let indexPath = tableView.mp.indexPathForLastRow!
        let cell = tableView.mp.dequeueReusableCell(withClass: UITableViewCell.self, for: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testDequeueReusableHeaderFooterView() {
        tableView.register(UITableViewHeaderFooterView.self,
                           forHeaderFooterViewReuseIdentifier: "UITableViewHeaderFooterView")
        let headerFooterView = tableView.mp.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
        XCTAssertNotNil(headerFooterView)
    }
    
    func testRegisterReusableHeaderFooterView() {
        let nib = UINib(nibName: "UITableViewHeaderFooterView", bundle: Bundle(for: UITableViewMPTests.self))
        tableView.mp.register(nib: nib, withHeaderFooterViewClass: UITableViewHeaderFooterView.self)
        let view = tableView.mp.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
        XCTAssertNotNil(view)
    }
    
    func testRegisterReusableViewWithClass() {
        tableView.mp.register(headerFooterViewClassWith: UITableViewHeaderFooterView.self)
        let view = tableView.mp.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
        XCTAssertNotNil(view)
    }

    func testRegisterCellWithClass() {
        tableView.mp.register(cellWithClass: UITableViewCell.self)
        let cell = tableView.mp.dequeueReusableCell(withClass: UITableViewCell.self)
        XCTAssertNotNil(cell)
    }
    
    func testRegisterCellWithClassAndNib() {
        let nib = UINib(nibName: "UITableViewCell", bundle: Bundle(for: UITableViewMPTests.self))
        tableView.mp.register(nib: nib, withCellClass: UITableViewCell.self)
        let cell = tableView.mp.dequeueReusableCell(withClass: UITableViewCell.self)
        XCTAssertNotNil(cell)
    }

    func testRegisterCellWithNibUsingClass() {
        tableView.mp.register(nibWithCellClass: UITableViewCell.self, at: UITableViewMPTests.self)
        let cell = tableView.mp.dequeueReusableCell(withClass: UITableViewCell.self)
        XCTAssertNotNil(cell)
    }
    
    func testIsValidIndexPath() {
        let validIndexPath = IndexPath(row: 0, section: 0)
        XCTAssertTrue(tableView.mp.isValidIndexPath(validIndexPath))

        let invalidIndexPath = IndexPath(row: 10, section: 0)
        XCTAssertFalse(tableView.mp.isValidIndexPath(invalidIndexPath))

        let negativeIndexPath = IndexPath(row: -1, section: 0)
        XCTAssertFalse(tableView.mp.isValidIndexPath(negativeIndexPath))
    }
    
    func testSafeScrollToIndexPath() {
        let validIndexPathTop = IndexPath(row: 0, section: 0)

        tableView.contentOffset = .init(x: 0, y: 100)
        XCTAssertNotEqual(tableView.contentOffset, .zero)

        tableView.mp.safeScrollToRow(at: validIndexPathTop, at: .top, animated: false)
        XCTAssertEqual(tableView.contentOffset, .zero)

        let validIndexPathBottom = IndexPath(row: 7, section: 1)
        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height)

        tableView.contentOffset = .init(x: 0, y: 200)
        XCTAssertNotEqual(tableView.contentOffset, bottomOffset)

        tableView.mp.safeScrollToRow(at: validIndexPathBottom, at: .bottom, animated: false)
        XCTAssertEqual(bottomOffset.y, tableView.contentOffset.y, accuracy: 2.0)
        let invalidIndexPath = IndexPath(row: 213, section: 21)
        tableView.contentOffset = .zero

        tableView.mp.safeScrollToRow(at: invalidIndexPath, at: .bottom, animated: false)
        XCTAssertEqual(tableView.contentOffset, .zero)
    }
}

extension UITableViewMPTests: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView == self.emptyTableView ? 0 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.emptyTableView {
            return 0
        } else {
            return section == 0 ? 5 : 8
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
