//
//  SearchViewModel.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import RxSwift
import Foundation

protocol SearchViewModelType {
    var input: SearchViewModelInput { get }
    var output: SearchViewModelOutput { get }
}

protocol SearchViewModelInput {
    var getCityListTrigger: PublishSubject<Void> { get }
}

protocol SearchViewModelOutput {
    var cityItems: Observable<[CityViewModel]> { get }
}

final class SearchViewModel: SearchViewModelInput, SearchViewModelOutput {
    
    // MARK: - Inputs
    let getCityListTrigger: PublishSubject<Void> = .init()
    
    // MARK: - Outputs
    var cityItems: Observable<[CityViewModel]> = .empty()
    
    init(getCityListUseCase: GetCityListUseCaseProtocol = GetCityListUseCase()) {
        cityItems = getCityListTrigger
            .flatMap({ getCityListUseCase.excute() })
            .map({ cities in
                return cities.sorted { $0.name < $1.name }.map(CityViewModel.init)
            })
    }
}

extension SearchViewModel: SearchViewModelType {
    var input: SearchViewModelInput { self }
    var output: SearchViewModelOutput { self }
}
