# README

## Installation Notes:
 1. you need to run `pod install` in order to fetch Pod folder (it is ignored when pushed in order to reduce size)
 2. open the workspace file 
 3. In `KeyManager` class, replace the value of `placesAPIKey` with your API Key

## How to use the app:
1. You need to provide location consent in the app
2. If you don't, the search button (the update functionality) isn't enabled. However, if you tap on user location update button, you'll be asked for consent again.
3. If you like to change desired radius or keyword (When I ran the app using `surf` keyword, I couldn't receive any response, either on the app or in the browser. That's why I added this so that we can test both), tap on the pencil icon. 
4. If no keyword is provided in the textfield provided, no key words will be used.
5. If places are found, it will be displayed on the map. 
6. Tapping each annotation will display information about the place

## NOTES
1. None of the places I was receiving had opening hours. They mostly had `isOpen` parameter, and I used that instead.
2. If no opening hours was provided, I assumed it to be false.
3. If no rating was provided, I set it to -1, and displayed a relevant information (`No Rating Available`).