//
//  ManageServiceProtocol.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 02/02/2021.
//

import Foundation

protocol ManageService:AnyObject {

    var stationURL: URL { get }
    var figureURL: URL { get }
    var serviceName: String { get }
    var apiName: String { get }

    func getStation(parameters: [[KeyRequest:String]], callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void)

    func getFigure(codeStation: String, callback: @escaping ([Any]?, ManageODFapi?, Utilities.ManageError? ) -> Void)
    
}


