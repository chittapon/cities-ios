//
//  CityTableViewCell.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import UIKit

final class CityTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CityTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CityViewModel) {
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.subtitle
    }

}
