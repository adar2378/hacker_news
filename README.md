# Hacker News


<p align="center">
  <img src="https://github.com/adar2378/hacker_news/raw/main/images/android_logo.png" width="460"/>
</p>

Hacker News is a very basic application with the following functionality

 - Shows top 25 stories
 - User can search stories
 - View the story in a webview along with the related comments and replies

## Screenshots
<img src="https://github.com/adar2378/hacker_news/raw/main/screenshots/top_stories.png" width="250" height="500"><img src="https://github.com/adar2378/hacker_news/raw/main/screenshots/search.png" width="250" height="500">
<img src="https://raw.githubusercontent.com/adar2378/hacker_news/main/screenshots/replies.png" width="250" height="500"><img src="https://github.com/adar2378/hacker_news/raw/main/screenshots/article_comments.png" width="250" height="500">
<img src="https://github.com/adar2378/hacker_news/raw/main/screenshots/article_details.png" width="250" height="500">

## Structure

- All the blocs, screens, widgets shared by the application are placed in `common` folder
- Inside `modules` folder for each module, `Search` and `Top Stories`, there are blocs, repositories, screens, models, adapters, widgets etc.
- `TextStyle`, `Color` etc are stored in `styles` folder.

## Basic API call flow
- First we try to collect the story ids in a `List`
- Then we fetch the details of the stories and wait for them to retrieve all the data
- Since this is resource-heavy work, we put this in a separate isolate
so that this work doesn't block our UI thread.
- After fetching all the needed data, we change the data according to our need and feed it to the UI.

<img src="https://github.com/adar2378/hacker_news/raw/main/diagrams/comment_api.jpeg" width="500" height="500"><img src="https://github.com/adar2378/hacker_news/raw/main/diagrams/search_api.jpeg" width="500" height="500">
<img src="https://github.com/adar2378/hacker_news/raw/main/diagrams/sequece_diagram.jpeg" width="500" height="500"><img src="https://github.com/adar2378/hacker_news/raw/main/diagrams/top_stories.jpeg" width="250" height="500">

## Running the code

- run `flutter pub get` to get the needed package
- run `flutter run` to run the application

P.S: Diagrams and screenshots can be found inside `root/diagrams` and `root/screenshots` folders repsectively.