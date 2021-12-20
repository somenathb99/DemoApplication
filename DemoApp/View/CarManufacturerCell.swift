//
//  ManufacturerCell.swift
//  DemoApp
//
//  Created by Somenath Banerjee on 09/10/21.
//

import UIKit

class CarManufacturerCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    static var identifier: String{
        return String(describing: self)
    }
    
    static var height: CGFloat{
        return 100
    }
    
    var manufacturer: Manufacturer? {
        didSet{
            guard let manufacturer = manufacturer else {
                return
            }
            label.text = manufacturer.manufacturer
        }
    }
    
    var car: Car? {
        didSet{
            guard let car = car else {
                return
            }
            label.text = car.carModel
        }
    }
    
    var indexPath: IndexPath? {
        didSet{
            bgView.backgroundColor = getColorForIndexPath(indexPath: indexPath)
        }
    }
    
    func getColorForIndexPath(indexPath: IndexPath?) -> UIColor?{
        guard let indexPath = indexPath else{return .black}
        if indexPath.row % 2 == 0 {
            return UIColor(named: ColorPalate.manufacturerListEvenRow.rawValue)
        }else {
            return UIColor(named: ColorPalate.manufacturerListOddRow.rawValue)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
