//
//  ProfileView.swift
//  lydia
//
//  Created by Noeline PAGESY on 05/08/2022.
//

import Combine
import UIKit

class ProfileView: UIStackView {

    private var avatar: UIImageView!
    private var userName: UILabel!
    private var stackView: UIStackView!
    
    private var cancellable: AnyCancellable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    func configure(with contact: Contact,
                   userNameTextAlignment: NSTextAlignment = .left,
                   axis: NSLayoutConstraint.Axis = .horizontal) {
        self.axis = axis
        userName.text = "\(contact.loginInformations.username), \(contact.age.description) ans"
        userName.textAlignment = userNameTextAlignment
        if userNameTextAlignment == .center {
            userName.textColor = .darkTextColor
        }
        cancellable = loadImage(for: contact).sink { [weak self] image in
            self?.showImage(image: image)
        }
    }
}

// MARK: - Private function
private extension ProfileView {
    func setupUI() {
        axis = .horizontal
        alignment = .center
        spacing = 16
        
        avatar = UIImageView()
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.layer.borderWidth = 5
        avatar.layer.borderColor = UIColor.secondaryColor.cgColor
        avatar.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.heightAnchor.constraint(equalToConstant: 100.0),
            avatar.widthAnchor.constraint(equalToConstant: 100.0),
            
        ])
        
        userName = UILabel()
        userName.font = .boldSystemFont(ofSize: 14)
        userName.numberOfLines = 0
        userName.textColor = .textColor
        userName.lineBreakMode = .byWordWrapping
        addArrangedSubview(userName)

        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.addArrangedSubview(userName)

        addArrangedSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
        ])
    }
    
    private func loadImage(for contact: Contact) -> AnyPublisher<UIImage?, Never> {
        Just(contact.loginInformations.picture)
            .flatMap { image -> AnyPublisher<UIImage?, Never> in
                guard let url = URL(string: contact.loginInformations.picture) else { return Just(Asset.about).eraseToAnyPublisher() }
                return ImageLoader.shared.loadImage(from: url)
            }
            .eraseToAnyPublisher()
    }
    
    private func showImage(image: UIImage?) {
        avatar.image = image ?? Asset.male
    }
}
