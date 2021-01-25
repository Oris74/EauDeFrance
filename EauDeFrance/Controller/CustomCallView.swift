//
//  customCallView2.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 24/01/2021.
//

import UIKit

class CustomCallView: UIView {

    var station: StationODF
    let streamLabel = UILabel()
    let countyLabel = UILabel()
//
//    lazy var bpDataStation: CustomButton = {
//        let bpDataStation = CustomButton()
//        bpDataStation.translatesAutoresizingMaskIntoConstraints = false
//        bpDataStation.setImage(UIImage(named: "charts"), for: .normal)
//        return bpDataStation
//    }()
//
//    lazy var contentView: UIImageView = {
//                let contentView = UIImageView()
//                contentView.image = UIImage(named: "WoodTexture")
//                contentView.translatesAutoresizingMaskIntoConstraints = false
//        return contentView
//    }()
//
//    lazy var bodyView: UIStackView = {
//
//        let bodyView = UIStackView(arrangedSubviews: [ stationName,  streamLabel, countyLabel, bpDataStation])
//        bodyView.setCustomSpacing(5, after: stationName)
//        bodyView.axis = .vertical
//
//        bodyView.distribution = .equalCentering
//        bodyView.alignment = .center
//
//        return bodyView
//    }()
//
    lazy var stationID: UILabel = {
        let headerID = UILabel()
        headerID.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        headerID.text = station.stationID
        headerID.textAlignment = .center
        headerID.translatesAutoresizingMaskIntoConstraints = false
        return headerID
    }()

    lazy var stationName: UILabel = {
        let stationName = UILabel()
        stationName.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        stationName.text = station.stationLabel
        stationName.textAlignment = .center
        stationName.translatesAutoresizingMaskIntoConstraints = false
        return stationName
    }()

    lazy var headerTitle: UIStackView = {
        let headerTitle = UIStackView(arrangedSubviews: [stationID,stationName])
       // headerTitle.setCustomSpacing(5, after: stationName)
        headerTitle.axis = .vertical

        headerTitle.distribution = .equalSpacing
        //headerTitle.alignment = .center

        return headerTitle
    }()
//
//    lazy var logoServiceView: UIImageView = {
//
//        let logoService = station.service.logo().resize(height: 30)
//        let logoServiceView = UIImageView(image: logoService)
//
//        logoServiceView.backgroundColor = UIColor(red: 22/255, green: 160/255, blue: 133/255, alpha: 0.5)
//        logoServiceView.layer.shadowColor = UIColor.gray.cgColor
//        logoServiceView.layer.shadowOffset = CGSize(width: 0, height: 10)
//        logoServiceView.layer.shadowOpacity = 1
//        logoServiceView.layer.shadowRadius = 5
//
//        return logoServiceView
//    }()
//
//    lazy var headerView: UIStackView = {
//        let headerView = UIStackView(arrangedSubviews: [ logoServiceView])
//        //headerView.setCustomSpacing(5, after: logoServiceView)
//        headerView.distribution = .fillProportionally
//        headerView.axis = .horizontal
//        headerView.alignment = .center
//
//        return headerView
//    }()

    init(frame: CGRect, station: StationODF){
        self.station = station
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {

        // bpDataStation.setStation(station: station)
        backgroundColor = .white
        //addSubview(bodyView)
        //addSubview(contentView)
        addSubview(headerTitle)
        setupLayout()
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
//            //pin headerTitle to headerView
//            headerTitle.topAnchor.constraint(equalTo: headerView.topAnchor),
//            headerTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
//            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
//            headerTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),

//            //pin headerTitle to headerView
//            headerTitle.topAnchor.constraint(equalTo: headerView.topAnchor),
//            headerTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
//            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
//            headerTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
//            //layout addButton in headerView
//            bpDataStation.centerYAnchor.constraint(equalTo: bodyView.centerYAnchor),
//            bpDataStation.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -10),

//            stationName.topAnchor.constraint(equalTo: topAnchor, constant: -5),
//            stationName.leadingAnchor.constraint(equalTo: headerTitle.leadingAnchor, constant: -5),
//            stationName.trailingAnchor.constraint(equalTo: headerTitle.trailingAnchor, constant: -5),
//            stationName.bottomAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: -5),
            //pin headerView to top
            headerTitle.topAnchor.constraint(equalTo: topAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
           // headerTitle.heightAnchor.constraint(equalToConstant: 60)

//            //layout contentView
//            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
//            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
