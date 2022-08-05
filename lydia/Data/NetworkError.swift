//
//  NetworkError.swift
//  lydia
//
//  Created by Noeline PAGESY on 04/08/2022.
//

import Foundation

enum NetworkError: String, Error {
    case decodeError = "Erreur au decodage des données"
    case failed = "Une erreur est survenue"
    case invalidURL = "Erreur: URL invalide"
    case networkError = "Erreur réseau"
    case notFound = "Erreur 404"
}
