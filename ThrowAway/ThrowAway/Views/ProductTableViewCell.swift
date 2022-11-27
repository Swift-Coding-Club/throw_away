//
//  ProductTableViewCell.swift
//  ThrowAway
//
//  Created by Sally on 2022/11/04.
//

import UIKit

protocol ProductTableViewCellDelegate: AnyObject {
    func didSelect(item: Product)
}

class ProductTableViewCell: UITableViewCell {
    private var product: Product?
    weak var delegate: ProductTableViewCellDelegate?
    var productName: String {
        return product?.title ?? ""
    }
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchedView))
        self.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc private func touchedView() {
        guard let selectedProduct = product else { return }
        delegate?.didSelect(item: selectedProduct)
    }
    
    func configure(item: Product) {
        self.product = item
        
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
