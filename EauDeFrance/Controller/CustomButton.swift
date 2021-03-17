//
//  CustomButton.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 23/01/2021.
//

import UIKit

class CustomButton: UIButton {
    private var station: StationODF?
    private var lisa: [String:URL] = [:]
    private var sandre: [String:URL] = [:]
    
    /// MARK: refresh button Layout to move title below and center its image
    override func layoutSubviews() {
        super.layoutSubviews()
        centerVertically()
    }
    
    func setStationToBp(station: StationODF?) {
        self.station = station
    }
    
    func getStationFromBp() -> StationODF? {
        return station
    }
    
    func setResourceToBp(data: [String:URL], resource: Resource) {
        
        switch resource {
        case .sandre:
            sandre.update(other: data)
        case .lisa:
            lisa.update(other: data)
        }
    }
    
    func getResourceFromBp( resource: Resource) -> [String:URL] {
        switch resource {
        case .sandre:
            return  sandre
        case .lisa:
            return lisa
        }
    }
}

extension Dictionary {
    /// MARK:  Merge of 2 dictionaries
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
