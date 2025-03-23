# Chatbot App

This app integrates with the DeepSeek R1 Zero API to provide chatbot functionality. The app dynamically loads platform-specific .env files (for Android and Web) to securely manage API keys and other environment variables.

## Features

- **Platform Detection**: Detects whether the app is running on Android or Web.
- **Environment Variables**: Uses .env files to securely store API keys and other sensitive data.
- **Chatbot Integration**: Connects to the DeepSeek R1 Zero API to provide chatbot responses.
- **Cross-Platform**: Works on both Android and Web platforms.

## Prerequisites

Before running the app, ensure you have the following:

- **Flutter SDK**: Install Flutter by following the official Flutter installation guide.
- **DeepSeek API Key**: Obtain an API key from the DeepSeek R1 Zero API.
- **Dart SDK**: Comes bundled with Flutter.

## Setup Instructions

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/EddyKubwimana/chatbot
cd chatbot
```

### 2. Add .env Files

Create .env files for each platform in the assets directory:

- **For Android**: `assets/android/.env`
- **For Web**: `assets/web/.env`

Example .env file:

```env
API_KEY=your_api_key_here
DEBUG_MODE=true
```

### 3. Update `pubspec.yaml`

Ensure the .env files are included in the assets section of `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/android/.env
    - assets/web/.env
```

### 4. Install Dependencies

Run the following command to install the required dependencies:

```bash
flutter pub get
```

### 5. Run the App

- **For Android:**

  ```bash
  flutter run -d android
  ```

- **For Web:**

  ```bash
  flutter run -d chrome
  ```

## Usage

### 1. Start Chatting

- Open the app and type your message in the input field.
- Press **Send** to send the message to the DeepSeek R1 Zero API.

### 2. View Responses

- The chatbot's response will be displayed in the chat interface.

## Project Structure

```
flutter-chatbot-app/
├── lib/
│   └── main.dart       
│   └── screen     
│   └── service
│        └──api_screen.dart
│        └──chart_provider.dart
│      
│
│   └── model
│       └── chat_message.dart   
├── assets/
│   ├── android/
│   │   └── .env               # Environment variables for Android
│   └── web/
│       └── .env               # Environment variables for Web
├── pubspec.yaml               # Dependencies and asset configuration
└── README.md                  # Project documentation
```

## Dependencies

- **flutter_dotenv**: Loads environment variables from .env files.
- **http**: Makes HTTP requests to the DeepSeek API.
- **provider**: State management for the app.
- **path**: Constructs platform-specific file paths.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments

- **DeepSeek**: For providing the R1 Zero API.
- **Flutter**: For the amazing cross-platform framework.

## Contact

For questions or feedback, feel free to reach out:

- **Email**:kubwimanaeddy1@gmail.com
- **GitHub**: [EddyKubwimana](https://github.com/EddyKubwimana)
