//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by Sean Allen on 12/27/19.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

		//SZ: scene is passed by caller
        guard let windowScene = (scene as? UIWindowScene) else { return }

		let searchNavigationController = createSearchNC()
		let favoritesNavigationController = createFavoritesNC()
		let settingsNavigationController = createSettingsNC()
		let tabBarController = UITabBarController()
		UITabBar.appearance().tintColor = .systemGreen
		tabBarController.viewControllers = [searchNavigationController, favoritesNavigationController, settingsNavigationController]

		UINavigationBar.appearance().tintColor = .systemGreen

		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

	private func createSearchNC() -> UINavigationController {
		let searchVC = HomeSearchViewController()
		searchVC.title = "Search"
		searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
		return UINavigationController(rootViewController: searchVC)
	}

	private func createFavoritesNC() -> UINavigationController {
		let favoritesListVC = FavoritesListViewController()
		favoritesListVC.title = "Favorites"
		favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
		return UINavigationController(rootViewController: favoritesListVC)
	}

	private func createSettingsNC() -> UINavigationController {
		let settingsVC = SettingsViewController()
		settingsVC.title = "Settings"
		settingsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
		return UINavigationController(rootViewController: settingsVC)
	}


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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

