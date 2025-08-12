🌱 Grow Your Forest – Habit Tracking Flutter App
Welcome to Grow Your Forest, a beautifully animated habit-tracking app built with Flutter, Provider, and Firebase Firestore.

Every 3 tasks you complete plants a tree. The more consistent you are, the bigger and more vibrant your forest becomes 🌳.

📱 Features
✅ Task Tracking: Complete daily tasks to grow your forest.

🌳 Custom Forest UI: Unique tree drawings using CustomPainter, not images.

📊 Daily Progress: Tracks how many tasks you've done today.

🔁 Growth Cycles: Each species has unique growth stages (e.g., seed → sprout → tree).

☁️ Firebase Integration: Real-time sync with Firestore for:

Master species data

Daily task completion

User’s garden state

🛠️ Tech Stack
Technology	Usage
Flutter	Core app framework
Provider	State management
CustomPainter	Rendering forest visuals
Firebase Firestore	Backend database

🚀 Getting Started
Follow these steps to run the project locally:

1. Clone the repo
bash
Copy
Edit
git clone https://github.com/Prateekgithubgeek/grow_your_forest.git
cd grow_your_forest
2. Install dependencies
bash
Copy
Edit
flutter pub get
3. Connect Firebase
Set up your Firebase project and replace the configuration:

Download the google-services.json file from Firebase Console.

Place it under:
android/app/google-services.json

Ensure Firestore is enabled in your Firebase project.

4. Run the app
bash
Copy
Edit
flutter run


📦 APK Download
Download the release build:


⚖️ Assumptions & Trade-offs
No login/auth – user data is stored under a default UID for demo.

All visuals are drawn using Flutter’s CustomPainter (no image assets).

Simplified layout – focused on function and demo readability.

🙌 Credits
Crafted with 💚 by Prateek Sohani
For the Flutter Developer Internship at HealthTick
