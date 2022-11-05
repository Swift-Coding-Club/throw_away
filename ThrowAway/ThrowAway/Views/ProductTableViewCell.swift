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
    
    // update product image and name
    func configure(imgPath: String) {
        
  
        let name = URL(fileURLWithPath: imgPath).deletingPathExtension().lastPathComponent

        productNameLabel.text = getProductName(with: name)
        
        if let randomDate = generateRandomDate() {
            createdDateLabel.text = dateFormatter("yyyy.MM.dd").string(from: randomDate)
        }
        
        productImageView.image = UIImage(contentsOfFile: imgPath)
    }
    
    func getProductName(with name: String) -> String {
        
        switch name {
        case "clearpad":
            return "이즈앤트리 어니언 뉴페어 클리어패드"
        case "showerTowel":
            return "뱀부 샤워타올"
        case "lipstick":
            return "에르메스 루즈 새틴 립스틱"
        case "shoes":
            return "닥터마틴 3홀 모노블랙"
        case "powder":
            return "아멜리 베이크드 파우더"
        default:
            return ""
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
    
//    
//    func showImageFromBundle() {
//        guard let bundle = Bundle.currentBundle else { return }
//        let paths = bundle.paths(forResourcesOfType: "png", inDirectory: nil)
//
//
//    }
}
