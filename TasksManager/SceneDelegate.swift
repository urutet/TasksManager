//
//  SceneDelegate.swift
//  TasksManager
//
//  Created by Yushkevich Ilya on 21.04.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  private enum Constants {
    static let notesTitle = "Notes"
    static let notesImage = UIImage(systemName: "note")
    static let notesImageSelected = UIImage(systemName: "note.text")
    static let toDoTitle = "To Do"
    static let toDoImage = UIImage(systemName: "mail")
    static let toDoImageSelected = UIImage(systemName: "mail.fill")
    static let accountTitle = "Account"
    static let accountImage = UIImage(systemName: "person.circle")
    static let accountImageSelected = UIImage(systemName: "person.circle.fill")
  }
  
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let window = UIWindow(windowScene: windowScene)
    self.window = window
    
    let notesVC = NotesViewController()
    notesVC.tabBarItem = UITabBarItem(
      title: Constants.notesTitle,
      image: Constants.notesImage,
      selectedImage: Constants.notesImageSelected
    )
    let notesNavigationVC = UINavigationController(rootViewController: notesVC)
    
    let toDoVC = ToDoViewController()
    toDoVC.tabBarItem = UITabBarItem(
      title: Constants.toDoTitle,
      image: Constants.toDoImage,
      selectedImage: Constants.toDoImageSelected
    )
    let toDoNavigationVC = UINavigationController(rootViewController: toDoVC)
    
    let accountVC = ToDoViewController()
    accountVC.tabBarItem = UITabBarItem(
      title: Constants.accountTitle,
      image: Constants.accountImage,
      selectedImage: Constants.accountImageSelected
    )
    
    let tabBarVC = UITabBarController()
    tabBarVC.view.backgroundColor = .systemBackground
    tabBarVC.viewControllers = [notesNavigationVC, toDoNavigationVC, accountVC]
    window.rootViewController = tabBarVC
    window.makeKeyAndVisible()
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

