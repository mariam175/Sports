//
//  onBoardingScreenThree.swift
//  Sports
//
//  Created by Macos on 20/05/2025.
//

import UIKit

class onBoardingScreenThree: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func goToHome(_ sender: Any) {
        goToMainApp()


    }

    func goToMainApp() {
        UserDefaults.standard.hasSeenOnboarding = true

        let sportsVC = SportsViewController(nibName: "SportsViewController", bundle: nil)
        let sportsNav = UINavigationController(rootViewController: sportsVC)
        sportsNav.tabBarItem = UITabBarItem(title: "Sports", image: UIImage(systemName: "sportscourt"), tag: 0)

        let favVC = FavTableViewController(nibName: "FavTableViewController", bundle: nil)
        let favNav = UINavigationController(rootViewController: favVC)
        favNav.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [sportsNav, favNav]
        let floraColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
        tabBarController.tabBar.tintColor = floraColor

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {

            window.rootViewController = tabBarController
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionFlipFromRight,
                              animations: nil,
                              completion: nil)
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
