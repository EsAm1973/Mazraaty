# Mazraaty

Mazraaty is a smart agricultural companion app designed especially for people interested in agriculture who may not have sufficient experience or expertise. The app provides educational resources, actionable insights, and supportive tools to help beginners and enthusiasts learn, care for their plants, and make informed decisions in their agricultural journey. Whether you're a hobbyist, a new gardener, or simply curious about plants, Mazraaty empowers you to grow with confidence.

## 🌱 Vision

> "Mazraaty aims to bridge the knowledge gap for aspiring agriculturists and plant lovers. By offering easy-to-use tools, a comprehensive plant library, and AI-powered guidance, Mazraaty supports users who lack professional experience, helping them learn, care for their plants, and enjoy successful agricultural experiences."

## 🚀 Features

- **User Authentication:** Register, log in, and manage your credentials securely to personalize your experience and access all app features. If you forget your password, you can easily recover and reset it through the app's password recovery process.
- **Educational Guidance:** Step-by-step support and tips for plant care and agriculture basics.
- **Library of Plants:** Explore a vast collection of plant species with detailed information, care methods, and common diseases.
- **AI Plant Chat:** Chat with an AI assistant to get answers about specific plants and their care.
  - **Note:** The AI Chat feature uses a limited API key from DeepSeek: R1 (free). If you find that AI Chat is not working, please visit the OpenRouter website, search for "DeepSeek: R1 (free)", retrieve a new API key, and update the `deepSeekApiKey` variable in the `ai_chat_view_body.dart` file.
- **Scan Feature (Points System):** The plant disease detection feature operates on a points system. Users must have enough points to use the scan feature; points can be purchased through the app. This system helps support the app and ensures fair usage.
  - **Supported Plants:** The Scan Feature can predict diseases for the following plant types: **Apple, Corn, Blueberry, Cherry, Grape, Orange, Peach, Pepper, Potato, Raspberry, Soybean, Squash, Strawberry, Tomato**.
- **Disease History:** Track your plants' health and history over time.
- **Common Diseases:** Learn about common plant diseases and how to prevent or treat them.
- **User Profile:** Manage your account, crop your profile image, change your password, and delete your account if needed. Password change and recovery options are available for your security and convenience.
- **Subscription & Payments:** Access premium features and purchase points via Paypal or MyFatoorah payment gateways.
- **Onboarding & Splash:** Smooth onboarding experience for new users.

## 🗂️ Project Structure

```
lib/
  Core/           # Core utilities, data, models, widgets
  Features/
    authentication/   # User authentication (login, register, change password)
    history/          # Disease history tracking
    home/             # Main dashboard and feature highlights
    onboardeing/      # Onboarding screens
    payment/          # Subscription and payment methods
    plant_library/    # Plant database, AI chat, plant details
    profile/          # User profile management
    scan_plant/       # Plant disease scanning, camera, points system
    settings/         # App settings
    splash/           # Splash screen
  main.dart       # App entry point
```

## 🛠️ Technologies & Dependencies

- **Flutter** (Dart SDK ^3.5.3)
- **State Management:** flutter_bloc, get_it
- **Networking:** dio, http
- **Routing:** go_router
- **UI:** google_fonts, font_awesome_flutter, lottie, animated_text_kit, fl_chart, awesome_dialog, curved_navigation_bar, flutter_markdown
- **Camera & Image:** camera, image_picker, image_cropper, flutter_image_compress, cached_network_image
- **Persistence:** sqflite, path_provider, path
- **Permissions:** permission_handler
- **Other:** dartz, equatable, url_launcher, clipboard, timeago, geolocator, intl, uuid, google_sign_in

See `pubspec.yaml` for the full list and versions.

## 🌐 Backend/API

Mazraaty uses a custom backend API:
```
http://rmrmrm-001-site1.mtempurl.com/api-mobile/
```

## 📦 Assets
- Images: `assets/images/`
- Animations: `assets/animations/`
- Fonts: `assets/fonts/`

## 📊 Dataset

