# Lunch and Learn 
![GitHub top language](https://img.shields.io/github/languages/top/naomiyocum/rails-engine?color=yellow)

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
- Test both API consumption and exposure, making use of Webmock and VCR

## Technologies
- Ruby 2.7.4
- Rails 5.2.8

## Usage
Clone the repy but running `git clone` with the copied URL onto your local machine.

Then, run the following commands:
```
cd lunch_and_learn
bundle install
rails db:{drop,create,migrate,seed}
rails s
```
Lastly, head to your web browser or Postman. The base URL is `http://localhost:3000` and endpoints are listed below!

## API Endpoints
