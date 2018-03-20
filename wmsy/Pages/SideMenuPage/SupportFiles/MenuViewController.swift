//
//  MenuViewController.swift
//  wmsy
//
//  Created by C4Q on 3/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
//import MaterialComponents.MaterialCollections

private let reuseIdentifier = "Cell"

//enum Page: Int {
//    case login
//    case create
//    case home
//    case decks
//    case progress
//    case browse
//    case profile
//    case inbox
//}

class MenuViewController: UIViewController {
    @IBAction func closeMenu(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    var closeButton = UIButton()
    //    var tabButton = UIButton()
    weak var fromVC: UIViewController? {
        didSet {
            print(0)
        }
    }
    var signOutButton = UIButton()
    
    // the menu objects should be added to menuScreen not self.view
    var menuScreen = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuRegion()
        setupCloseMenuRegion()
    }
    
    private func setupMenuRegion() {
        view.addSubview(menuScreen)
        menuScreen.backgroundColor = .red
        menuScreen.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(view)
            make.width.equalTo(view).multipliedBy(MenuHelper.menuWidth)
        }
    }
    private func setupCloseMenuRegion() {
        let panGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(handleClosingGesture(sender:)))
        closeButton.addTarget(self, action: #selector(closeMenu(sender:)), for: .touchUpInside)
        closeButton.addGestureRecognizer(panGestureRecognizer)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(view)
            make.width.equalTo(view).multipliedBy(1 - MenuHelper.menuWidth)
        }
    }
    
    @objc func signOut() {
        switchTo(page: .login)
//        var keepTryingClosure: ((Bool, Error?) -> Void)!
//        keepTryingClosure = {(success, error) in
//            if let error = error {
//                print(error._userInfo?[NSLocalizedFailureReasonErrorKey] ?? "")
//                //                UserService.manager.signOut(completion: keepTryingClosure)
//            }
//            if success {
//                print("successfully signed out")
//                self.switchTo(page: .login)
//            }
//        }
        //        UserService.manager.signOut(completion: keepTryingClosure)
    }
    
    // 1
    weak var interactor: Interactor?
    // 2
    @objc func handleClosingGesture(sender: UIPanGestureRecognizer) {
        // 3
        let translation = sender.translation(in: view)
        // 4
        let progress = MenuHelper.calculateProgress(
            translationInView: translation,
            viewBounds: view.bounds,
            direction: .left
        )
        // 5
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactor: interactor){
                // 6
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func switchTo(page: Page) {
                (fromVC?.tabBarController as? MainTabBarVC)?.animateTo(page: page, fromViewController: self)
    }
    
    
    
}
