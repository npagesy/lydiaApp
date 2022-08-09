//
//  ContactTableView.swift
//  lydia
//
//  Created by Noeline PAGESY on 09/08/2022.
//

import UIKit

class ContactTableView: UITableView {
    
    private let rowHeightSize = 120.0
    
    private enum TableSection: Int, CaseIterable {
        case contactList
        case loader
    }
    
    private var viewModel: ContactsViewModel?
    private var parent: UIViewController?
    
    init(_ viewModel: ContactsViewModel, parent: UIViewController) {
        super.init(frame: .zero, style: .plain)
        self.viewModel = viewModel
        self.parent = parent
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}

// MARK: - Private method
private extension ContactTableView {
    func setupUI() {
        backgroundColor = .clear
        
        separatorStyle = .none
        
        delegate = self
        dataSource = self
        
        rowHeight = rowHeightSize
        register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
    }
}

extension ContactTableView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { TableSection.allCases.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .contactList:
            return viewModel?.contacts.count ?? 0
        case .loader:
            guard let viewModel = viewModel else { return 0 }
            return viewModel.contacts.count >= viewModel.userCount ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .contactList:
            guard let contactCell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier,
                                                                  for: indexPath) as? ContactTableViewCell,
                  let contact = viewModel?.contacts[indexPath.row]
            else {
                return UITableViewCell()
            }
            contactCell.configure(with: contact)
            return contactCell
        case .loader:
            return LoadingTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard let noContacts = viewModel?.contacts.isEmpty, !noContacts else { return }
        
        if section == .loader {
            viewModel?.getContacts()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contact = viewModel?.contacts[indexPath.row] else {
            return
        }
        let detail = ContactDetailViewController(contact)
        parent?.present(detail, animated: true)
    }
}
