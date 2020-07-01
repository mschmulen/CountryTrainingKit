CountryTrainingKit
===

*WIP* Flag trainging using Core ML

# Overview

Objective: investigate machine learning to present flag game challenges that are appropriate for the specific player.

Present a flag challenge to any given player in gradual progression of difficulty, easy country flags first and more difficult flags as the user progresses.

# Getting Starting 

- git clone  git@github.com:mschmulen/CountryTrainingKit.git
- open `DemoApp`
- run `DemoApp`
- experiment with updating the CoreML `CountryFlagGameRegressor.mlmodel` via play events from the game


# CoreML Model

- CreateML project: `CreateMLTools\CountryTabularRegressor.mlproj`
- alternate training playground: `CreateMLTools\CountryTabularRegressorPlayground.playground`
- resultant .ml model used in the appication:  `CountryFlagGameRegressor.ml` 
 
##  training data:  `MLData/flatData_.csv`
 - `playerRegion` : Players current device region setting (`US`, `FR`, `MX`, `CA`, ... )
 - `playerLanguage` : Players current device language setting ( `en`,`es`,`fr`, ... )
 - `playerNumberOfDaysOld` : Age of the player in number of days when the player played the game
 - `numberOfGuesses` : Number of guesses it took for the player to get the correct answer 1...6
 - `countryFlagEmoji` : Flag emoji of the country
 - `deviceAlternateLanguage` : If the user has alternate languages available take the first one (`en`,`es`,`fr`, ... ) or `none`
 - `deviceIdentifierForVendor` : IDFV of the Players current device
  
## ML Info:

ML Target (outputs) :
- `numberOfGuesses` 

ML Fatures (inputs) : 
- `playerRegion`
- `playerLanguage`
- `playerNumberOfDaysOld`
- `countryFlagEmoji`
- `deviceAlternateLanguage`

Notes about ML Algorithms and Metrics:

#### Training, Root Mean Square Error: 

How much each prediction varied from the actual result (squaring + calculating the mean of all the squared errors + square rooting the result  )

The lower the better but we want ~< 1.1. meaning the average model was able to predict the suggested accurate `numberOfGuesses` with an error of only 1.1 guess.

#### Training, Maximum Error: 

TODO


#### TODO : 
- Validation, Root Mean Square Error : 
- Validation, Maximum Error : 
- Testing, Root Mean Square Error : 
- Testing, Maximum Error : 

## How to update the CoreML Model ( ML Pipeline )

#### Overview 


#### Notes

- Using the Create ML project:

- Using the Playground:

Updating the `CountryFlagGameRegressor.ml` model 






