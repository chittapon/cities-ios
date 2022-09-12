//
//  GetCityListUseCaseSpy.swift
//  CitiesTests
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import RxSwift
@testable import Cities

final class GetCityListUseCaseSpy: GetCityListUseCaseProtocol {

    var invokedExcute = false
    var invokedExcuteCount = 0
    var stubbedExcuteResult: Observable<[City]>!

    func excute() -> Observable<[City]> {
        invokedExcute = true
        invokedExcuteCount += 1
        return .just(mockCities())
    }
    
    func mockCities() -> [City] {
        return [
            City(country: "C", name: "C", id: 3, coordinate: .init(lat: 1, lon: 2)),
            City(country: "A", name: "A", id: 1, coordinate: .init(lat: 1, lon: 2)),
            City(country: "D", name: "D", id: 4, coordinate: .init(lat: 1, lon: 2)),
            City(country: "B", name: "B", id: 2, coordinate: .init(lat: 1, lon: 2))
        ]
    }
}
