//
//  InformationsView.swift
//  lydia
//
//  Created by Noeline PAGESY on 05/08/2022.
//

import UIKit
import MapKit

class InformationsView: UIStackView {

    private var informationStackView: UIStackView!
    private var name: InfoDetailStackView!
    private var phone: InfoDetailStackView!
    private var cellPhone: InfoDetailStackView!
    private var email: InfoDetailStackView!
    
    private var mapView: MKMapView!
    
    private var contactDetails: Details?
    private var gender: Gender?
    private var identity: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    init(with contactDetails: Details, identity: String, gender: Gender?) {
        super.init(frame: .zero)
        self.contactDetails = contactDetails
        self.identity = identity
        self.gender = gender
        setupUI()
    }
}

// MARK: - Private method
private extension InformationsView {
    func setupUI() {
        backgroundColor = .backgroundColor
        layer.cornerRadius = 15.0
        
        axis = .vertical
        spacing = 16
        alignment = .leading
        
        informationStackView = UIStackView()
        informationStackView.axis = .vertical
        informationStackView.spacing = 8
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(informationStackView)
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0)
        ])
    
        name = InfoDetailStackView(.identity, infoString: identity, gender: gender)
        email = InfoDetailStackView(.email, infoString: contactDetails?.email)
        phone = InfoDetailStackView(.phone, infoString: contactDetails?.phone)
        cellPhone = InfoDetailStackView(.cellPhone, infoString: contactDetails?.cellPhone)
        
        informationStackView.addArrangedSubview(name)
        informationStackView.addArrangedSubview(email)
        informationStackView.addArrangedSubview(phone)
        informationStackView.addArrangedSubview(cellPhone)
        
        if let address = contactDetails?.address {
            mapView = MapView(with: address)
            mapView.translatesAutoresizingMaskIntoConstraints = false
            
            addArrangedSubview(mapView)
            NSLayoutConstraint.activate([
                mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
                mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
            ])
        }
       
    }
}
