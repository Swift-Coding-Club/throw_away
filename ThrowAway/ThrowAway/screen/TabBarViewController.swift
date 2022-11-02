//
//  TabBarViewController.swift
//  ThrowAway
//
//  Created by Sally on 2022/11/02.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupVCs()
        updateTabBarAppearance()

    }
    
    func setupVCs() {
        
        viewControllers = [
            createNavController(for: UIViewController(), title:"홈", imageName: "ic_folder"),
            createNavController(for: UIViewController(), title: "통계", imageName: "ic_graph"),
            createNavController(for: UIViewController(), title: "설정", imageName: "ic_settings")
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title

        let unselectedImageName = imageName + "_grey"
        let unselectedImage = UIImage(named: unselectedImageName)!
        navController.tabBarItem.image = unselectedImage.withRenderingMode(.alwaysOriginal) // deselect image
        let selectedImage = UIImage(named: imageName)!
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal) // select image
        rootViewController.navigationItem.title = title
        
        return navController
    }

    private var minimumTabBarHeight: CGFloat = 65.0
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
         
        if tabBar.frame.size.height < 60 {
            tabBar.frame.size.height = minimumTabBarHeight
            tabBar.frame.origin.y = view.frame.height - minimumTabBarHeight
            
            tabBar.items?.forEach({
                $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
                $0.imageInsets = UIEdgeInsets.init(top: -4, left: 0, bottom: 4, right: 0)
            })
        }
        
        debugPrint(tabBar.frame.width, tabBar.frame.height)
    }
    
    func updateTabBarAppearance() {
    
        let selectedItemTextColor = UIColor.black
        let unselectedItemTextColor = UIColor(red: 214/255, green: 216/255, blue: 224/255, alpha: 1.0)
                                                                                                        
        if #available(iOS 15, *) {
           let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white
           tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedItemTextColor]
           tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: unselectedItemTextColor]
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
            
        } else {
           UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: selectedItemTextColor],
                                                            for: .selected)
           UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: unselectedItemTextColor],                                                 for: .normal)
           tabBar.barTintColor = .white
         }
    }

}
