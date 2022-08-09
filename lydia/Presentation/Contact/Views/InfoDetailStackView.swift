//
//  InfoDetailStackView.swift
//  lydia
//
//  Created by Noeline PAGESY on 09/08/2022.
//

import UIKit

class InfoDetailStackView: UIStackView {

    enum InfoType: String {
        case cellPhone
        case email
        case identity
        case phone
    }
    
    private var iconView: UIImageView!
    private var labelView: UILabel!
    
    private var infoType: InfoType!
    private var infoString: String?
    private var gender: Gender?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    init(_ infoType: InfoType, infoString: String?, gender: Gender? = nil) {
        super.init(frame: .zero)
        self.infoType = infoType
        self.infoString = infoString
        self.gender = gender
        setupUI()
    }
    
    private func setupUI() {
        axis = .horizontal
        spacing = 16
        
        switch infoType {
        case .cellPhone, .phone:
            iconView = UIImageView(image: Asset.phone)
        case .email:
            iconView = UIImageView(image: Asset.mail)
        case .identity:
            iconView = gender == .female ? UIImageView(image: Asset.female) : UIImageView(image: Asset.male)
        case .none: break
        }
        addArrangedSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.heightAnchor.constraint(equalToConstant: 40.0),
            iconView.widthAnchor.constraint(equalToConstant: 40.0)
        ])
        
        labelView = UILabel()
        labelView.font = .boldSystemFont(ofSize: 14)
        labelView.numberOfLines = 0
        labelView.textColor = .textColor
        labelView.lineBreakMode = .byWordWrapping
        
        labelView.text = infoString
        
        
        addArrangedSubview(labelView)
    }
}
