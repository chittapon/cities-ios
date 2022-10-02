//
//  SearchViewControllerTests.swift
//  CitiesTests
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import UIKit
import XCTest
@testable import Cities

final class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    
    var searchResultVC: SearchResultViewController!
    var searchController: UISearchController!
    
    override func setUpWithError() throws {
        searchResultVC = SearchResultViewController()
        searchController = UISearchController(searchResultsController: searchResultVC)
        searchController.searchResultsUpdater = sut
        sut = SearchViewController()
        sut.searchController = searchController
        sut.items = mockCities()
    }
    
    func testValidSearch() {
        sut.searchController.searchBar.text = "A"
        
        sut.updateSearchResults(for: searchController)
        
        let names = searchResultVC.items.map{ $0.name }
        XCTAssert(names == ["A"])
    }
    
    func testInvalidSearch() {
        sut.searchController.searchBar.text = "#"
        
        sut.updateSearchResults(for: searchController)
        
        let names = searchResultVC.items.map{ $0.name }
        XCTAssert(names.isEmpty)
    }
    
    func mockCities() -> [CityViewModel] {
        return [
            City(country: "C", name: "C", id: 3, coordinate: .init(lat: 1, lon: 2)),
            City(country: "A", name: "A", id: 1, coordinate: .init(lat: 1, lon: 2)),
            City(country: "D", name: "D", id: 4, coordinate: .init(lat: 1, lon: 2)),
            City(country: "B", name: "B", id: 2, coordinate: .init(lat: 1, lon: 2))
        ].map(CityViewModel.init).sorted()
    }
}
