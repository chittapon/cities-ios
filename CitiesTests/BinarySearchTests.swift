//
//  BinarySearchTests.swift
//  CitiesTests
//
//  Created by Chittapon Thongchim on 2/10/2565 BE.
//

import XCTest
@testable import Cities

final class BinarySearchTests: XCTestCase {
    
    func testBinarySearch() {
        let items = mockStrings()
        
        let result1 = items.binarySearch(key: "hello")
        let result2 = items.binarySearch(key: "New")
        let result3 = items.binarySearch(key: "New zealand")
        
        XCTAssert(result1 == 3)
        XCTAssert(result2 == nil)
        XCTAssert(result3 == 1)
    }
    
    func testBinarySearchFilter() {
        let items = mockStrings()
        
        let result1 = items.binarySearchFilter(key: "New")
        let result2 = items.binarySearchFilter(key: "News paper")
        let result3 = items.binarySearchFilter(key: "Hello")
        
        XCTAssert(result1.isEmpty)
        XCTAssert(!result2.isEmpty)
        XCTAssert(result3.isEmpty)
    }
    
    func testBinarySearchFilterWithCityViewModel() {
        let items = mockCities()
        
        let key1 = CityViewModel.make(searchText: "A")
        let result1 = items.binarySearchFilter(key: key1).map{ $0.name }
        
        let key2 = CityViewModel.make(searchText: "s")
        let result2 = items.binarySearchFilter(key: key2).map{ $0.name }
        
        let key3 = CityViewModel.make(searchText: "Al")
        let result3 = items.binarySearchFilter(key: key3).map{ $0.name }
        
        
        XCTAssert(result1 == ["Alabama", "Albuquerque", "Anaheim", "Arizona"])
        XCTAssert(result2 == ["Sydney"])
        XCTAssert(result3 == ["Alabama", "Albuquerque"])
    }
    
    func mockStrings() -> [String] {
        return ["New Deli", "New zealand", "News paper", "hello", "world"].sorted()
    }
    
    func mockCities() -> [CityViewModel] {
        return [
            City(country: "", name: "Alabama", id: 3, coordinate: .init(lat: 1, lon: 2)),
            City(country: "", name: "Albuquerque", id: 1, coordinate: .init(lat: 1, lon: 2)),
            City(country: "", name: "Anaheim", id: 4, coordinate: .init(lat: 1, lon: 2)),
            City(country: "", name: "Arizona", id: 2, coordinate: .init(lat: 1, lon: 2)),
            City(country: "", name: "Sydney", id: 2, coordinate: .init(lat: 1, lon: 2))
        ].map(CityViewModel.init).sorted()
    }
}
