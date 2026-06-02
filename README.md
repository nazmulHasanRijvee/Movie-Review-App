# Movie Review App

A modern Flutter application for browsing and reviewing movies, powered by the **TMDB (The Movie Database) REST API**. This app provides detailed information about movies, including trailers, ratings, and overviews.

## 🚀 Features

- **Movie Discovery**: Browse popular and trending movies.
- **Detailed Insights**: View comprehensive movie details:
  - High-quality backdrop and poster images.
  - Movie tagline, release date, and duration.
  - Full plot overview and user ratings.
- **Interactive UI**:
  - Trailer access.
  - Personal Wishlist integration.
  - Movie logging for tracking.
- **State Management**: Built using **GetX** for efficient and reactive state management.
- **Environment Security**: Sensitive API keys are secured using `flutter_dotenv`.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Networking**: [http](https://pub.dev/packages/http)
- **Environment Variables**: [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- **Backend API**: [TMDB API](https://developer.themoviedb.org/docs)

## 📦 Prerequisites

Before you begin, ensure you have the following installed:
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- A TMDB API Key (You can get one [here](https://www.themoviedb.org/settings/api))

## ⚙️ Setup & Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/of_28_movie_review_app.git
    cd of_28_movie_review_app
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Configure Environment Variables**:
    Create a `.env` file in the root directory of the project and add your TMDB API token:
    ```env
    API_TOKEN=your_tmdb_api_token_here
    ```

4.  **Run the app**:
    ```bash
    flutter run
    ```

## 📂 Project Structure

```text
lib/
├── core/               # App constants, colors, and strings
├── data/               # Models, API utilities, and repositories
├── presentation/       # UI screens, widgets, and GetX controllers
│   ├── home/           # Home screen modules
│   └── movie_details/  # Movie details screen modules
└── main.dart           # Application entry point
```

## 🛡️ License

This project is licensed under the MIT License.

---
Developed as part of the Ostad Flutter Batch 13.
