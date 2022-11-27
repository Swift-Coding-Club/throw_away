//
//  ProductListViewController.swift
//  ThrowAway
//
//  Created by Sally on 2022/11/04.
//

import UIKit
import SwiftUI
import CoreData

class ProductListViewController: UIViewController {
    
    var viewContext: NSManagedObjectContext?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    private var doneBarBtn = UIBarButtonItem()

    private lazy var productList: [Product] = {
        let request = Product.fetchRequest()
        let sort = NSSortDescriptor(key: "cleaningDay", ascending: false)
        request.sortDescriptors = [sort]
        let result = try? viewContext?.fetch(request)
        infoLabelCount = result?.count ?? 0
        return result ?? []
    }()

    private var infoLabelCount: Int = 0 {
        didSet {
            let info = " 등록된 물건 갯수는 \(infoLabelCount)개 입니다."
            let attributedString = withBoldText(original: info, text: "\(infoLabelCount)개")
            infoLabel.attributedText = attributedString
        }
    }
    
    var isEmpty: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtons()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 103
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    private func setupBarButtons() {
        self.navigationItem.title = "물건 목록"
        doneBarBtn = UIBarButtonItem(title: "확인", style: .done,
                                     target: self, action: #selector(didPressDoneButton))
        
        editButtonItem.title = "비우기"
        self.navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self, action: #selector(addProduct))
    }
    
    func withBoldText(original: String, text: String, font: UIFont? = nil) -> NSAttributedString {
        let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        let fullString = NSMutableAttributedString(string: original, attributes: [NSAttributedString.Key.font: _font])
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
        let range = (original as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
    }
    
    private func handleMoveToTrash(for indexPath: IndexPath) {
        // TODO: remove item from coredata
        productList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    private func handleMoveToEmpty(for indexPath: IndexPath, productName: String) {

        let message = "\(productName)을 비우시겠습니까?"
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "아니오", style: .destructive)
        let yesAction = UIAlertAction(title: "예", style: .default) { _ in
            // delete core data
            DispatchQueue.main.async {
                self.handleMoveToTrash(for: indexPath)
            }
        }
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: false)
        }
    }
    
    @objc func didPressDoneButton() {
        
        guard let selectedRows = self.tableView.indexPathsForSelectedRows else {
            editButtonItem.title = "비우기"
            navigationItem.leftBarButtonItem = editButtonItem
            setEditing(false, animated: false)
            return
        }
        
        for var selectedRow in selectedRows {
            // TODO: delete item from coredata
            while selectedRow.item >= productList.count {
                selectedRow.item -= 1
            }
            tableView(tableView, commit: .delete, forRowAt: selectedRow)
        }
    }
    
    @objc func addProduct() {
        guard let viewContext = viewContext else {
            return
        }
        let addObjectView = UIHostingController(rootView:
                                                    AddObjectView().environment(\.managedObjectContext, viewContext))
        navigationController?.pushViewController(addObjectView, animated: true)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if tableView.isEditing {
            editButtonItem.title = "비우기"
            navigationItem.leftBarButtonItem = editButtonItem
        } else {
            navigationItem.leftBarButtonItem = doneBarBtn
        }
        
        tableView.isEditing = !tableView.isEditing
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell",
                                                       for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.productImageView.layer.cornerRadius = 10
        cell.productImageView.layer.masksToBounds = true
        cell.configure(item: productList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completionHandler) in
            // when delete item, delete data model
            if self?.isEmpty == true {
                self?.handleMoveToTrash(for: indexPath)
            }
            completionHandler(true)
        }
        
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let emptyAction = UIContextualAction(style: .normal, title: "비움") { [weak self] (_, _, completionHandler) in
            
            guard let cell = self?.tableView.cellForRow(at: indexPath) as? ProductTableViewCell else {
                return
            }
            
            let productName = cell.productName
            self?.handleMoveToEmpty(for: indexPath, productName: productName)
            completionHandler(true)
        }
        
        emptyAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [emptyAction])
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if tableView.isEditing {
            return true
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // TODO: delete item from coredata
            productList.remove(at: indexPath.item)
            tableView.reloadData()
        }
    }
}
