# Overview
This is a video sharing platform.
![title](screenshots/video-feed.png)
# System Dependencies
- Ruby 3.0.2
- Rails 6.1.6
- PostgreSQL
# Setup & Configuration
## Docker
1. Clone project
```sh
git clone https://github.com/tamle-dev/tlstudio.git
```
2. Duplicate .env from .env.example
3. Make sure `DB_USER` and `DB_PASSWORD` in docker-compose.yml and .env are the same
4. Build image
```sh
docker build . -t tlstudio:latest
```
5. Compose container
```sh
docker-compose up -d
```
6. Access http://localhost:3000
## Manual
1. Install PostgreSQL
```sh
brew install postgresql
```
2. Install Ruby 3.0.2 (recommend use rvm)
3. Clone project
```sh
git clone https://github.com/tamle-dev/tlstudio.git
```
4. Duplicate .env from .env.example
5. Install dependencies
```sh
bundle install
```
6. Create database
```sh
rake db:create
```
7. Migrations and Seed data
```sh
rake db:migrate
rake db:seed
```
8. Start application
```sh
rails c
```
9. Access http://localhost:3000
# API
1. Login with username & password
```sh
POST api/users/login
```
2. Get movies
```sh
GET api/movies
```
3. Share a video
```sh
POST api/me/movies/share
```
> All of APIs that requires authenticate must have Authorization header with auth_token which has been generated in login API

> https://documenter.getpostman.com/view/17493034/UzBmMSSi
# How to use
1. Access http://localhost:3000
2. Sign in / Sign up
3. Share a video with youtube link
4. View list of videos
# UI
![title](screenshots/welcome.png)
![title](screenshots/login.png)
![title](screenshots/sign-up.png)
![title](screenshots/dashboard.png)
![title](screenshots/logged-in.png)
![title](screenshots/how-many-video-that-you-shared.png)
![title](screenshots/share-a-video.png)
![title](screenshots/video-feed.png)
# API
![title](screenshots/api-login.png)
![title](screenshots/api-get-movies.png)
![title](screenshots/api-share-video.png)