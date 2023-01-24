<br/>
<p align="center">
  <a href="https://github.com/mehmetalidemir/ VideoGamesApp">
    <img src="https://i.imgur.com/Slnz8oG.png" alt="Logo" width="100" height="100">
  </a>

  <h3 align="center">Video Games App</h3>

  <p align="center">
    Video Games Guide
    <br/>
    <br/>
  </p>
</p>

![Downloads](https://img.shields.io/github/downloads/mehmetalidemir/VideoGamesApp/total) ![Stargazers](https://img.shields.io/github/stars/mehmetalidemir/VideoGamesApp?style=social) 

## Table Of Contents

* [About the Project](#about-the-project)
* [Built With](#built-with)
* [Usage](#usage)
* [License](#license)
* [Authors](#authors)

## About The Project


This application uses the RAWG.io API to provide users with access to a selection of video games. Users can filter the list of games by genre, search for games by name, view game details, and add games to their favorites list. Users can view game details such as the name, image, genre, release date, and number of reviews. The application also allows users to add notes to games and view their added notes. The app also supports notifications to alert users when a note is successfully sent. The application utilizes Core Data to store the user’s notes. The layout and design of the app is intuitive and easy to navigate, allowing users to quickly and easily find the information they need.


## Built With

The application is built using the Swift language and used the Swift Package Manager for managing dependencies. The user interface is designed using Storyboards. Core Data is used to provide data persistence, which allows the app to save and retrieve data even when closed. The Model-View-ViewModel design pattern is used to separate the data and logic of the application from the visual elements, making it easier to maintain and update the codebase.

## Usage

<div style="display: flex;">
  <div style="flex: 1; text-align: center;">
  <h5> Home Screen </h5>
    <img src="https://i.imgur.com/I7j6by6.png" width="300" height="570">
    <p>This screen displays a list of games, which serves as the main screen of the application. Users can view the list of games and filter them by category. They can also search for games by their names. The screen features a tableview, a UISearchBar and an ImageView, which are used to display the games. The layout of the screen is designed to provide an easy and intuitive way for users to access and navigate through the list of games. Users can filter the games according to the categories, search the games by their names and can see the game's images on the screen.</p>
  </div>
  <div style="flex: 1; text-align: center;">
  <h5> Detail Screen </h5>
    <img src="https://i.imgur.com/elnuqI1.png" width="300" height="570">
    <p>This screen displays detailed information about the selected game. Users can view the game's name, image, genre, release date, and number of reviews. The screen also has a star button, which allows users to add the selected game to their favorites. A comment button is also provided that redirects users to the commenting screen. Users can view the game's details and add it to their favorite list, or they can add notes to the game. The layout of the screen is designed to provide a clear and easy to understand overview of the game's information, making it easy for users to access all the details they need.</p>
  </div>
  <h5> Favorite Screen </h5>
  <div style="flex: 1; text-align: center;">
    <img src="https://i.imgur.com/0AiAwDy.png" width="300" height="570">
    <p>This screen displays a list of the user's favorite games. Users can view the details of the games they have marked as favorite, including the name, image. The screen is designed to easily access the user's favorite games and manage them according to their preferences. Built using Tableview.</p>
  </div>
   <h5> Note Add Screen </h5>
  <div style="flex: 1; text-align: center;">
    <img src="https://i.imgur.com/9nqKl5U.png" width="300" height="570">
    <p>This screen allows users to add notes to the selected game. Users can add a title and a description of their notes. This screen is designed to make it easy for users to add notes to the games they are interested in and to keep track of their thoughts and opinions about the games. This process is done using Core Data. If the note is successfully sent, a notification will be sent to the user.</p>
  </div>
   <h5> Note Screen </h5>
  <div style="flex: 1; text-align: center;">
    <img src="https://i.imgur.com/Mr5ilrp.png" width="300" height="570">
    <p>This screen allows users to view the notes they have added to games. Users can see the title and the description of the notes. They also have the ability to edit and save their selected notes or delete them. The screen is designed to provide a simple and easy way for users to view and manage their notes about the games. The notes are retrieved from the device's Core Data storage and displayed on the screen.</p>
  </div>
</div>



## License

Distributed under the MIT License. See [LICENSE](https://github.com/mehmetalidemir/VideoGamesApp/blob/main/LICENSE.md) for more information.

## Authors

* **Mehmet Ali Demir** - *iOS Developer* - [Mehmet Ali Demir](https://github.com/mehmetalidemir) - **


