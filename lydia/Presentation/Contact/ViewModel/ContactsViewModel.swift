//
//  ContactListViewModel.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Combine
import Foundation

enum ViewState {
    case success(Bool)
    case error(NetworkError)
    case loading
}

final class ContactsViewModel: ObservableObject {
    
    @Published var viewState: ViewState = .loading
    @Published var contacts: [Contact] = []
    var updateContacts = PassthroughSubject<Bool, NetworkError>()
    
    var userCount = 10
    private var page = 1
    
    private let webService: ServiceProviderProtocol
    private var subscription = Set<AnyCancellable>()
    private let mapper: ContactMapperProtocol
    
    init(webService: ServiceProviderProtocol = UserServiceProvider(),
        mapper: ContactMapperProtocol = ContactMapper()) {
        self.webService = webService
        self.mapper = mapper
        getContacts()
    }
    
    func getContacts() {
        viewState = .loading
        webService.users.getUsers(count: userCount, page: page)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .failure(let error):
                        print(error.rawValue)
                        self.viewState = .error(error)
                    case .finished: break
                    }
                },
                receiveValue: { [weak self] users in
                    guard let self = self,
                          users.results.count > 0
                    else {
                        self?.viewState = .success(false)
                        return
                    }
                    
                    self.contacts.append(contentsOf: self.mapper.transformUsersToContacts(users.results))
                    self.page += 1
                    self.viewState = .success(true)
                }
            )
            .store(in: &subscription)
    }
    
    func refreshList() {
        contacts = []
        page = 1
        getContacts()
    }
}
