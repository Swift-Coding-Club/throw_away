//
//  ThrowAwayTests.swift
//  ThrowAwayTests
//
//  Created by Sujin Jin on 2022/11/05.
//

import XCTest
import CoreData

class ThrowAwayTests: XCTestCase {
    var sut: PersistenceController!
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.sut = PersistenceController.shared
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }
    
    func testCoreData_whenAddProduct() throws {
        let viewContext = sut.container.viewContext
        let newItem = Product(context: viewContext)
        newItem.memo = "this is test data"
        newItem.title = "testTitle"
        newItem.image = #imageLiteral(resourceName: "lipstic").pngData()
        newItem.cleaningDay = Date()
        do {
            try viewContext.save()
        } catch {
            XCTFail("Fail add Item to database")
        }
    }
    
    func testCoreData_updateProduct_byTitle() throws {
        let viewContext = sut.container.viewContext
        let updateTargetTitle = "testTitle"
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
        fetchRequest.predicate = NSPredicate(format: "title = %@", updateTargetTitle)
        
        do {
            let fetchResults = try viewContext.fetch(fetchRequest)
            let updatedObject = fetchResults[0] as! NSManagedObject
            updatedObject.setValue("updated Title", forKey: "title")
            updatedObject.setValue("updated memo", forKey: "memo")
            try viewContext.save()
        } catch {
            XCTFail("Fail update Item by title")
        }
    }
    
}
