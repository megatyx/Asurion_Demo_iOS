# Asurion_Demo_iOS
A Demo for the at Asurion.
The Design Target is here:

![Design Target](https://github.com/megatyx/Asurion_Demo_iOS/blob/master/Design.png)

The assingment instructions can be found here:

## Quick Notes
I wanted to do this in SwiftUI, however, SwiftUI's update hasn't gone into production yet, so I opted for Storyboard + UIKit.
I tried my best to make things easy and readable. Please contact me if you have any questions about the code.

### CHANGING THE BASE URL
If you are looking to change the baseURL and don't want to read the rest of this document, please go to the following file:

Constants -> APIConstants -> APIRoutes

# Overview
This Demo was created on Swift < 5.0 and iOS 13 utilizing a very small version of MVVM.
The App depends on a heroku server, which might be sleeping on first run. Wait and Refresh if you encounter any issues.
I have two servers deployed. One on Swift Vapor 4, and one on Golang.

BaseURL:
https://tyler-pets-server.herokuapp.com/

Routes:

pets

config

# Views
This app uses 4 custom made xib files. One ViewController and three TableView cells
I refrained from using a TableViewController, and opted for a regular TableView, because I wanted to be more flexible in case I wanted to make changes

## MainViewController
This is the only ViewController and it is tied to the MainFlow Storyboard. You can find both of these files HERE:

AppFlow -> MainFlow

## TableViewCells
The TableView Cells were made flexibly, can be set to nearly any size, survive rotation, and customize based on size classes. They can be found HERE:

Views -> TableViewCells

# Networking
The networking runs on a Protocol Driven Network Layer based on a series of "Networkable" objects.
For simplicity, I make an "APISession()" object to speed work on this demo app.
The networking layer can be found HERE:

NetworkingLayer -> Networking

If you are looking for API specific things and not generic, such as Raw Response Objects that conform to Decodable, you can find that here:

NetworkingLayer -> API


# Unit Tests
I used a small form of TDD, until I started running out of time.
Feel free to check and run the Unit tests. They mostly cover only the Model and its functions.
If I had more time, I'd have liked to do some UI Tests and Unit Tests on the View Model.


# Questions
If you have any quesetions or comments, then feel free to shoot me a message on Github or contact the recuiter

# Sign Off
Thank you for your time and consideration

