//
//  CounterAppTests.swift
//  CounterAppTests
//
//  Created by Камаль Атавалиев on 12.07.2023.
//

import XCTest
@testable import CounterApp

final class CounterAppTests: XCTestCase {
    
    var sut: CounterViewModel!
    
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CounterViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }


    
    func testCounterIncreaseOrDeacrease() {// rename
      // given (дано)
        sut.counter = 10
        let counterPlus = sut.counter + sut.stepCounter
      
      // when (когда)
      sut.changeCounterValue(on: true)
      
      // then (тогда)
        XCTAssertEqual(counterPlus, sut.counter, "Counter is increased or decreased wrong")
    }
    
    func testCounterDeacrease() {// rename
      // given (дано)
        sut.counter = 10
        let counterPlus = sut.counter - sut.stepCounter
      
      // when (когда)
      sut.changeCounterValue(on: false)
      
      // then (тогда)
        XCTAssertEqual(counterPlus, sut.counter, "Counter is increased or decreased wrong")
    }
    
    func testStepCountingIsChanging() {
        sut.stepCounter = 1
        
        sut.changeStepCounterValue(with: 5)
        
        XCTAssertEqual(sut.stepCounter, 5, "Step counting changed wrong")
    }
    
    func testStepCountingIsChangingBack() {
        sut.stepCounter = 2
        
        sut.changeStepCounterValue(with: 2)
        
        XCTAssertEqual(sut.stepCounter, 1, "Step counting changed wrong")
    }
    
    func testResetCounter() {
        sut.counter = 20
        
        sut.refreshCounterValue()
        
        XCTAssertEqual(sut.counter, 0, "Counter resets wrong")
    }
    
    func testSetCounterWhenUserSetItOnSettingsView() {
        sut.counter = 1
        
        sut.setCounterValue(on: 20)
        
        XCTAssertEqual(sut.counter, 20)
    }


}
