# Epitech Dashboard

![Dashboard login screen](https://github.com/theprojectguy/Dashboard/blob/main/images/loginDashboard.png)

## Introduction 👋

What is the Dashboard ?

The goal of this project is to make a platform (mobile app or webb app) that displays widgets.

Widgets are basic components that displays informations based on services.

`Example : Weather Service -> current weather in Washington Widget`

The application is similar to [Netvibes](https://www.netvibes.com/fr)

This is an Epitech 3rd year project.

## The project 🚀

**The project is organised in two parts:**
1. The front-end is located in `Dashboard/`
2. The back-end is located in `api/`

## Technologies used
- Swift 5
- .NET Core 3.1

## Prerequisites:
- Mac OS 🍎
- XCode 12 or later
- Docker 🐳

## Install Swift dependencies 📚
1. `sudo gem install cocoapods`
2. `sudo gem install jazzy` (optional, it's for the swift documentation generation)

## How to launch the project ? 📲

1. Clone the project : `git clone B-DEV-500-BDX-5-1-cardgames-remi.poulenard`

then Run the following commands to start the Dashboard app.

### How to launch the API ? 🔮
<br>
The API is contained in Docker.

```bash
1. docker-compose build
2. docker-compose up -d (discrete is optional)
3. docker logs -f dashboard-api (displays API logs)
```

### How to launch the Mobile app ? 📲

```swift
1. `cd B-DEV-500-BDX-5-1-cardgames-remi.poulenard/Dashboard`
2. `pod install`
3. `open Dashboard.xcworkspace` (or use your file manager)
4. `Run the Dashboard mobile app from Xcode!`
```

## Services and Widgets implemented
- Weather
    - get currrent weather in a city
- Cinema
    - trending movies
- Trump quotes
    - random quote generator
- Covid stats
    - Update on intensive care
    - Update on diceases
    - Infection update
- Github
    - create reposittory
    - find user's repositories
- Nasa
    - Astronomy picture of the day

## Api documentation ? 📚

You will find documentation on this project in the `docs` folder.

## Final Word

Thanks to [Roland Hemmer](https://github.com/rolandhemmer) for his help and knowledge during this project.


Made with ❤️ by [Valentin Mille](https://github.com/theprojectguy) and [Rémi Poulenard](https://github.com/mireus1)
