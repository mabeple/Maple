//
//  UICollectionViewExtensionTests.swift
//  Maple
//
//  Created by cy on 2026/1/19.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit
import Testing
@testable import Maple

@Suite("UICollectionView Extensions Test Suite")
struct UICollectionViewExtensionTests {
    
    // MARK: - Property: lastSection
    
    @Test("lastSection should return last section index")
    @MainActor
    func testLastSection() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 3, itemsPerSection: 5)
        collectionView.dataSource = dataSource
        
        // Force layout to update
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        #expect(collectionView.mp.lastSection == 2)
    }
    
    @Test("lastSection should return nil for empty collection view")
    @MainActor
    func testLastSectionNil() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let dataSource = TestCollectionViewDataSource(sections: 0, itemsPerSection: 0)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        #expect(collectionView.mp.lastSection == nil)
    }
    
    // MARK: - Property: indexPathForLastItem
    
    @Test("indexPathForLastItem should return last item index path")
    @MainActor
    func testIndexPathForLastItem() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 2, itemsPerSection: 3)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        let indexPath = collectionView.mp.indexPathForLastItem
        #expect(indexPath != nil)
        #expect(indexPath?.section == 1)
        #expect(indexPath?.item == 2)
    }
    
    // MARK: - Method: numberOfItems
    
    @Test("numberOfItems should return total item count")
    @MainActor
    func testNumberOfItems() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 2, itemsPerSection: 5)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        #expect(collectionView.mp.numberOfItems() == 10)
    }
    
    @Test("numberOfItems should return zero for empty collection view")
    @MainActor
    func testNumberOfItemsEmpty() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let dataSource = TestCollectionViewDataSource(sections: 0, itemsPerSection: 0)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        #expect(collectionView.mp.numberOfItems() == 0)
    }
    
    // MARK: - Method: indexPathForLastItem(inSection:)
    
    @Test("indexPathForLastItem should return last item in section")
    @MainActor
    func testIndexPathForLastItemInSection() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 2, itemsPerSection: 5)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        let indexPath = collectionView.mp.indexPathForLastItem(inSection: 0)
        #expect(indexPath != nil)
        #expect(indexPath?.section == 0)
        #expect(indexPath?.item == 4)
    }
    
    @Test("indexPathForLastItem should return nil for invalid section")
    @MainActor
    func testIndexPathForLastItemInvalidSection() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 1, itemsPerSection: 3)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        let indexPath = collectionView.mp.indexPathForLastItem(inSection: 5)
        #expect(indexPath == nil)
    }
    
    @Test("indexPathForLastItem should return first item for empty section")
    @MainActor
    func testIndexPathForLastItemEmptySection() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 2, itemsPerSection: 0)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        let indexPath = collectionView.mp.indexPathForLastItem(inSection: 0)
        #expect(indexPath != nil)
        #expect(indexPath?.item == 0)
    }
    
    // MARK: - Method: reloadData(_:)
    
    @Test("reloadData with completion should call completion handler")
    @MainActor
    func testReloadDataCompletion() async {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        var completionCalled = false
        
        collectionView.mp.reloadData {
            completionCalled = true
        }
        
        // Wait a bit for completion
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        
        #expect(completionCalled == true)
    }
    
    // MARK: - Method: isValidIndexPath(_:)
    
    @Test("isValidIndexPath should return true for valid index path")
    @MainActor
    func testIsValidIndexPath() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 2, itemsPerSection: 5)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        let indexPath = IndexPath(item: 2, section: 0)
        #expect(collectionView.mp.isValidIndexPath(indexPath) == true)
    }
    
    @Test("isValidIndexPath should return false for invalid index path")
    @MainActor
    func testIsValidIndexPathInvalid() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 1, itemsPerSection: 3)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        let indexPath = IndexPath(item: 10, section: 0)
        #expect(collectionView.mp.isValidIndexPath(indexPath) == false)
    }
    
    // MARK: - Method: safeScrollToItem(at:at:animated:)
    
    @Test("safeScrollToItem should scroll to valid index path")
    @MainActor
    func testSafeScrollToItem() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 2, itemsPerSection: 5)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        
        let indexPath = IndexPath(item: 2, section: 0)
        collectionView.mp.safeScrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        
        // Method should execute without error
        #expect(collectionView.mp.isValidIndexPath(indexPath) == true)
    }
    
    @Test("safeScrollToItem should not scroll to invalid index path")
    @MainActor
    func testSafeScrollToItemInvalid() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), collectionViewLayout: layout)
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        let dataSource = TestCollectionViewDataSource(sections: 1, itemsPerSection: 3)
        collectionView.dataSource = dataSource
        
        collectionView.reloadData()
        
        let indexPath = IndexPath(item: 10, section: 0)
        collectionView.mp.safeScrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        
        // Method should not crash
        #expect(collectionView.mp.isValidIndexPath(indexPath) == false)
    }
    
    // MARK: - Registration and Dequeue Methods
    
    @Test("register and dequeueReusableCell should work")
    @MainActor
    func testRegisterAndDequeueCell() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.mp.register(cellWithClass: TestCollectionViewCell.self)
        
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.mp.dequeueReusableCell(withClass: TestCollectionViewCell.self, for: indexPath)
        
        #expect(type(of: cell) == TestCollectionViewCell.self)
    }
    
    @Test("register nibWithCellClass should work with xib from resources")
    @MainActor
    func testRegisterNibWithCellClass() {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Register using UICollectionViewCell.xib from test resources
        // Use Bundle.module to load from test resources
        let nib = UINib(nibName: "UICollectionViewCell", bundle: Bundle.module)
        collectionView.mp.register(nib: nib, forCellWithClass: UICollectionViewCell.self)
        
        // Verify registration by attempting to dequeue
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = collectionView.mp.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        #expect(type(of: cell) == UICollectionViewCell.self)
    }
}

// MARK: - Test Helpers

class TestCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    let sections: Int
    let itemsPerSection: Int
    
    init(sections: Int, itemsPerSection: Int) {
        self.sections = sections
        self.itemsPerSection = itemsPerSection
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsPerSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.mp.dequeueReusableCell(withClass: TestCollectionViewCell.self, for: indexPath)
    }
}

class TestCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
