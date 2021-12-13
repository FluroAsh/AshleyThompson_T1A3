# Statement of Purpose & Scope mag
## High level Description
At a high level this application will contain a variety of features that predominately serve to navigate a movie API and present this information in an easy to digest way, with various manipulation applied to the data in accordance with the **user**'s search query (which will be provided in the context of movie *title*).
## The Problem & Why It's Being Developed
Imagine you're looking through IMDB for all movies that contain the keyword **Batman** but you want a quick overview of all Batman movies alongside various information such as **Director**, **Runtime**, **Genre** and so on. It gets a bit tedious having to click on each title to get the above information, doesn't it? 

Well fortunately the **movie-app** application  can be executed easily and will allow the user to pull information from an API, having it displayed in a convenient and meaningful way that provides said information. Now you can easily navigate through the whole consortium of Batman movies, review the plot and find the perfect late-night flick for yourself without tedious web browsing! 
## Who Is This For?
The user(s) this application is most appropriate for are movie enthusiasts that enjoy finding new things to watch, with a knowledge of what is currently viewable in the public domain (as there is no feed implementation to provide new releases etc). The application also provides said movie enthusiast with the flexibility of easily being able to filter through useful information as above, to make informed choices on what to watch and to compile a list of favourite movies for later reference! 
## How Will A User... Use it?
The above user will make use of the application by entering a movie title which will concatenated into a link that will search through our API and return a list of **movie-items** that contain relevant information for the user. When they receive this information they will have the option to select one of these movies and append it to a **favourites list**. 


# ~List of Features
1. User **login** feature
   1. Allows user to enter **Username** + **Password** to retrieve associated relevant *favourite* movies
   2. No actual database implementation, simply stored in the form of JSON document

2. __Search__ [movie-database](https://rapidapi.com/rapidapi/api/movie-database-imdb-alternative/) for matching Title that is input by the user

3. Allow to select & store a **favourite movie**, attaching it to their Username 
   1. Stored in separate file 
   2. Can only retrieve favourites if logged in

4. Navigation by utilising the [tty-prompt](https://github.com/piotrmurach/tty-prompt) gem
   1. Allows user to easily navigate through various options to continue/change/break flow of the application
   2. Added bonus, using `.mask` method user will have their password masked when prompted at time of input!

# Outline of User Interaction and Experience for 'Movie-App'
## How Will User Find Out How to Interact with Each Feature
The user can find out how to interact with each feature by following the prompts. [tty-prompt](https://github.com/piotrmurach/tty-prompt) does an excellent job at guiding the user visually through various methods such as giving them selectable options that help guide the control flow of the application based on what the user would like to do — styling these options with symbols and colors.

Additionally, there will be various prompts for the user to enter input into the application, as an example — the user will also be presented  

## How User will Interact with Each Feature
The user will interact with each feature via the [tty-prompt](https://github.com/piotrmurach/tty-prompt) interface, selecting various options that dictate the flow of the application. The first stage is the login feature which will allow dynamic retrieval of user data (favourites, as-well as validation of their credentials). 

At various stages of the applications run-time it will prompt the user for input to retrieve data from the [movie API](https://rapidapi.com/rapidapi/api/movie-database-imdb-alternative/) and subsequently display it to the user, allowing them to store a movie item into the favourites.txt document that will be later used to retrieve a list of the user's preferences. 

## How Errors Will be Handled
Errors will be predominately handled by the `rescue` method, by catching errors as they arise in blocks of code. Alternatively, errors will be prevented/handled by anticipating how the user will interact with the application and diverting the control flow in a way that allows the user to continue their interaction without exiting (eg: failing a login attempt, and being able to retry).

# Control Flow Diagram
This control flow diagram serves to express what the application intends to do, how the user will interact with it and show the overall process from start to finish given various divergences in the control flow. The diagrams logic may be subject to slight change during the development process to facilitate better user experience and optimisation.
![Control Flow Diagram](../docs/../AshleyThompson_T1A3/docs/control-flow-diagram.png)

# !Develop an Implementation Plan
## Which will: 

- outlines how each feature will be implemented and a checklist of tasks for each feature
- prioritise the implementation of different features, or checklist items within a feature
- provide a deadline, duration or other time indicator for each feature or checklist/checklist-item

1. Menu System
   
   *Implementation*
   - [x] Login/Create/Exit
   - [ ] Save prompts for confirming writing data to file
   - [ ] Loop back to appropriate menu when input error raised
   - [ ] Select `Display/Store` favourite movie
   - [ ] Search again prompt

   *Deadline*
   - December 15th, 2021

2. Login Feature

   *Implementation*
   - [x] Check if Username exists
   - [x] Prompt User to create account
   - [x] Basic password validation *(8 characters, 1 number)*
   - [x] Validate user login
   - [x] Create login details
   - [x] Mask password at time of input
   - [x] Store in JSON — `{username: password}`

   *Deadline*
   - December 13th, 2021

3. Movie Database Search

   *Implementation*
   - [ ] Successful request to API
   - [ ] Search User input via API
   - [ ] Return JSON data
   - [ ] Parse JSON data
   - [ ] Initialize variables into menu_items

   *Deadline*
   - December 16th, 2021

4. Archive Favourite Movie(s)
  
   *Implementation*
   - [ ] Execute method based on whether user chooses to **display/store** favourites
   - [ ] Store correct Username, Title & Year in `favourites.txt`
   - [ ] Retrieve Username, Title & Year from `favourites.txt`
   - [ ] Display list of favourites
   - [ ] Prompt user to create new search

   *Deadline*
    - 17th December, 2021

The current method to track this implementation plan will be done through a [Trello board](https://trello.com/b/W2bSAate/t1a3ashleythompson).

> Your checklists for each feature should have at least 5 items.

# Help Documentation
## Installation
To install this application clone the repo into your current directory by using the `git clone` command:

    $ git clone git@github.com:FluroAsh/AshleyThompson_T1A3.git

## Usage
You can either run the application through a shell terminal using:
    
    $ ruby movie-app.rb
or alternatively execute the run bash script which will automate this for you:

    $ ./run.sh

To execute either of these commands your current directory must be `src`.
## Dependencies 
    $ ./install-dependencies
This will install the required gems for the application to run without errors.

The required gemlist includes:
- [colorize](https://github.com/fazibear/colorize)
- [terminal-table](https://github.com/tj/terminal-table)
- [tty-prompt](https://github.com/piotrmurach/tty-prompt)
- [rspec](https://github.com/rspec/rspec-core)
- [whirly](https://github.com/janlelis/whirly)
- [paint](https://github.com/janlelis/paint)

## System/Hardware Requirements
Minimum Requirements:
- 32-bit OS
- 1GHz Processor or faster
- 2GB Ram
- 1GB of HDD space
## Supported Operating Systems
- Windows 
- Linux
- MacOS
### Supported:

You must include:
- steps to install the application
- any dependencies required by the application to operate
- any system/hardware requirements