//
//  OnBoardingContainerViewController.swift
//  Sports
//
//  Created by Macos on 20/05/2025.
//

import UIKit

protocol OnboardingNavigationDelegate: AnyObject {
    func goToNextPage()
}

class OnBoardingContainerViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var arrayOfViewControllers = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.delegate = self
        self.dataSource = self

        let page1 = onBoardingScreenOne(nibName: "onBoardingScreenOne", bundle: nil)
        let page2 = onBoardingScreenTwo(nibName: "onBoardingScreenTwo", bundle: nil)
        let page3 = onBoardingScreenThree(nibName: "onBoardingScreenThree", bundle: nil)


        (page1 as? onBoardingScreenOne)?.delegate = self
        (page2 as? onBoardingScreenTwo)?.delegate = self

        arrayOfViewControllers = [page1, page2, page3]

        if let firstVC = arrayOfViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrayOfViewControllers.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return arrayOfViewControllers[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = arrayOfViewControllers.firstIndex(of: viewController), currentIndex + 1 < arrayOfViewControllers.count else {
            return nil
        }
        return arrayOfViewControllers[currentIndex + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayOfViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension OnBoardingContainerViewController: OnboardingNavigationDelegate {
    func goToNextPage() {
        if let currentVC = viewControllers?.first,
           let index = arrayOfViewControllers.firstIndex(of: currentVC),
           index + 1 < arrayOfViewControllers.count {
            let nextVC = arrayOfViewControllers[index + 1]
            setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }
}
