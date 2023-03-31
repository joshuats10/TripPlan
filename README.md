# TripPlan

## Setup

1. Install the Flutter SDK by following the steps here.Run the following command in your terminal to install the project dependencies:

   ```
   flutter pub get
   ```

1. Setting up `launch.json` for flutter application

   Below is an example launch.json file for a Flutter application in Visual Studio Code. This configuration file is used to launch the application in debug mode. In this configuration, the `--dart-define` option is used to set the API_KEY for Google Maps.

   ```json
   {
     "version": "0.2.0",
     "configurations": [
       {
         "name": "front",
         "cwd": "front",
         "request": "launch",
         "type": "dart",
         "args": ["--dart-define=API_KEY=YOUR_GOOGLE_MAPS_API_KEY_HERE"]
       },
       {
         "name": "front (profile mode)",
         "cwd": "front",
         "request": "launch",
         "type": "dart",
         "flutterMode": "profile",
         "args": ["--dart-define=API_KEY=YOUR_GOOGLE_MAPS_API_KEY_HERE"]
       },
       {
         "name": "front (release mode)",
         "cwd": "front",
         "request": "launch",
         "type": "dart",
         "flutterMode": "release",
         "args": ["--dart-define=API_KEY=YOUR_GOOGLE_MAPS_API_KEY_HERE"]
       }
     ]
   }
   ```

   This configuration file uses the `--dart-define` option to pass the API_KEY for Google Maps to the application. This option allows the API_KEY to be accessed within the application and is necessary for using the Google Maps API.

   In the example above, you need to replace "YOUR_GOOGLE_MAPS_API_KEY_HERE" with the actual API_KEY for Google Maps. The API_KEY is a unique identifier that authorizes access to Google Maps services, so you should take appropriate security measures to protect it, especially if you plan to share or publish this configuration file.

## Build and run

1. Run the following command in your terminal to build the app:
   ```
   flutter build
   ```
1. To run the app, run the following command:
   ```
   flutter run
   ```
