//
//  GetCityListUseCase.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import RxSwift

protocol GetCityListUseCaseProtocol {
    func excute() -> Observable<[City]>
}

final class GetCityListUseCase: GetCityListUseCaseProtocol {
    
    let network: Networkable
    let appConfig: AppConfigProtocol
    
    init(network: Networkable = Network(), appConfig: AppConfigProtocol = AppConfig.shared) {
        self.network = network
        self.appConfig = appConfig
    }
    
    func excute() -> Observable<[City]> {
        let url = AppConfig.shared.baseURL.appendingPathComponent("SiriusiOS/ios-assignment/main/cities.json")
        let request = URLRequest(url: url)
        return network.request(request)
    }
}
