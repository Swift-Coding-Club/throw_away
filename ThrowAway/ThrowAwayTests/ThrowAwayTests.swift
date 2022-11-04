//
//  ThrowAwayTests.swift
//  ThrowAwayTests
//
//  Created by Sujin Jin on 2022/11/05.
//

import XCTest
import CoreData

class ThrowAwayTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCoreData_whenAddProduct() throws {
        let persistenceController = PersistenceController.shared
        let viewContext = persistenceController.container.viewContext
        let newItem = Product(context: viewContext)
        newItem.timestamp = Date()
        newItem.memo = "this is test data"
        newItem.title = "testTitle3"
        newItem.image = #imageLiteral(resourceName: "lipstic").pngData()
        newItem.cleaningDay = Date()
        
        do {
            try viewContext.save()
        } catch {
            XCTFail("Fail add Item to database")
        }
    }
}
