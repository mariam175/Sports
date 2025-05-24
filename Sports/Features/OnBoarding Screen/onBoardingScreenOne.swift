//
//  onBoardingScreenOne.swift
//  Sports
//
//  Created by Macos on 20/05/2025.
//

import UIKit

class onBoardingScreenOne: UIViewController {
    weak var delegate: OnboardingNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goToSec(_ sender: Any) {
        delegate?.goToNextPage()
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
