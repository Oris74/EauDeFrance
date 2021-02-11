//
//  FigureService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 26/01/2021.
//

import Foundation
class FigureService {

    static let shared = FigureService()

    private var networkService: NetworkProtocol

    var stationService = StationService.shared

    private init() {
        self.networkService = NetworkService.shared
    }

    init(networkService: NetworkService ) {
        self.networkService =  networkService
    }
}
