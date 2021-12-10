# Statement of Purpose & Scope
## High level Description
At a high level this application will contain a variety of features that predominately serve to navigate a movie API and present this information in an easy to digest way, with various manipulation applied to the data in accordance with the **user**'s search query (which will be provided in the context of movie *title*).
## Identify the Problem It Will Solve & Explain Why You Are Developing It
Imagine you're looking through IMDB for all movies that contain the keyword **Batman** but you want a quick overview of all Batman movies alongside various information such as **Director**, **Runtime**, **Genre** and so on. It gets a bit tedious having to click on each title to get the above information, doesn't it? 

Well fortunately the **movie-app** application  can be executed easily and will allow the user to pull information from an API, having it displayed in a convenient and meaningful way that provides said information. Now you can easily navigate through the whole consortium of Batman movies, review the plot and find the perfect late-night flick for yourself without tedious web browsing! 
## Identify the Target Audience
The user(s) this application is most appropriate for are movie enthusiasts that enjoy finding new things to watch, with a knowledge of what is currently viewable in the public domain (as there is no feed implementation to provide new releases etc). The application also provides said movie enthusiast with the flexibility of easily being able to filter through useful information as above, to make informed choices on what to watch and to compile a list of favourite movies for later reference! 
## Explain How a Member of the Target Audience Will Use It
The above user will make use of the application by entering a movie title which will concatenated into a link that will search through our API and return a list of **movie-items** that contain relevant information for the user. When they receive this information they will have the option to select one of these movies and append it to a **favourites list**. 


# ~List of Features
1. User **login** feature
   1. Allows user to enter **Username** + **Password** to retrieve associated relevant *favourite* movies
   2. No actual database implementation, simply stored in the form of JSON document

2. __Search__ [movie-database](https://rapidapi.com/rapidapi/api/movie-database-imdb-alternative/) for matching Title that is input by the user

3. Allow to select & store a **favourite movie** and attach it to their credentials 
   1. Stored in separate file 

4. Navigation by utilising the [tty-prompt](https://github.com/piotrmurach/tty-prompt) gem
   1. Allows user to easily navigate through various options to continue/change/break flow of the application
   2. Added bonus, using `.mask` method user will have their password masked when prompted at time of input!

# !Develop an Outline of the User Interaction and Experience for the Application
## How Will User Find Out How to Interact with Each Feature

## How User will Interact with Each Feature

## How Errors Will be Handled
## Must include: 

- how the user will find out how to interact with / use each feature
- how the user will interact with / use each feature
- how errors will be handled by the application and displayed to the user

# !Diagram that describes the control flow
## Must:
- show the workflow/logic and/or integration of the features in your application for each feature.
- utilise a recognised format or set of conventions for a control flow diagram, such as UML.

# !Develop an Implementation Plan
## Which will: 

- outlines how each feature will be implemented and a checklist of tasks for each feature
- prioritise the implementation of different features, or checklist items within a feature
- provide a deadline, duration or other time indicator for each feature or checklist/checklist-item
1. F1
2. F2
3. F3

The current method to track this implementation plan will be done through a [Trello board](https://trello.com/b/W2bSAate/t1a3ashleythompson).

> Your checklists for each feature should have at least 5 items.

# Help Documentation
## Installation
To install this application you can clone the repo into your current directory by utilising the `git clone` command:

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