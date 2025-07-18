# Fitness App 🏋️‍♀️💪🍏

[![Flutter](https://img.shields.io/badge/flutter-3.16.9-blue)](https://flutter.dev)
[![BLoC](https://img.shields.io/badge/state%20management-BLoC/Cubit-ff69b4)](https://bloclibrary.dev)
[![Firebase](https://img.shields.io/badge/firebase-auth+firestore-ffcb2b)](https://firebase.google.com)
[![Coverage](https://codecov.io/gh/yourusername/fitness-app/branch/main/graph/badge.svg)](https://codecov.io/gh/yourusername/fitness-app)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

A complete fitness solution with workout tracking, AI coaching, and nutrition planning built with Flutter using Clean Architecture and BLoC pattern.

## Features ✨

### 🔐 Authentication
- Email/password login & registration
- Social login (Google, Facebook)
- Password recovery
- Complete profile setup

### 🏋️‍♂️ Workouts
- 500+ exercises with video tutorials
- Muscle-specific categories
- Workout progress tracking
- Scheduled training plans

### 🤖 AI Coach
- Personalized fitness guidance
- Nutrition recommendations
- Conversation history in Firestore
- Training program generator

### 🍏 Nutrition
- Food database with macros
- Meal planning tools
- Recipe videos
- Daily calorie tracking

## Tech Stack 🛠️

| Layer              | Technology                                                                 |
|--------------------|-----------------------------------------------------------------------------|
| **Framework**      | Flutter 3.16.9                                                             |
| **Architecture**   | Clean Architecture + MVI                                                   |
| **State Mgmt**     | flutter_bloc + cubit                                                       |
| **Backend**        | Firebase (Auth, Firestore)                                                 |
| **DI**             | Injectable + GetIt                                                         |
| **Networking**     | Dio + Retrofit                                                             |
| **Testing**        | 400+ unit/widget tests (85% coverage)                                      |
| **CI/CD**          | GitHub Actions                                                             |

