//
//  Network.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import RxSwift

struct Response {
    let data: Data
    let httpResponse: HTTPURLResponse
}

protocol Networkable {
    typealias Completion = (Result<Response, Error>) -> Void
    func request(_ request: URLRequest, completion: @escaping Completion) -> URLSessionDataTask
    func request(_ request: URLRequest) -> Observable<Response>
    func request<T: Decodable>(_ request: URLRequest) -> Observable<T>
}

final class Network: Networkable {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request(_ request: URLRequest, completion: @escaping Completion) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let httpResponse = urlResponse as? HTTPURLResponse {
                completion(.success(.init(data: data, httpResponse: httpResponse)))
            }
        }
        task.resume()
        return task
    }
    
    func request(_ request: URLRequest) -> Observable<Response> {
        return Observable.create { observer in
            let task = self.request(request) { result in
                switch result {
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func request<T>(_ request: URLRequest) -> Observable<T> where T : Decodable {
        let response: Observable<Response> = self.request(request)
        return response.map { try JSONDecoder().decode(T.self, from: $0.data) }
    }
}
