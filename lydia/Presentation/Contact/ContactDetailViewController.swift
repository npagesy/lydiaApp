//
//  ContactDetailViewController.swift
//  lydia
//
//  Created by Noeline PAGESY on 05/08/2022.
//

import MapKit
import UIKit

class ContactDetailViewController: UIViewController {
    
    private var contact: Contact?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryColor
        setupUI()
    }
    
    init(_ contact: Contact) {
        super.init(nibName: nil, bundle: nil)
        self.contact = contact
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private methods
extension ContactDetailViewController {
    private func setupUI() {
        guard let contact = contact else { return }
        
        let profileView = ProfileView()
        profileView.configure(with: contact, axis: .vertical)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
        
        let informations = InformationsView(with: contact.contactDetails, identity: contact.getidentity())
        informations.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(informations)
        
        NSLayoutConstraint.activate([
            informations.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 32.0),
            informations.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            informations.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            informations.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
