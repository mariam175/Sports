🏀⚽🏐 Sports App 
Sports App is an iOS application that allows users to explore popular sports,
view league details, and manage favorites through a clean, responsive interface. 
Designed using MVP architecture, the app promotes a smooth experience for exploring data dynamically.


- Features
- Sports Listing
Explore various sports such as football, basketball, and tennis, each leading to their respective leagues.
- League Details
View leagues associated with a selected sport and explore detailed info like teams and match schedules.
- Favorites
Save and manage your favorite sports or leagues with easy access at any time.
- Onboarding Flow
A modern onboarding experience introduces users to the app through 3 interactive screens.
- Splash Screen
Professional splash screen with animation for a polished entry point.


🛠 Tech Stack
* Language: Swift
* Architecture: MVP (Model-View-Presenter)
* UI: UIKit using Nib Files
* Navigation: UINavigationController & UITabBarController
* Persistence: UserDefaults (for saving onboarding status)
* Dependency Management: SwiftPackage Manager
* IDE: Xcode
* Version Control: Git & GitHub


🧩 Architecture Overview
The app follows a clean MVP architecture, where:
* Models handle data (e.g., sport names, league details).
* Views are UIViewControllers backed by .xib files.
* Presenters manage the logic and pass data between the Model and View.
Each feature (Splash, Onboarding, Sports, Favorites) is modular and follows separation of concerns for better maintainability.

(How It Works)

1. Splash Screen Loads at launch and navigates to onboarding or main app based on UserDefaults.
2. Onboarding Guides the user through 3 screens before accessing the app.
3. Main App (UITabBarController)
    * Tab 1: Sports list (from a local or network source).
    * Tab 2: Favorites (managed via UserDefaults for persistence).

      
📊 Data Management
* Currently, lightweight data is stored locally.
* Onboarding status is saved in UserDefaults.standard.hasSeenOnboarding.



🚀 Getting Started
✅ Prerequisites
* macOS with Xcode 15+
* iOS 15+
* Internet connection for loading images or API (if applicable)
🔧 Setup Instructions
1. Clone the repository from GitHub.
2. Open Sports.xcodeproj in Xcode.
3. Run the app on a simulator or real device.

Screenshots & Demo




![Screenshot 2025-05-24 at 10 40 11 PM](https://github.com/user-attachments/assets/c0940f07-522e-481a-ab6b-f171494aec5f)
![Screenshot 2025-05-24 at 10 35 45 PM](https://github.com/user-attachments/assets/711e0976-f681-4094-9162-ef3e649557f1)
![Screenshot 2025-05-24 at 10 35 11 PM](https://github.com/user-attachments/assets/2c149740-39aa-416d-b34a-ac59ec5de126)
![Screenshot 2025-05-24 at 10 34 35 PM](https://github.com/user-attachments/assets/a17e81ac-12a6-4e14-b4df-c68b188f77ed)
![Screenshot 2025-05-24 at 10 34 13 PM](https://github.com/user-attachments/assets/f36069ca-d6ab-4c13-92d2-6b36eef48d89)





Developed By
Mariam Raafat and
Mohammed Hussien

