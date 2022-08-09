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
        activityIndicator.color = .textColor
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private var tableView: ContactTableView!
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.textColor = .secondaryColor
        return label
    }()
    
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
    
        setTableView()
        setErrorLabel()
        
        setupUI()
        setBindings()
    }
    
    @objc func refresh() {
        viewModel.refreshList()
    }
}

// MARK: - Private functions
private extension ContactListViewController {
    private func setTableView() {
        tableView = ContactTableView(viewModel, parent: self)
        tableView.isHidden = true
    }

    private func setErrorLabel() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
    
    private func setupUI() {
        title = "Contact list"
        view.backgroundColor = .backgroundColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refresh))
        navigationItem.rightBarButtonItem?.tintColor = .actionColor
        
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
}
