//
//  ManageServiceProtocol.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 02/02/2021.
//

import Foundation

protocol ManageService:AnyObject {
    
    var stationURL: URL { get }
    var apiFigureURL: URL { get }
    var serviceName: String { get }
    func getStations<T>(codeDept: String, callback: @escaping ([T]?, Utilities.ManageError? ) -> Void)
}
