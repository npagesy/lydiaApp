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
    private var name: UILabel!
    private var phone: UILabel!
    private var cellPhone: UILabel!
    private var email: UILabel!
    
    private var mapView: MKMapView!
    
    private var contactDetails: Details?
    private var identity: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    init(with contactDetails: Details, identity: String) {
        super.init(frame: .zero)
        self.contactDetails = contactDetails
        self.identity = identity
        setupUI()
    }
}

extension InformationsView {
    private func setupUI() {
        backgroundColor = .backgroundColor
        layer.cornerRadius = 15.0
        
        axis = .vertical
        spacing = 16
        
        informationStackView = UIStackView()
        informationStackView.axis = .vertical
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(informationStackView)
        
        name = UILabel()
        name.text = identity
        
        phone = UILabel()
        phone.text = contactDetails?.phone
        
        cellPhone = UILabel()
        cellPhone.text = contactDetails?.cellPhone
        
        email = UILabel()
        email.text = contactDetails?.email
        
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
