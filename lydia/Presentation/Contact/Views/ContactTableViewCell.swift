//
//  ContactTableViewCell.swift
//  lydia
//
//  Created by Noeline PAGESY on 08/08/2022.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static let identifier = "ContactTableViewCell"
    
    var profilView = ProfileView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .backgroundColor
        
        profilView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profilView)
        
        NSLayoutConstraint.activate([
            profilView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            profilView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16.0),
            profilView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            profilView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with contact: Contact) {
        profilView.configure(with: contact)
    }
}
