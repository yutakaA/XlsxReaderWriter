//
//  SwiftTestCase.swift
//  XlsxReaderWriter
//
//  Created by René BIGOT on 07/09/2015.
//  Copyright (c) 2015 BRAE. All rights reserved.
//

import UIKit
import XCTest

class SwiftTestCase: XCTestCase {
    
    let odp: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(Bundle(for: SwiftTestCase.self).path(forResource: "testWorkbook", ofType: "xlsx"))
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSwiftOpenClose() {
        XCTAssertNotNil(odp, "Office document package should not be nil")

        XCTAssertNotNil(odp.workbook, "Office document package should contain a workbook")

        let worksheet: BRAWorksheet = odp.workbook.worksheets[0] as! BRAWorksheet;
        XCTAssertNotNil(worksheet, "Worksheet should not be nil")

        let paths: Array = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true) as Array
        let fullPath: String = paths[0] + "/testSwiftOpenClose.xlsx"
        odp.save(as: fullPath)
        XCTAssert(FileManager.default.fileExists(atPath: fullPath), "No file exists at \(fullPath)")
    }

    func testSwiftAddImageClose() {
        NSLog("Testing code from github issue #11")
        XCTAssertNotNil(odp.workbook, "Office document package should contain a workbook")

        let worksheet: BRAWorksheet = odp.workbook.worksheets[0] as! BRAWorksheet;
        XCTAssertNotNil(worksheet, "Worksheet should not be nil")

        let filePath = Bundle(for: self.classForCoder).path(forResource: "photo-1415226481302-c40f24f4d45e", ofType: "jpeg")!
        let fileURL = URL(fileURLWithPath: filePath)
        let data = try? Data(contentsOf: fileURL)
        let image = UIImage(data: data!)
        
        let size = CGSize(width: image!.size.width * 6350, height: image!.size.height * 6350)
        let drawing = worksheet.add(image, inCellReferenced: "H2",
                                    withOffset: CGPoint(x:15, y:10),
                                    size: size ,
                                    preserveTransparency: true)
        
        XCTAssertNotNil(drawing, "No drawing created");
        
        let url = self.getDocumentsDirectory().appendingPathComponent("testAddOnceCellAnchoredImageGithubIssue11.xlsx")
        odp.save(as: url.path)
        print(url)
        
    }

}
//BRAWorksheetDrawing *drawing = [worksheet addImage:image
//                                  inCellReferenced:@"G2"
//                                        withOffset:CGPointZero
//                                              size:CGSizeMake(400. * 12700, 300 * 12700)
//                              preserveTransparency:NO];