The AI model for plant disease prediction was trained using the dataset and code available at:
[Plant Disease Classification (ResNet) on Kaggle](https://www.kaggle.com/code/atharvaingle/plant-disease-classification-resnet-99-2)

## ▶️ Getting Started

1. **Install Flutter:** [Flutter Install Guide](https://flutter.dev/docs/get-started/install)
2. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd mazraaty
   ```
3. **Install dependencies:**
   ```sh
   flutter pub get
   ```
4. **Download and Run the Flask Server for Scan Feature:**
   - The Scan Feature (plant disease detection) requires a local Flask server.
   - Download the `flask_server` folder from the following link:
     [Download flask_server from Google Drive](https://drive.google.com/drive/folders/1M5P0d3RaGXA8bjyGcZYmI5S5kI53jqgw?usp=sharing)
   - After downloading, navigate to the `flask_server` folder and run the `all_disease_flask.py` file:
     ```sh
     cd flask_server
     python all_disease_flask.py
     ```
   - Make sure the server is running before using the Scan Feature in the app.
5. **Run the app:**
   ```sh
   flutter run
   ```
   - For web: `flutter run -d chrome`
   - For Android/iOS: Connect your device or use an emulator/simulator
6. **Build for release:**
   - Android: `flutter build apk`
   - iOS: `flutter build ios`

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

This project is for educational and demonstration purposes. Please contact the author for commercial use.

## 🙏 Credits

- Developed by:
  - Mohamed Esam El-Din (Flutter)
  - Mohamed Walaa (Backend)
  - Ramadan Mohamed (Backend)
  - Mohamed Alaa El-Din (UI)
  - Ahmed Ali (UI)
  - Gamal Abdel Nasser (Frontend)
- Special thanks to the Flutter community and open-source contributors.

---

*Empower your farming journey with Mazraaty!*

## 🖼️ Screenshots

Here are some screenshots showcasing the UI of Mazraaty:

| Onboarding | Login | Home | Plant Library |
|---|---|---|---|
| ![Onboarding1](ScreenShots/onboarding1.png) | ![Login](ScreenShots/login_screen.png) | ![Home1](ScreenShots/Home_Screen1.png) | ![Plant Library](ScreenShots/Plant_Library.png) |
| ![Onboarding2](ScreenShots/onboarding2.png) | ![Signup](ScreenShots/signup_screen.png) | ![Home2](ScreenShots/Home_Screen2.png) | ![Plant Details1](ScreenShots/Plant_Details1.png) |
| ![Onboarding3](ScreenShots/onboarding3.png) | ![Forget Password1](ScreenShots/ForgetPassword1.png) | ![Home3](ScreenShots/Home_Screen3.png) | ![Plant Details2](ScreenShots/Plant_Details2.png) |
| ![Onboarding4](ScreenShots/onboarding4.png) | ![Forget Password2](ScreenShots/ForgetPassword2.png) | | ![Plant Details3](ScreenShots/Plant_Details3.png) |

| Scan | History | Profile | Payment |
|---|---|---|---|
| ![Scan1](ScreenShots/Scan_Screen1.png) | ![History1](ScreenShots/History_Screen1.png) | ![Profile1](ScreenShots/Profile_Screen1.png) | ![Payment Methods](ScreenShots/Payment_Methods.png) |
| ![Scan2](ScreenShots/Scan_Screen2.png) | ![History2](ScreenShots/History_Screen2.png) | ![Profile2](ScreenShots/Profile_Screen2.png) | ![Payment Packages](ScreenShots/Payment_Packages.png) |
| | ![History3](ScreenShots/History_Screen3.png) | | |

| AI Chat | Disease Details | Delete Account | Splash |
|---|---|---|---|
| ![AI Chat1](ScreenShots/AI_Chat1.png) | ![Disease Details1](ScreenShots/Disease_Details1.png) | ![Delete Account](ScreenShots/Delete_Account.png) | ![Splash](ScreenShots/splash.png) |
| ![AI Chat2](ScreenShots/AI_Chat2.png) | ![Disease Details2](ScreenShots/Disease_Details2.png) | | |
| | ![Disease Details3](ScreenShots/Disases_Details3.png) | | |

> For more screens, see the `ScreenShots` folder in the repository.
