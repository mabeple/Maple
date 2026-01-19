//
//  UITableViewExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UITableView Extensions Test Suite")
struct UITableViewExtensionTests {
    
    // MARK: - Property: lastSection
    
    @Test("lastSection should return last section index")
    @MainActor
    func testLastSection() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 3, rowsPerSection: 5)
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        #expect(tableView.mp.lastSection == 2)
    }
    
    @Test("lastSection should return nil for empty table view")
    @MainActor
    func testLastSectionNil() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 0, rowsPerSection: 0)
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        #expect(tableView.mp.lastSection == nil)
    }
    
    // MARK: - Property: indexPathForLastRow
    
    @Test("indexPathForLastRow should return last row index path")
    @MainActor
    func testIndexPathForLastRow() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 2, rowsPerSection: 3)
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        let indexPath = tableView.mp.indexPathForLastRow
        #expect(indexPath != nil)
        #expect(indexPath?.section == 1)
        #expect(indexPath?.row == 2)
    }
    
    // MARK: - Method: numberOfRows
    
    @Test("numberOfRows should return total row count")
    @MainActor
    func testNumberOfRows() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 2, rowsPerSection: 5)
        tableView.dataSource = dataSource
        tableView.reloadData()
        #expect(tableView.mp.numberOfRows() == 10)
    }
    
    @Test("numberOfRows should return zero for empty table view")
    @MainActor
    func testNumberOfRowsEmpty() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 0, rowsPerSection: 0)
        tableView.dataSource = dataSource
        tableView.reloadData()
        #expect(tableView.mp.numberOfRows() == 0)
    }
    
    // MARK: - Method: indexPathForLastRow(inSection:)
    
    @Test("indexPathForLastRow should return last row in section")
    @MainActor
    func testIndexPathForLastRowInSection() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 2, rowsPerSection: 5)
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        let indexPath = tableView.mp.indexPathForLastRow(inSection: 0)
        #expect(indexPath != nil)
        #expect(indexPath?.section == 0)
        #expect(indexPath?.row == 4)
    }
    
    @Test("indexPathForLastRow should return nil for invalid section")
    @MainActor
    func testIndexPathForLastRowInvalidSection() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 1, rowsPerSection: 3)
        tableView.dataSource = dataSource
        tableView.reloadData()
        
        // Test with negative section
        let indexPath1 = tableView.mp.indexPathForLastRow(inSection: -1)
        #expect(indexPath1 == nil)
        
        // Test with section beyond bounds
        let indexPath2 = tableView.mp.indexPathForLastRow(inSection: 5)
        #expect(indexPath2 == nil)
    }
    
    @Test("indexPathForLastRow should return first row for empty section")
    @MainActor
    func testIndexPathForLastRowEmptySection() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 2, rowsPerSection: 0)
        tableView.dataSource = dataSource
        
        tableView.reloadData()
        
        let indexPath = tableView.mp.indexPathForLastRow(inSection: 0)
        #expect(indexPath != nil)
        #expect(indexPath?.row == 0)
    }
    
    // MARK: - Method: reloadData(_:)
    
    @Test("reloadData with completion should call completion handler")
    @MainActor
    func testReloadDataCompletion() async {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        var completionCalled = false
        
        tableView.mp.reloadData {
            completionCalled = true
        }
        
        // Wait a bit for completion
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(completionCalled == true)
    }
    
    // MARK: - Method: removeTableFooterView
    
    @Test("removeTableFooterView should remove footer view")
    @MainActor
    func testRemoveTableFooterView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        let footerView = UIView()
        tableView.tableFooterView = footerView
        
        tableView.mp.removeTableFooterView()
        
        #expect(tableView.tableFooterView == nil)
    }
    
    // MARK: - Method: removeTableHeaderView
    
    @Test("removeTableHeaderView should remove header view")
    @MainActor
    func testRemoveTableHeaderView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        let headerView = UIView()
        tableView.tableHeaderView = headerView
        
        tableView.mp.removeTableHeaderView()
        
        #expect(tableView.tableHeaderView == nil)
    }
    
    // MARK: - Method: scrollToBottom
    
    @Test("scrollToBottom should scroll to bottom")
    @MainActor
    func testScrollToBottom() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 1, rowsPerSection: 10)
        tableView.dataSource = dataSource
        
        tableView.reloadData()
        tableView.layoutIfNeeded()
        
        tableView.mp.scrollToBottom(animated: false)
        
        // Verify scroll position is at or near bottom
        let bottomOffset = CGPoint(x: 0, y: tableView.contentSize.height - tableView.bounds.size.height)
        #expect(tableView.contentOffset.y >= bottomOffset.y - 1) // Allow small tolerance
    }
    
    // MARK: - Method: scrollToTop
    
    @Test("scrollToTop should scroll to top")
    @MainActor
    func testScrollToTop() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 1, rowsPerSection: 10)
        tableView.dataSource = dataSource
        
        tableView.reloadData()
        tableView.layoutIfNeeded()
        
        tableView.contentOffset = CGPoint(x: 0, y: 500)
        
        tableView.mp.scrollToTop(animated: false)
        
        #expect(tableView.contentOffset == .zero)
    }
    
    // MARK: - Method: isValidIndexPath(_:)
    
    @Test("isValidIndexPath should return true for valid index path")
    @MainActor
    func testIsValidIndexPath() {
        let tableView = UITableView(frame: .zero, style: .plain)
        let dataSource = TestTableViewDataSource(sections: 2, rowsPerSection: 5)
        tableView.dataSource = dataSource
        
        tableView.reloadData()
        
        let indexPath = IndexPath(row: 2, section: 0)
        #expect(tableView.mp.isValidIndexPath(indexPath) == true)
    }
    
    @Test("isValidIndexPath should return false for invalid index path")
    @MainActor
    func testIsValidIndexPathInvalid() {
        let tableView = UITableView(frame: .zero, style: .plain)
        let dataSource = TestTableViewDataSource(sections: 1, rowsPerSection: 3)
        tableView.dataSource = dataSource
        
        tableView.reloadData()
        
        let indexPath = IndexPath(row: 10, section: 0)
        #expect(tableView.mp.isValidIndexPath(indexPath) == false)
    }
    
    // MARK: - Method: safeScrollToRow(at:at:animated:)
    
    @Test("safeScrollToRow should scroll to valid index path")
    @MainActor
    func testSafeScrollToRow() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        let dataSource = TestTableViewDataSource(sections: 2, rowsPerSection: 5)
        tableView.dataSource = dataSource
        
        tableView.reloadData()
        tableView.layoutIfNeeded()
        
        let indexPath = IndexPath(row: 2, section: 0)
        tableView.mp.safeScrollToRow(at: indexPath, at: .middle, animated: false)
        
        // Method should execute without error
        #expect(tableView.mp.isValidIndexPath(indexPath) == true)
    }
    
    @Test("safeScrollToRow should not scroll to invalid index path")
    @MainActor
    func testSafeScrollToRowInvalid() {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), style: .plain)
        let dataSource = TestTableViewDataSource(sections: 1, rowsPerSection: 3)
        tableView.dataSource = dataSource
        
        tableView.reloadData()
        
        let indexPath = IndexPath(row: 10, section: 0)
        tableView.mp.safeScrollToRow(at: indexPath, at: .middle, animated: false)
        
        // Method should not crash
        #expect(tableView.mp.isValidIndexPath(indexPath) == false)
    }
    
    // MARK: - Registration and Dequeue Methods
    
    @Test("register and dequeueReusableCell should work")
    @MainActor
    func testRegisterAndDequeueCell() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        
        let cell = tableView.mp.dequeueReusableCell(withClass: TestTableViewCell.self)
        #expect(type(of: cell) == TestTableViewCell.self)
    }
    
    @Test("register and dequeueReusableCell with indexPath should work")
    @MainActor
    func testRegisterAndDequeueCellWithIndexPath() {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.mp.register(cellWithClass: TestTableViewCell.self)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.mp.dequeueReusableCell(withClass: TestTableViewCell.self, for: indexPath)
        #expect(type(of: cell) == TestTableViewCell.self)
    }
    
    @Test("register nibWithCellClass should work with xib from resources")
    @MainActor
    func testRegisterNibWithCellClass() {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        // Register using UITableViewCell.xib from test resources
        // Use Bundle.module to load from test resources
        let nib = UINib(nibName: "UITableViewCell", bundle: Bundle.module)
        tableView.mp.register(nib: nib, withCellClass: UITableViewCell.self)
        
        // Verify registration by attempting to dequeue
        let cell = tableView.mp.dequeueReusableCell(withClass: UITableViewCell.self)
        #expect(type(of: cell) == UITableViewCell.self)
    }
    
    @Test("register nibWithHeaderFooterViewClass should work with xib from resources")
    @MainActor
    func testRegisterNibWithHeaderFooterViewClass() {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        // Register using UITableViewHeaderFooterView.xib from test resources
        // Use Bundle.module to load from test resources
        let nib = UINib(nibName: "UITableViewHeaderFooterView", bundle: Bundle.module)
        tableView.mp.register(nib: nib, withHeaderFooterViewClass: UITableViewHeaderFooterView.self)
        
        // Verify registration by attempting to dequeue
        let headerFooterView = tableView.mp.dequeueReusableHeaderFooterView(withClass: UITableViewHeaderFooterView.self)
        #expect(type(of: headerFooterView) == UITableViewHeaderFooterView.self)
    }
}

// MARK: - Test Helpers

class TestTableViewDataSource: NSObject, UITableViewDataSource {
    let sections: Int
    let rowsPerSection: Int
    
    init(sections: Int, rowsPerSection: Int) {
        self.sections = sections
        self.rowsPerSection = rowsPerSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsPerSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.mp.dequeueReusableCell(withClass: TestTableViewCell.self)
    }
}

class TestTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
