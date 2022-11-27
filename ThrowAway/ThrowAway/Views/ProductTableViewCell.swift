//
//  ProductTableViewCell.swift
//  ThrowAway
//
//  Created by Sally on 2022/11/04.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
    var productName: String {
        return productNameLabel.text ?? ""
    }
    
    private let dateFormatter: ((String) -> DateFormatter) = { format in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(item: Product) {
        productNameLabel.text = item.title
        if let cleaningDay = item.cleaningDay {
            createdDateLabel.text = dateFormatter("yyyy.MM.dd").string(from: cleaningDay)
        }
        if let photo = item.photo {
            productImageView.image = UIImage(data: photo)
        }
    }
    
    func generateRandomDate() -> Date? {
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
       
        guard let days = calendar.range(of: .day, in: .month, for: date),
              let randomDay = days.randomElement() else { return nil }
        dateComponents.setValue(randomDay, for: .day)
        return calendar.date(from: dateComponents)
    }
    
}
