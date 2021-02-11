//
//  ListStationTableViewCell.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/01/2021.
//

import UIKit

class ListStationTableViewCell: UITableViewCell {
    //weak var cellDelegate: PassDataToVC?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleStation: UILabel!
    @IBOutlet weak var detailStation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
