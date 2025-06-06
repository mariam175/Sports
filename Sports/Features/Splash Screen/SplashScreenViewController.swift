//
//  SplashScreenViewController.swift
//  Sports
//
//  Created by Macos on 20/05/2025.
//

import UIKit
import Lottie
class SplashScreenViewController: UIViewController {

    private var animationView: LottieAnimationView?

    @IBOutlet var splashView: SportCollectionViewCell!


    override func viewDidLoad() {
           super.viewDidLoad()
           playAnimation()
       }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    func goToMainApp() {
        let sportsVC = SportsViewController(nibName: "SportsViewController", bundle: nil)
        sportsVC.tabBarItem = UITabBarItem(title: "Sports", image: UIImage(systemName: "sportscourt"), tag: 0)

        let favVC = FavTableViewController(nibName: "FavTableViewController", bundle: nil)
        favVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [sportsVC, favVC]
        tabBarController.tabBar.tintColor = UIColor.blue

        UIApplication.shared.windows.first?.rootViewController = tabBarController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }


    private func playAnimation() {
        animationView = LottieAnimationView(name: "Animation")
           guard let animationView = animationView else { return }

           animationView.translatesAutoresizingMaskIntoConstraints = false
           animationView.contentMode = .scaleAspectFit
           animationView.loopMode = .loop
           animationView.animationSpeed = 1.0

        splashView.addSubview(animationView)

           NSLayoutConstraint.activate([
               animationView.leadingAnchor.constraint(equalTo: splashView.leadingAnchor),
               animationView.trailingAnchor.constraint(equalTo: splashView.trailingAnchor),
               animationView.topAnchor.constraint(equalTo: splashView.topAnchor),
               animationView.bottomAnchor.constraint(equalTo: splashView.bottomAnchor)
           ])

           animationView.play()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.navigateNext()
        }
    }


    func navigateNext() {
        if UserDefaults.standard.hasSeenOnboarding {
            goToMainScreen()
        } else {
            goToOnboarding()
        }
    }

    func goToOnboarding() {
        let onboardingVC = OnBoardingContainerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        onboardingVC.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController = onboardingVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }



     func goToMainScreen() {
        let sportsVC = SportsViewController(nibName: "SportsViewController", bundle: nil)
        let sportsNav = UINavigationController(rootViewController: sportsVC)
        sportsNav.tabBarItem = UITabBarItem(title: "Sports", image: UIImage(systemName: "sportscourt"), tag: 0)

        let favVC = FavTableViewController(nibName: "FavTableViewController", bundle: nil)
        let favNav = UINavigationController(rootViewController: favVC)
        favNav.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "heart"), tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [sportsNav, favNav]
         let floraColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 1.0)
         tabBarController.tabBar.tintColor = .blue

        guard let window = UIApplication.shared.windows.first else { return }

        window.rootViewController = tabBarController
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }

 

}

extension UserDefaults {
    var hasSeenOnboarding: Bool {
        get { bool(forKey: "hasSeenOnboarding") }
        set { set(newValue, forKey: "hasSeenOnboarding") }
    }
}
