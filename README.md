# Global Time

## Introduction

This project supports the module _Animation II - Advanced Drawing_ in the sprint _iOS User Interface_.

Today's project is to use the `ClockView` we built today and recreate the World Clock tab of the Apple Clock app. You'll present the user with a list of time zones and once chosen, you'll display a table of cells containing the time zone name and a clock view displaying the time for that zone.

## Instructions

### Project Setup

* Create a new single view application project named "Global Time".
* Discard the view controller scene in the storyboard and its associated class.
* Copy in the `ClockView.swift` file from today's guided project (or from this repo).

### Storyboard Tasks

#### GlobalTimesTableViewController
* Create a table view scene embedded in a navigation controller. Use the custom cell style.
* Make the cell height for the entire tableview 100 pts (click the tableview in the document outline, go to the size inspector and change the row height).
* Design a cell with a label for the time zone name, and a UIView to show the clock view instance. After you set the cusom class of that view to `ClockView`, you should see a live preview of the clock face (w/ hands at 12). Be sure to add enough rules to properly constrain each subview (and remember UIView objects have no intrinsic size, so x, y, with, and height will need to be constrained).
* Add a bar button item and set it to the buit in system item style of "add".

#### TimeZonesTableViewController
* Create another table view controller scene, embed that one in its own navigation controller, and then create a segue between the + button and the navigation controller you just created. Choose `present modally` for the segue kind.
* Use the built in cell style `basic` for this other table view controller (also standard cell height is fine).
* Add a bar button item to the navigation bar (or optionally to a toolbar), and use the system item type "cancel".

### Code Tasks

* Create 3 files:
    * `GlobalTimesTableViewController`
    * `ClockTableViewCell`
    * `TimeZonesTableViewController`
* Go back to the storyboard and set the custom class of the two scenes to their appropriate classes. Also set the custom class of the custom cell to `ClockTableViewCell"`."

#### ClockTableViewCell.swift
* Create IBOutlets for the two subviews of the custom cell.
* Go back to the storyboard, in the custom cell, and wire up these outlets to their appropriate views within the cell.

#### GlobalTimesTableViewController.swift
* Create a protocol above the class definition for sending a selected time zone back to this view controller. Name it `TimeZoneDelegate` and declare a single required function: `didChooseTimeZone(_ timezone: String)`.
* Create an extension of the view controller class at the bottom of the file for protocol conformance. Make the class conform to the delegate you just defined, and implement the required function (just stub it out for now).
* Create an array property in this view controller to hold the selected time zone identifiers the users picks from the other view. The identifiers are of type `String`.
* Give the view a title that will display in the navigation bar.
* The `TimeZone` class has an accessor called `current` that will fetch the user's current time zone. Use it and a property of that time zone called `identifier` to fetch the ID of the current time zone. Append that to the array you created above in `viewDidLoad`. This will cause the view to always load with 1 cell showing the user's current zone and time.
* Configure the table view to display cells from the array you created above.
* In `tableView(_:cellForRowAt:)`:
    * Dequeue a cell using the identifier you set in the storyboard (also the cell will need to be cast as the custom type you created).
    * Grab the appropriate time zone ID from the array property.
    * Look at the `TimeZone` class and see how to initialize a `TimeZone` object from an identifier.
    * Assign that time zone object to `cell.clockView.timezone`. This will trigger the clockview to show the correct time for that zone.
    * Look at the time zone identifier you pulled out of the array. The string is set up like this: "continent/country/city" or "continent/city". Since "city" is always last in the string, and each part is separated by "/", use string manipulation techniques to extract just the city name and display that in the label of the cell.
* Lastly, uncomment the `prepare(for:sender:)` method and assign the segue's destination object an instance of `self` for its `delegate` property (which doesn't exist yet, so you'll get an error for now). Beware, the destination of the segue object is whatever view controller is on the end of the segue from the storyboard. In this app, that is an instance of `UINavigationController`, so you'll need to dig through the view hierarchy to reach the object you actually want (`TimeZonesTableViewController`).

#### TimeZonesTableViewController.swift

* Create a constant property that contains the `knownTimeZoneIdentifiers` from the `TimeZone` class. It's an array of strings and represents every time zone based on geopolitical region.
* Create a mutable property called `delegate` that is of the protocol type you created in the other view controller. Make it optional.
* Set up the table to display cells from the above array property.
* In `tableView(_:cellForRowAt:)`:
    * Dequeue a cell using the identifier you set in the storyboard.
    * Grab the appropriate time zone identifier from the array property.
    * The string that's fetched looks just like it did in the other table. We also want to only display the city name in this table for each one. Grab the same code you used in the other table to parse out the city name and display it in the `textLabel` of this cell.
* Override the function `tableView(_:didSelectRowAt:)` and do two things:
    * Deslect the row using the `indexPath` passed in.
    * Call your delegate method and pass the appropriate time zone identifier from the array property (hint: use the `indexPath` for this too).
* Create an `IBAction` method that responds to taps of the cancel button. In the method body, just dismiss the view (remembering that this view is embedded in a navigation controller, so it is the view that needs to be dismissed so the whole view stack will transition away).
* Wire up that action to the cancel bar button item in the storyboard.

#### GlobalTimesTableViewController.swift
* It's time to fill out the delegate method. In `didChooseTimeZone(_:)`:
    * Call `dismiss(animated:completion:)` to dismiss the view stack (the modal).
    * Append the selected time zone to the array property of selected time zones.
    * Instruct the table view to reload its data.


### Go Further

* Using the appearance concepts we learned about in the first module of this week, create a dark mode for this app that darkens the entire UI. Use colors you think make it easier to read in either light or dark conditions.
* Make the clock face of each cell display either a light or dark color depending on whether the sun has set for that location. You are not required to actually get the exact sunrise/sunset times for each location, just choose a reasonable set of values (e.g. 8:00 PM local for sunset, 7:00 AM local for sunrise).
* Add the ability to remove clock cells from the table.
