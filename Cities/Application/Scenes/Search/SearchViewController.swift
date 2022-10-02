//
//  SearchViewController.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import Foundation
import UIKit
import RxSwift

class SearchDisplayBaseViewController: UITableViewController {
    var items: [CityViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier, for: indexPath) as? CityTableViewCell
        cell?.configure(viewModel: items[indexPath.row])
        return cell ?? CityTableViewCell()
    }
}

final class SearchViewController: SearchDisplayBaseViewController {
    
    var searchController: UISearchController!
    var viewModel: SearchViewModelType = SearchViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        title = "City List"
        let searchResultsController = SearchResultViewController()
        searchResultsController.onSelectResult = { [weak self] city in
            self?.showCityMapView(city: city)
        }
        searchController = UISearchController(searchResultsController: searchResultsController)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        bindViewModel()
        getCitiyList()
    }
    
    func getCitiyList() {
        viewModel.input.getCityListTrigger.onNext(())
    }
    
    func bindViewModel() {
        viewModel.output.cityItems
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] items in
                self?.items = items
                self?.tableView.reloadData()
            } onError: { error in
                debugPrint(error)
            }.disposed(by: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = items[indexPath.row]
        showCityMapView(city: viewModel)
    }
    
    func showCityMapView(city: CityViewModel) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        else {
            fatalError("Incorrect viewcontroller ID")
        }
        vc.city = city
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultVC = searchController.searchResultsController as? SearchResultViewController,
              let text = searchController.searchBar.text, !text.isEmpty else {
                  return
              }
        let result = items.binarySearchFilter(key: .make(searchText: text))
        resultVC.update(result: result)
    }
    
}

final class SearchResultViewController: SearchDisplayBaseViewController {
    
    var onSelectResult: (CityViewModel) -> Void = { _ in }
    
    func update(result: [CityViewModel]) {
        items = result
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelectResult(items[indexPath.row])
    }
}
