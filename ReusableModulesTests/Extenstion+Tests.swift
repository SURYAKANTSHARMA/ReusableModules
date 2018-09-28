//
//  Extenstion+Tests.swift
//  ReusableModulesTests
//
//  Created by Mac mini on 9/28/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import XCTest
@testable import ReusableModules

class Extenstion_Tests: XCTestCase {
    var app: AppDelegate!
    
    override func setUp() {
        app = UIApplication.shared.delegate as? AppDelegate
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testAppExtension() {
        
        XCTAssert(app === appDelegate, "Both instances should is to be equal")
        let vc = UIViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
        XCTAssert(vc === UIApplication.shared.keyWindow?.visibleViewController! , "Both instances should is to be equal")
        let presentedVC = UIViewController()
        vc.present(presentedVC, animated: true, completion: nil)
        
        XCTAssert(presentedVC === UIApplication.shared.keyWindow?.visibleViewController! && presentedVC === app.topViewController() , "Both instances should is to be equal")
        let otherVC = UIViewController()
        app.changeRootViewController(otherVC)
        XCTAssert(otherVC === UIApplication.shared.keyWindow?.visibleViewController! , "Both instances should is to be equal")
       
    }
    

    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
