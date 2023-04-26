<h1 align="center"> Lunch and Learn 🍱📚 </h1>

![GitHub Contributors](https://img.shields.io/github/contributors/naomiyocum/lunch_and_learn)
![GitHub language count](https://img.shields.io/github/languages/count/naomiyocum/lunch_and_learn)
![GitHub top language](https://img.shields.io/github/languages/top/naomiyocum/lunch_and_learn?color=yellow)

<div align="center">
  <img src="https://media3.giphy.com/media/3oz8xB06mHyoGE7ZoQ/giphy.gif?cid=ecf05e47k1n1ibrrbqr4tjzmtg148yazo3vep62jc826m0x3&rid=giphy.gif&ct=g" width="600" height="300"/>
</div>

## Table of Contents
* [General Info](#general-info)
* [Learning Goals](#learning-goals)
* [Technologies](#technologies)
* [Usage](#usage)
* [API Endpoints](#api-endpoints)

## General Info
My team is working in a service-oriented architecture. The front-end will communicate with my back-end through the API exposed.

We are building an application that allows users to search for cuisines by country, and provide opportunity to learn more about that country's culture. This app will allow users to search for recipes by country, favorite recipes, and learn more about a particular country via a YouTube video and a variety of images.

## Learning Goals
- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Create appropriate error messages to assist developers
- Test both API consumption and exposure, making use of Webmock and VCR

## Technologies
- Ruby 2.7.4
- Rails 5.2.8

## Usage
You will need to get your own free API keys from the following services:
1. [Edamam Recipe API](https://developer.edamam.com/edamam-recipe-api)
2. [YouTube API](https://developers.google.com/youtube/v3/getting-started)
3. [Unsplash API](https://unsplash.com/documentation#getting-started)

After getting your 3 keys, fork and clone this repo to your local machine.

Then, run the following commands:
```
cd lunch_and_learn
bundle install
bundle exec figaro install
rails db:{drop,create,migrate,seed}
```

In the `config/application.yml` file, copy and paste the code block below and replace the values with your API keys:
```ruby
edamam-app-id: <YOUR_EDAMAM_API_ID>
edamam-app-key: <YOUR_EDAMAM_API_KEY>
youtube-key: <YOUR_YOUTUBE_API_KEY>
unsplash-key: <YOUR_UNSPLASH_API_KEY>
```

Start your server in the root directory:
```
rails s
```

Lastly, head to your web browser or Postman to consume my API. The base URL is `http://localhost:3000` and endpoints are listed below!

You can stop the server by clicking `Ctrl + C` on your keyboard.

## API Endpoints

#### REQUIRED HEADERS
```
{
'Content-Type': 'application/json',
'Accept': 'application/json'
}
```

- ### GET /api/v1/recipes
  > fetch recipes based on a particular country
  
  | Query Parameter        | Type          |  |
  | ------------- |:-------------:| -----:|
  | country      | string | Optional |

  <sub><sup>if no country is provided, a random country will be searched for you</sup></sub>
  
    #### Example Response
  ```json
  {
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Passport to Japan: Edamame, Gyoza, Rice and Teriyaki Beef",
                "url": "https://www.foodnetwork.com/recipes/rachael-ray/passport-to-japan-edamame-gyoza-rice-and-teriyaki-beef-recipe-2013871",
                "country": "japan",
                "image": "https://edamam-product-images.s3.amazonaws.com/web-img/237/2374bd7d348b32ba325739f8d9169119.jpeg..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Zero Proof: Shiso Limeade Recipe",
                "url": "http://www.seriouseats.com/recipes/2011/08/zero-proof-shiso-limeade.html",
                "country": "japan",
                "image": "https://edamam-product-images.s3.amazonaws.com/web-img/847/8475a2dca7024c9d5a7fa2a3e2806979.jpg..."
            }
        }
     ]
  }
  ```
<br>

- ### GET /api/v1/learning_resources
  > fetch learning resources for a particular country

  | Query Parameter        | Type          |  |
  | ------------- |:-------------:| -----:|
  | country      | string | Optional |
  
  <sub><sup>if no country is provided, a random country will be searched for you</sup></sub>
  
  #### Example Response
  ```json
  {
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "philippines",
            "video": {
                "title": "A Super Quick History of the Philippines",
                "youtube_video_id": "De08VKktvJ4"
            },
            "images": [
                {
                    "alt_tag": "landscape photography of island with boats",
                    "url": "https://images.unsplash.com/photo-1531761535209-180857e963b9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzOTkxMzV8MHwxfHNlYXJjaHwyfHxwaGlsaXBwaW5lc3xlbnwwfHx8fDE2NzM4MDYyOTc&ixlib=rb-4.0.3&q=80&w=1080"
                },
                {
                    "alt_tag": "aerial photo of body of water between mountains",
                    "url": "https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzOTkxMzV8MHwxfHNlYXJjaHwzfHxwaGlsaXBwaW5lc3xlbnwwfHx8fDE2NzM4MDYyOTc&ixlib=rb-4.0.3&q=80&w=1080"
                }
             ]
         }
      }
  }
  ```
  <br>
  
- ### POST /api/v1/users
  > registers a user with Lunch and Learn
 
   | Body (JSON)        | Type          |  |
  | ------------- |:-------------:| -----:|
  | name      | string | Required |
  | email      | string | Required |
  | password      | string | Required |
  | password_confirmation      | string | Required |
  
  #### Example Response
  ```json
  {
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "name": "Roronoa Zoro",
            "email": "piratehunter@onepiece.jp",
            "api_key": "D+W0GG0gYdj85zquv2U12w=="
          }
      }
  }
  ```
  <br>
  
- ### POST /api/v1/sessions
  > logs user in
  
   | Body (JSON)        | Type          |  |
  | ------------- |:-------------:| -----:|
  | email      | string | Required |
  | password      | string | Required |
  
  #### Example Response
  ```json
  {
    "data": {
        "id": "4",
        "type": "user",
        "attributes": {
            "name": "Sanji",
            "email": "sanji@onepiece.jp",
            "api_key": "/cN53CTIOr2xHD/93BVpvg=="
          }
      }
  }
  ```
  <br>
  
- ### POST /api/v1/favorites
  > adds recipes to a favorited list for a particular user
  
  | Body (JSON)        | Type          |  |
  | ------------- |:-------------:| -----:|
  | api_key      | string | Required |
  | country      | string | Required |
  | recipe_link      | string | Required |
  | recipe_title      | string | Required |
  
  #### Successful Response
  ```json
  {
    "success": "Favorite added successfully"
  }
  ```
  <br>

- ### GET /api/v1/favorites
  > fetch favorites of a particular user
  
  | Query Parameter        | Type          |  |
  | ------------- |:-------------:| -----:|
  | api_key      | string | Required |
  
  #### Example Response
  ```json
  {
    "data": [
        {
            "id": "7",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Okinawa Soba 沖縄そば",
                "recipe_link": "https://www.justonecookbook.com/okinawa-soba/",
                "country": "japan",
                "created_at": "2023-01-16T03:28:49.956Z"
              }
          },
          {
            "id": "10",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Kare Kare",
                "recipe_link": "https://panlasangpinoy.com/kare-kare-recipe/",
                "country": "Philippines",
                "created_at": "2023-01-16T03:42:22.956Z"
              }
          }
      ]
  }
  ```
  <br>
  
  
- ### DELETE /api/v1/favorites
  > deletes a favorite
  
  | Query Parameters        | Type          |  |
  | ------------- |:-------------:| -----:|
  | api_key      | string | Required |
  | recipe_link      | string | Required |
  
