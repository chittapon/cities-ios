//
//  SearchViewModelTests.swift
//  CitiesTests
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import XCTest
import RxSwift
@testable import Cities

final class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel!
    var useCaseSpy: GetCityListUseCaseSpy!
    var bag: DisposeBag!
    
    override func setUpWithError() throws {
        useCaseSpy = GetCityListUseCaseSpy()
        bag = DisposeBag()
        sut = SearchViewModel(getCityListUseCase: useCaseSpy)
    }
    
    func testInvokeGetCityList() {
        let expect = XCTestExpectation(description: "Should invoke excute usecase")
        
        sut.output.cityItems.subscribe{ _ in
            if self.useCaseSpy.invokedExcute {
                expect.fulfill()
            } else {
                XCTAssert(false)
            }
        }.disposed(by: bag)
        
        sut.input.getCityListTrigger.onNext(())
        
        wait(for: [expect], timeout: 1)
    }
    
    func testCitiesSorting() {
        
        let expect = XCTestExpectation(description: "Should sorting by alphabetical")
        sut.output.cityItems.subscribe(onNext: { viewModels in
            let names = viewModels.map{ $0.name }
            if names == ["A", "B", "C", "D"] {
                expect.fulfill()
            } else {
                XCTAssert(false)
            }
        }).disposed(by: bag)
        
        sut.input.getCityListTrigger.onNext(())

        wait(for: [expect], timeout: 1)
    }
}
