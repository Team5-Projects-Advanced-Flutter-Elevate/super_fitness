# Fitness App 🏋️‍♀️💪🍏

[![Flutter](https://img.shields.io/badge/flutter-3.16.9-blue)](https://flutter.dev)
[![BLoC](https://img.shields.io/badge/state%20management-BLoC/Cubit-ff69b4)](https://bloclibrary.dev)
[![Firebase](https://img.shields.io/badge/firestore-ffcb2b)](https://firebase.google.com)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

SmartFit is a Flutter-based fitness application designed to guide users through personalized training, nutrition, and progress tracking using AI-powered features. Built using **Clean Architecture** and the **MVI Pattern**, and collaboratively developed via **GitHub**.

---

## 🔐 Authentication Features

- Register/Login with:
  - **Email & Password**
  - **Google**
  - **Facebook**
- **Forgot Password** support
- On registration, user provides:
  - Age
  - Gender
  - Weight
  - Fitness Goal
  - Activity Level

---

## 🧭 Main App Navigation (Bottom Navigation with 4 Tabs)

### 1. **Explore**
Contains three main sections:
- ✅ **Recommended Workouts for Today**
- ⏳ **Upcoming Workouts**
- 🍱 **Food Recommendations for You**

> Selecting "Food Recommendation" navigates to a food screen with:
> - Tab bar of food categories
> - Grid view of food items
> - Clicking on a food shows details including:
>   - Ingredients
>   - Carbs, Protein, Fat content
>   - Video tutorial for preparation

---

### 2. **Smart Trainer AI Chat**
- Conversational AI Trainer:
  - Helps with **training structure**, **meal planning**, and **Q&A**
  - Stores previous conversations in **Firestore**

---

### 3. **Workouts**
- Tab bar of workout categories
- Grid view for workouts within selected category
- Selecting a workout:
  - Targets a specific muscle
  - Displays list of related training videos

---

### 4. **Profile**
- Shows:
  - User’s name and profile image
- "Edit Profile" button:
  - Update registration data
  - Change password
  - Logout

---

## 🛠️ Architecture

- **Clean Architecture**
- **Model-View-Intent (MVI) Pattern**
- **Dependency Injection**: `injectable`, `get_it`
- **State Management**: `flutter_bloc`, `provider`
## Tech Stack 🛠️

| Layer              | Technology                                                                 |
|--------------------|----------------------------------------------------------------------------|
| **Framework**      | Flutter 3.16.9                                                             |
| **Architecture**   | Clean Architecture + MVI                                                   |
| **State Mgmt**     | flutter_bloc + cubit                                                       |
| **Backend**        | Firebase (Auth, Firestore)                                                 |
| **DI**             | Injectable + GetIt                                                         |
| **Networking**     | Dio + Retrofit                                                             |
| **Testing**        | 400+ unit/widget tests (85% coverage)                                      |
| **CI/CD**          | GitHub Actions                                                             |

## 🎥 Demo & Presentation
- [Live Demo](https://drive.google.com/drive/folders/1FrA3Bc_RItWUY8nIX6zyGlGqpyzm8UHl?usp=sharing) 

- [Project Presentation Slides](https://gamma.app/docs/Super-Fitness-App-sqqhwefej1nldx4)
