//
//  ContactListViewController.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Combine
import UIKit

class ContactListViewController: UIViewController {
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .secondaryColor
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        return label
    }()
    
    enum TableSection: Int {
        case contactList
        case loader
    }
    
    private var viewModel: ContactsViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    init(_ viewModel: ContactsViewModel = ContactsViewModel()) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupView()
        setTableView()
        setErrorLabel()
        setBindings()
    }
    
    @objc func refresh() {
        viewModel.refreshList()
    }
    
    // MARK: - Private functions
    private func setupView() {
        title = "Contact list"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        
        view.backgroundColor = .backgroundColor
        tableView.backgroundColor = .backgroundColor
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            errorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16.0),
            errorLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ContactListViewController {
    private func setTableView() {
        tableView.isHidden = true
        
        tableView.rowHeight = 120
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setErrorLabel() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
    
    private func displayError(error: NetworkError) {
        tableView.isHidden = true
        errorLabel.isHidden = false
        
        errorLabel.text = error.rawValue
    }
    
    private func updateTableView() {
        errorLabel.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    private func setBindings() {
        viewModel.$viewState
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .loading:
                    self.activityIndicator.startAnimating()
                case .error(let error):
                    self.activityIndicator.stopAnimating()
                    self.displayError(error: error)
                case .success(let updated):
                    if updated { self.updateTableView() }
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: UITableViewDataSource
extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .contactList:
            return viewModel.contacts.count
        case .loader:
            return viewModel.contacts.count >= viewModel.userCount ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .contactList:
            guard let contactCell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier) as? ContactTableViewCell else {
                return UITableViewCell()
            }
            contactCell.configure(with: viewModel.contacts[indexPath.row])
            return contactCell
        case .loader:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
            cell.textLabel?.text = "Loading ..."
            cell.textLabel?.font = .boldSystemFont(ofSize: 24)
            cell.textLabel?.textColor = .secondaryColor
            cell.textLabel?.textAlignment = .right
            cell.backgroundColor = .backgroundColor
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !viewModel.contacts.isEmpty else { return }
        
        if section == .loader {
            viewModel.getContacts()
        }
    }
}

// MARK: UITableViewDelegate
extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = ContactDetailViewController(viewModel.contacts[indexPath.row])
        present(detail, animated: true)
    }
}
