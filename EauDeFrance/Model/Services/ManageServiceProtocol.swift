//
//  ManageServiceProtocol.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 02/02/2021.
//

import Foundation

// MARK: Make  of EauDeFrance - Map or List / Piezometry or Temperature
protocol ManageService:AnyObject {

    var serviceName: String { get }
    var apiName: String { get }
    
    func getStation(parameters: [[KeyRequest:String]], callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void)
    
    func getFigure(stationCode: String, callback: @escaping ([Measure], Utilities.ManageError? ) -> Void)
    
}
