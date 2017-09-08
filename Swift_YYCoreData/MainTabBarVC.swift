//
//  MainTabBarVC.swift
//  BanTanApp
//
//  Created by Jeson on 29/06/2017.
//  Copyright © 2017 Jeson. All rights reserved.
//

import UIKit

enum TabbarHideStyle {
    //    有动画
    case tabbarHideWithAnimation
    //    无动画
    case tabbarHideWithNoAnimation
}

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabBar (){
        let homeVC: HomeViewController = HomeViewController()
        let nearVC: NearViewController = NearViewController()
        let orderVC: OrderViewController = OrderViewController()
        let myVC: MyViewController = MyViewController()
        self.setChildVC(homeVC, tabTitle: "团购", navTitle: "团购T.T", imageName: "tab_Home_normal", selectedImageName: "tab_Home_selected", isAnimation: .tabbarHideWithAnimation)
        self.setChildVC(nearVC, tabTitle: "附近", navTitle: "附近T.T", imageName: "tab_Order_normal", selectedImageName: "tab_Order_selected", isAnimation: .tabbarHideWithAnimation)
        self.setChildVC(orderVC, tabTitle: "订单", navTitle: "订单T.T", imageName: "tab_Near_normal", selectedImageName: "tab_Near_selected", isAnimation: .tabbarHideWithAnimation)
        self.setChildVC(myVC, tabTitle: "我的", navTitle: "我的T.T", imageName: "tab_mine_normal", selectedImageName: "tab_mine_selected", isAnimation: .tabbarHideWithAnimation)
    }

    func setChildVC(_ childVC:UIViewController, tabTitle: String, navTitle: String, imageName: String, selectedImageName: String, isAnimation: TabbarHideStyle) {
        childVC.title = tabTitle
        childVC.navigationItem.title = navTitle
        childVC.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage.init(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        let navController = UINavigationController.init(rootViewController: childVC)
        self.addChildViewController(navController)
    }
}
