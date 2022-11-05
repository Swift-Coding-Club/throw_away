//
//  ProductListViewController.swift
//  ThrowAway
//
//  Created by Sally on 2022/11/04.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var imagePaths: [String] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    private func setUp() {

        self.navigationItem.title = "물건 목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self, action: #selector(addProduct))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 103
        tableView.delegate = self
        tableView.dataSource = self
        imagePaths =  Bundle.getFilePathsFromBundle(bundleName: "resource", folderName: "images", fileType: "png")
        
        let info = " 등록된 물건 갯수는 \(imagePaths.count)개 입니다."
        let attributedString = withBoldText(original: info, text: "\(imagePaths.count)개")
        infoLabel.attributedText = attributedString
    }
    

    func withBoldText(original: String, text: String, font: UIFont? = nil) -> NSAttributedString {
      let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
      let fullString = NSMutableAttributedString(string: original, attributes: [NSAttributedString.Key.font: _font])
      let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
      let range = (original as NSString).range(of: text)
      fullString.addAttributes(boldFontAttribute, range: range)
      return fullString
    }
    
    @objc func addProduct() {
       
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagePaths.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell",
                                                       for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.productImageView.layer.cornerRadius = 10
        cell.productImageView.layer.masksToBounds = true
        cell.configure(imgPath: imagePaths[indexPath.row])
        
        return cell
    }
}
