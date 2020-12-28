# Epitech Dashboard API Documentation

## Introduction 👋

### What is the Dashboard ?

The goal of this project is to make a platform (mobile app or webb app) that displays widgets.

Widgets are basic components that displays informations based on services.

### What is the goal of this API ?

This API allows us to interact with our database to retrieve and protects its data. Also it allows us to
communicate using third-party APIs (weather, IMDB, Covid stats ...)

## How to access the API

When it is launched by using docker, you may interact with the API like so :

`http://localhost:8080`

The default port is `8080`, you may change it as you like in the `dockerfile`

## Table of contents
1. [User](#user)
2. [Service](#service)
3. [Widget](#widget)
4. [About](#about)
5. [Services Routes](#servicesRoutes)

## 1. User

#### GET

#### All users on server

```md
[GET] http://localhost:8080/user
```

Response example :

```json
[
    {
        "userId": "c74f9cdb-3f71-4018-ae28-40b78ee2a5fc",
        "username": "remi",
        "password": "a",
        "services": null,
        "userServices": null
    }
]
```

#### User by its ID

```md
[GET] http://localhost:8080/user/{id}
```

Response example :

```json
{
    "userId": "c74f9cdb-3f71-4018-ae28-40b78ee2a5fc",
    "username": "remi",
    "password": "a",
    "services": null,
    "userServices": null
}
```

#### POST

#### User Sign Up

```md
[POST] http://localhost:8080/user/signup
```

**Body is mandatory**

```md
[Body]

    Username - string

    Password - string
```

Response example :

```json
201 - Success - Created - user ID
```

#### User Sign In

```md
[POST] http://localhost:8080/user/signup
```

**Body is mandatory**

```md
[Body]

    Username - string

    Password - string
```

Response example :

```json
200 - Success - Ok

[
    {
        "userId": "c74f9cdb-3f71-4018-ae28-40b78ee2a5fc",
        "username": "remi",
        "password": "a",
        "services": null,
        "userServices": null
    }
]
```
#### DELETE

#### Delete user

```md
[DELETE] http://localhost:8080/user/delete
```

**Body is mandatory**

```md
[Body]

    id - Guid
```

## 2. Service

### GET

#### All services on server

```md
[GET] http://localhost:8080/service
```

Response example :

```json
[
    {
        "serviceId": "a5e863aa-5523-4213-8d61-d5069b92f41d",
        "serviceName": "Cinema",
        "urlImage": "https://assets.brandfetch.io/85fc1cf3acf5416.png",
        "authorizeUrl": "",
        "accessTokenUrl": "",
        "widgets": null,
        "users": null,
        "userServices": null
    },
    {
        "serviceId": "debb02dc-5317-434f-b2da-cb6e58798895",
        "serviceName": "Covid",
        "urlImage": "https://assets.brandfetch.io/6018cca55d01491.png",
        "authorizeUrl": "",
        "accessTokenUrl": "",
        "widgets": null,
        "users": null,
        "userServices": null
    }
]
```

#### GET - Service by its name

```md
[GET] http://localhost:8080/service/{serviceName}
```

Response example :

```json
{
    "serviceId": "a5e863aa-5523-4213-8d61-d5069b92f41d",
    "serviceName": "Cinema",
    "urlImage": "https://assets.brandfetch.io/85fc1cf3acf5416.png",
    "authorizeUrl": "",
    "accessTokenUrl": "",
    "widgets": null,
    "users": null,
    "userServices": null
}
```

#### GET - User's services

```md
[GET] http://localhost:8080/service/user/{userId}
```

Response example :

```json
[
    {
        "serviceId": "a5e863aa-5523-4213-8d61-d5069b92f41d",
        "serviceName": "Cinema",
        "urlImage": "https://assets.brandfetch.io/85fc1cf3acf5416.png",
        "authorizeUrl": "",
        "accessTokenUrl": "",
        "widgets": null,
        "users": null,
        "userServices": null
    },
    {
        "serviceId": "debb02dc-5317-434f-b2da-cb6e58798895",
        "serviceName": "Covid",
        "urlImage": "https://assets.brandfetch.io/6018cca55d01491.png",
        "authorizeUrl": "",
        "accessTokenUrl": "",
        "widgets": null,
        "users": null,
        "userServices": null
    },
    {
        "serviceId": "840fadb2-0edb-49af-8983-50c94b28777b",
        "serviceName": "Github",
        "urlImage": "https://assets.brandfetch.io/62991192576d44c.png",
        "authorizeUrl": "https://github.com/login/oauth/authorize",
        "accessTokenUrl": "https://github.com/login/oauth/access_token",
        "widgets": null,
        "users": null,
        "userServices": null
    },
    {
        "serviceId": "0819411c-8c53-4239-9947-42d6485b8438",
        "serviceName": "Movie",
        "urlImage": "https://assets.brandfetch.io/fe2ed100aa4149f.png",
        "authorizeUrl": "",
        "accessTokenUrl": "",
        "widgets": null,
        "users": null,
        "userServices": null
    }
]
```

#### GET - Widgets linked to a service

```md
[GET] http://localhost:8080/service/{serviceName}/widgets
```

## POST

#### Add a service to an User

```md
[POST] http://localhost:8080/service/user/{userId}/{serviceId}
```

Response example :

```json
200 - Success - Ok

{
    "serviceId": "a5e863aa-5523-4213-8d61-d5069b92f41d",
    "serviceName": "Cinema",
    "urlImage": "https://assets.brandfetch.io/85fc1cf3acf5416.png",
    "authorizeUrl": "",
    "accessTokenUrl": "",
    "widgets": null,
    "users": null,
    "userServices": null
}
```

## DELETE

### DELETE - Delete service from a user

```md
[DELETE] http://localhost:8080/service/user/{userId}/{serviceId}
```

Response example:

```json
200 - Success - Ok

{
    "serviceId": "a5e863aa-5523-4213-8d61-d5069b92f41d",
    "serviceName": "Cinema",
    "urlImage": "https://assets.brandfetch.io/85fc1cf3acf5416.png",
    "authorizeUrl": "",
    "accessTokenUrl": "",
    "widgets": null,
    "users": null,
    "userServices": null
}
```

## 3. Widget

## GET

### GET - Get all widgets from server

```md
[GET] http://localhost:8080/widget
```

Response example:

```json
200 - Success - Ok

[
    {
        "widgetId": "8a80c21c-1a1a-47d6-8a0e-33866efc4bba",
        "widgetName": "Cinema movies informations",
        "widgetDescription": "Display informations about a movie",
        "serviceId": "64e652a8-e46a-4895-917a-d2f95f51aac7",
        "service": null
    },
    {
        "widgetId": "7e46fc9d-202e-4940-ba3d-6181177b9f91",
        "widgetName": "Covid French Tracker",
        "widgetDescription": "Display information about the covid in France",
        "serviceId": "05528304-5185-4c0b-9010-f4491824efeb",
        "service": null
    },
    {
        "widgetId": "e1b9e218-5100-43f6-af8c-12a08b2ffff4",
        "widgetName": "Github Manager",
        "widgetDescription": "Offers the possibility to see and create repositories",
        "serviceId": "3d170610-365c-413c-8436-94ad4bde03b6",
        "service": null
    }
]
```

### GET - A particular widget from server

```md
[GET] http://localhost:8080/widget/{widgetid}
```

**Body is mandatory**

```md
[Body]

    id - Guid
```

Response example:

```json
200 - Success - Ok

[
    {
        "widgetId": "8a80c21c-1a1a-47d6-8a0e-33866efc4bba",
        "widgetName": "Cinema movies informations",
        "widgetDescription": "Display informations about a movie",
        "serviceId": "64e652a8-e46a-4895-917a-d2f95f51aac7",
        "service": null
    },
    {
        "widgetId": "7e46fc9d-202e-4940-ba3d-6181177b9f91",
        "widgetName": "Covid French Tracker",
        "widgetDescription": "Display information about the covid in France",
        "serviceId": "05528304-5185-4c0b-9010-f4491824efeb",
        "service": null
    },
    {
        "widgetId": "e1b9e218-5100-43f6-af8c-12a08b2ffff4",
        "widgetName": "Github Manager",
        "widgetDescription": "Offers the possibility to see and create repositories",
        "serviceId": "3d170610-365c-413c-8436-94ad4bde03b6",
        "service": null
    }
]
```

## PUT

### PUT - Add/update all widgets from server

```md
[PUT] http://localhost:8080/widget
```

**Body is mandatory**

```md
[Body]

WidgetName - string

WidgetDescription - string

ServiceId - Guid

Service - ServiceModel
```

Response example:

```json
200 - Success - Ok

[
    {
        "widgetId": "8a80c21c-1a1a-47d6-8a0e-33866efc4bba",
        "widgetName": "Cinema movies informations",
        "widgetDescription": "Display informations about a movie",
        "serviceId": "64e652a8-e46a-4895-917a-d2f95f51aac7",
        "service": null
    },
    {
        "widgetId": "7e46fc9d-202e-4940-ba3d-6181177b9f91",
        "widgetName": "Covid French Tracker",
        "widgetDescription": "Display information about the covid in France",
        "serviceId": "05528304-5185-4c0b-9010-f4491824efeb",
        "service": null
    },
    {
        "widgetId": "e1b9e218-5100-43f6-af8c-12a08b2ffff4",
        "widgetName": "Github Manager",
        "widgetDescription": "Offers the possibility to see and create repositories",
        "serviceId": "3d170610-365c-413c-8436-94ad4bde03b6",
        "service": null
    }
]
```

## DELETE

### Delete - delete a particular widget

```md
[GET] http://localhost:8080/widget/{widgetid}
```


## 4. About

#### About.json

You may find informations about the server, the services and widgets availables

```md
[GET] http://localhost:8080/about.json
```

response example :

```json
{
  "customer": {
    "host": "172.19.0.1"
  },
  "server": {
    "current_time": 1608051047,
    "services": [
      {
        "ServiceId": "a5e863aa-5523-4213-8d61-d5069b92f41d",
        "ServiceName": "Cinema",
        "UrlImage": "https://assets.brandfetch.io/85fc1cf3acf5416.png",
        "AuthorizeUrl": "",
        "AccessTokenUrl": "",
        "Widgets": null,
        "Users": null,
        "UserServices": null
      },
      {
        "ServiceId": "debb02dc-5317-434f-b2da-cb6e58798895",
        "ServiceName": "Covid",
        "UrlImage": "https://assets.brandfetch.io/6018cca55d01491.png",
        "AuthorizeUrl": "",
        "AccessTokenUrl": "",
        "Widgets": null,
        "Users": null,
        "UserServices": null
      },
      {
        "ServiceId": "840fadb2-0edb-49af-8983-50c94b28777b",
        "ServiceName": "Github",
        "UrlImage": "https://assets.brandfetch.io/62991192576d44c.png",
        "AuthorizeUrl": "https://github.com/login/oauth/authorize",
        "AccessTokenUrl": "https://github.com/login/oauth/access_token",
        "Widgets": null,
        "Users": null,
        "UserServices": null
      },
      {
        "ServiceId": "0819411c-8c53-4239-9947-42d6485b8438",
        "ServiceName": "Movie",
        "UrlImage": "https://assets.brandfetch.io/fe2ed100aa4149f.png",
        "AuthorizeUrl": "",
        "AccessTokenUrl": "",
        "Widgets": null,
        "Users": null,
        "UserServices": null
      },
      {
        "ServiceId": "16cc9c05-c87a-433a-a1cd-a971ae2ab26b",
        "ServiceName": "Nasa",
        "UrlImage": "https://assets.brandfetch.io/147763f045ea4b0.png",
        "AuthorizeUrl": "",
        "AccessTokenUrl": "",
        "Widgets": null,
        "Users": null,
        "UserServices": null
      },
      {
        "ServiceId": "ef5e07e0-bc55-48da-96a1-5f8bbd7a53b5",
        "ServiceName": "Trump",
        "UrlImage": "https://assets.brandfetch.io/17f7e914fb11413.png",
        "AuthorizeUrl": "",
        "AccessTokenUrl": "",
        "Widgets": null,
        "Users": null,
        "UserServices": null
      },
      {
        "ServiceId": "81c218b5-67f7-4333-bbf7-3d500df83bbb",
        "ServiceName": "Weather",
        "UrlImage": "https://assets.brandfetch.io/e15acb0dae4849f.png",
        "AuthorizeUrl": "",
        "AccessTokenUrl": "",
        "Widgets": null,
        "Users": null,
        "UserServices": null
      }
    ]
  }
}
```

## 5. Services routes

You will find here informations about the different services route avaible

### Cinema (OpenMovieDatabse)

Get information about a movie

```md
[GET] http://localhost:8080/cinema/movie/{title}
```

Response example :


```json
{
    "Title": "Inception",
    "Year": "2010",
    "Released": "16 Jul 2010",
    "Runtime": "148 min",
    "Genre": "Action, Adventure, Sci-Fi, Thriller",
    "Director": "Christopher Nolan",
    "Actors": "Leonardo DiCaprio, Joseph Gordon-Levitt, Elliot Page, Tom Hardy",
    "Awards": "Won 4 Oscars. Another 152 wins & 218 nominations.",
    "imdbRating": 8.8
}
```

### Covid (Coronavirus API France)

Get currents statistics about covid. Numbers are updated everyday at 8pm CET.

#### Get French national covid statistics

```md
[GET] http://localhost:8080/covid
```

Response example :

```json
{
    "date": "2020-12-15",
    "source": {
        "nom": "Ministère des Solidarités et de la Santé"
    },
    "sourceType": "ministere-sante",
    "casConfirmes": 2391447,
    "deces": 40653,
    "decesEhpad": 18419,
    "hospitalises": 25240,
    "reanimation": 2881,
    "gueris": 179087,
    "casConfirmesEhpad": 133545,
    "nouvellesHospitalisations": 1560,
    "nouvellesReanimations": 211,
    "nom": "France",
    "code": "FRA"
}
```

#### Get French department covid statistics

```md
[GET] http://localhost:8080/covid/{department}
```

`NB: the department name should be starting with an uppercase letter -> Gironde`

Response example :

```json
{
    "code": "DEP-33",
    "nom": "Gironde",
    "date": "2020-12-15",
    "hospitalises": 390,
    "reanimation": 76,
    "nouvellesHospitalisations": 26,
    "nouvellesReanimations": 3,
    "deces": 420,
    "gueris": 2377,
    "source": {
        "nom": "Santé publique France Data"
    },
    "sourceType": "sante-publique-france-data"
}
```

### Movie (The movie db) - get trending movies / tv shows / actors

```md
[GET] http://localhost:8080/movie/{mediaType}/{timeWindow}
```

``` NB:
mediatype -> all, movie, tv, person
timeWindow -> day, week
```

Response example :

```json
[
    {
        "overview": "Armed with only one word - Tenet - and fighting for the survival of the entire world, the Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.",
        "release_date": "2020-08-22",
        "title": "Tenet",
        "name": null,
        "original_language": "en",
        "poster_path": "/k68nPLbIST6NP96JmTxmZijEvCA.jpg",
        "backdrop_path": "/wzJRB4MKi3yK138bJyuL9nx47y6.jpg",
        "media_type": "movie"
    },
    {
        "overview": "A bank robber tries to turn himself in because he's falling in love and wants to live an honest life...but when he realizes the Feds are more corrupt than him, he must fight back to clear his name.",
        "release_date": "2020-09-03",
        "title": "Honest Thief",
        "name": null,
        "original_language": "en",
        "poster_path": "/zeD4PabP6099gpE0STWJrJrCBCs.jpg",
        "backdrop_path": "/tYkMtYPNpUdLdzGDUTC5atyMh9X.jpg",
        "media_type": "movie"
    },
    {
        "overview": "New edit and restoration of the final film in the epic Godfather trilogy, following Michael Corleone's attempt to free his family from crime and find a suitable successor to his empire.",
        "release_date": "2020-12-03",
        "title": "Mario Puzo's The Godfather, Coda: The Death of Michael Corleone",
        "name": null,
        "original_language": "en",
        "poster_path": "/dmMk2dXq793UHTyrlQZaGRPHLqD.jpg",
        "backdrop_path": "/itgek11riykMXw1RdKD7IYKhJD6.jpg",
        "media_type": "movie"
    },
    {
        "overview": "After the PTA of a conservative high school in Indiana bans same-sex couples from attending the annual prom, a gang of flamboyant Broadway stars try to boost their image by showing up to support two lesbian students.",
        "release_date": "2020-12-02",
        "title": "The Prom",
        "name": null,
        "original_language": "en",
        "poster_path": "/utYKyP9q7aYxU6LdOwkxRo92XFU.jpg",
        "backdrop_path": "/u517zo6teGyiKoa4dRIP5rMbFaH.jpg",
        "media_type": "movie"
    }
]
```

### Nasa - Astronomy picture of the day

```md
[GET] http://localhost:8080/nasa/apod
```

`NB: APOD may be an image or a video depending on the willingness of NASA's engineers`

Response example :

```json
{
    "title": "Sonified: The Matter of the Bullet Cluster",
    "url": "https://www.youtube.com/embed/sau5-39wK1c?rel=0"
}
```

### Trump (Tronald Dump API)

Get the wisests quotes from ex-POTUS. Essentials.

```md
[GET] http://localhost:8080/trump/quote
```

Response example :

```json
{
    "value": "It doesn't matter that Crooked Hillary has experience, look at all of the bad decisions she has made. Bernie said she has bad judgement!"
}
```

### Weather (OpenWeatherMap API)

Get the current weather in your city

```md
[GET] http://localhost:8080/weather/{cityName}
```

Response example :

```json
{
    "main": {
        "temp": 12.14,
        "feels_like": 8.46,
        "temp_min": 12.0,
        "temp_max": 12.22,
        "pressure": 1011.0,
        "humidity": 76
    },
    "name": "Bordeaux"
}
```


