//
//  UICollectionViewMPTests.swift
//  Maple-iOSTests
//
//  Created by cy on 2020/6/3.
//  Copyright © 2020 cy. All rights reserved.
//

import XCTest
@testable import Maple

final private class TestCell: UICollectionViewCell {}

class UICollectionViewMPTests: XCTestCase {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let emptyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let flowLayoutCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 10, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 10, height: 15), collectionViewLayout: layout)
        if #available(iOS 11, *) {
            collection.insetsLayoutMarginsFromSafeArea = false
        }
        collection.contentInset = .zero
        return collection
    }()
    
    override func setUp() {
        super.setUp()

        collectionView.dataSource = self
        collectionView.reloadData()

        emptyCollectionView.dataSource = self
        emptyCollectionView.reloadData()

        flowLayoutCollectionView.dataSource = self
        flowLayoutCollectionView.reloadData()

    }
    
    func testIndexPathForLastRow() {
        XCTAssertEqual(collectionView.mp.indexPathForLastItem, IndexPath(item: 0, section: 1))
    }

    func testLastSection() {
        XCTAssertEqual(collectionView.mp.lastSection, 1)
        XCTAssertNil(emptyCollectionView.mp.lastSection)
    }

    func testNumberOfRows() {
        XCTAssertEqual(collectionView.mp.numberOfItems(), 5)
        XCTAssertEqual(emptyCollectionView.mp.numberOfItems(), 0)
    }
    
    func testIndexPathForLastRowInSection() {
        XCTAssertNil(collectionView.mp.indexPathForLastItem(inSection: -1))
        XCTAssertNil(collectionView.mp.indexPathForLastItem(inSection: 2))
        XCTAssertEqual(collectionView.mp.indexPathForLastItem(inSection: 0), IndexPath(item: 4, section: 0))
    }
    
    func testReloadData() {
        var completionCalled = false
        collectionView.mp.reloadData {
            completionCalled = true
            XCTAssert(completionCalled)
        }
    }
    
    func testRegisterCellWithClass() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.mp.register(cellWithClass: TestCell.self)
        let cell = collectionView.mp.dequeueReusableCell(withClass: TestCell.self, for: indexPath)
        XCTAssertNotNil(cell)
    }

    func testRegisterCellWithNibUsingClass() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.mp.register(nibWithCellClass: UICollectionViewCell.self, at: UICollectionViewMPTests.self)
        let cell = collectionView.mp.dequeueReusableCell(withClass: UICollectionViewCell.self, for: indexPath)
        XCTAssertNotNil(cell)
    }
    
    func testSafeScrollToIndexPath() {
        let validIndexPathTop = IndexPath(row: 0, section: 0)

        flowLayoutCollectionView.contentOffset = CGPoint(x: 0, y: 30)
        XCTAssertNotEqual(flowLayoutCollectionView.contentOffset, .zero)

        flowLayoutCollectionView.mp.safeScrollToItem(at: validIndexPathTop, at: .top, animated: false)
        XCTAssertEqual(flowLayoutCollectionView.contentOffset, .zero)

        let validIndexPathBottom = IndexPath(row: 4, section: 0)

        let bottomOffset = CGPoint(x: 0, y: flowLayoutCollectionView.collectionViewLayout.collectionViewContentSize.height - flowLayoutCollectionView.bounds.size.height)

        flowLayoutCollectionView.contentOffset = CGPoint(x: 0, y: 30)
        XCTAssertNotEqual(flowLayoutCollectionView.contentOffset, bottomOffset)

        flowLayoutCollectionView.mp.safeScrollToItem(at: validIndexPathBottom, at: .bottom, animated: false)

        XCTAssertEqual(bottomOffset.y, flowLayoutCollectionView.contentOffset.y)

        let invalidIndexPath = IndexPath(row: 213, section: 21)
        flowLayoutCollectionView.contentOffset = .zero

        flowLayoutCollectionView.mp.safeScrollToItem(at: invalidIndexPath, at: .bottom, animated: false)
        XCTAssertEqual(flowLayoutCollectionView.contentOffset, .zero)

        let negativeIndexPath = IndexPath(item: -1, section: 0)

        flowLayoutCollectionView.mp.safeScrollToItem(at: negativeIndexPath, at: .bottom, animated: false)
        XCTAssertEqual(flowLayoutCollectionView.contentOffset, .zero)
    }

    func testIsValidIndexPath() {
        let zeroIndexPath = IndexPath(item: 0, section: 0)
        let invalidIndexPath = IndexPath(item: 0, section: 3)
        let validIndexPath = IndexPath(item: 4, section: 0)
        let negativeIndexPath = IndexPath(item: -1, section: 0)

        XCTAssertFalse(emptyCollectionView.mp.isValidIndexPath(zeroIndexPath))

        XCTAssertFalse(collectionView.mp.isValidIndexPath(negativeIndexPath))
        XCTAssertTrue(collectionView.mp.isValidIndexPath(zeroIndexPath))
        XCTAssertTrue(collectionView.mp.isValidIndexPath(validIndexPath))
        XCTAssertFalse(collectionView.mp.isValidIndexPath(invalidIndexPath))
    }
}

extension UICollectionViewMPTests: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (collectionView == self.collectionView || collectionView == self.flowLayoutCollectionView) ? 2 : 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == self.collectionView || collectionView == self.flowLayoutCollectionView) ? (section == 0 ? 5 : 0) : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
