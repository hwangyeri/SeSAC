//
//  SceneDelegate.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
 
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // MARK: - Navigation Controller
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let vc = SignInViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
        
        // MARK: - TabBar Controller
        let tabBar = UITabBarController()
        
        let firstVC = UINavigationController(rootViewController: SearchViewController())
        firstVC.tabBarItem = UITabBarItem(title: "SearchVC", image: nil,selectedImage: nil)

        let secondVC = UINavigationController(rootViewController: SignInViewController())
        secondVC.tabBarItem = UITabBarItem(title: "SignInVC", image: nil,selectedImage: nil)
        
        let thirdVC = UINavigationController(rootViewController: iTunesSearchViewController())
        thirdVC.tabBarItem = UITabBarItem(title: "iTunesVC", image: nil,selectedImage: nil)
        
        tabBar.viewControllers = [firstVC, secondVC, thirdVC]
        tabBar.selectedIndex = 2
        tabBar.tabBar.backgroundColor = UIColor.systemBackground
        tabBar.tabBar.tintColor = UIColor.label
        
        window?.rootViewController = tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

