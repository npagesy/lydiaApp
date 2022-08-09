//
//  LoadingTableViewCell.swift
//  lydia
//
//  Created by Noeline PAGESY on 09/08/2022.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Private method
private extension LoadingTableViewCell {
    func setupUI() {
        backgroundColor = .clear
        textLabel?.text = "Loading ..."
        textLabel?.font = .boldSystemFont(ofSize: 24)
        textLabel?.textColor = .actionColor
        textLabel?.textAlignment = .center
    }
}
