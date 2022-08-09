//
//  ProfileView.swift
//  lydia
//
//  Created by Noeline PAGESY on 05/08/2022.
//

import Combine
import UIKit

//public final class ImageLoader {
//    public static let shared = ImageLoader()
//    
//    private let cache: ImageCa
//}

//protocol ProfileViewProtocol {
//    func setContact(_ contact: Contact)
//}

class ProfileView: UIStackView {

    private var avatar: UIImageView!
    private var userName: UILabel!
    private var age: UILabel!
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
    
    func configure(with contact: Contact, axis: NSLayoutConstraint.Axis = .horizontal) {
        self.axis = axis
        userName.text = contact.loginInformations.username
        age.text = contact.loginInformations.registeredAge.description
        cancellable = loadImage(for: contact).sink { [weak self] image in
            self?.showImage(image: image)
        }
    }
}

extension ProfileView {
    private func setupUI() {
        axis = .horizontal
        alignment = .leading
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
        userName.lineBreakMode = .byWordWrapping
        
        age = UILabel()
        age.font = .systemFont(ofSize: 14)
        age.numberOfLines = 1
        age.lineBreakMode = .byTruncatingTail
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubview(userName)
        stackView.addArrangedSubview(age)
        
        addArrangedSubview(stackView)
    }
    
    private func loadImage(for contact: Contact) -> AnyPublisher<UIImage?, Never> {
        Just(contact.loginInformations.pictures.first)
            .flatMap { image -> AnyPublisher<UIImage?, Never> in
                let url = URL(string: contact.loginInformations.pictures.first!)!
                return ImageLoader.shared.loadImage(from: url)
            }
            .eraseToAnyPublisher()
    }
    
    private func showImage(image: UIImage?) {
        avatar.image = image ?? Asset.male
    }
}
