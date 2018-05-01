#  Homework Buddy

## Introduction
Homework Buddy is a Homework tracking application that allows users to add different classes and different homework assginments. Each homework assignment is associated with a class and has a title, description, due date and alert time.


## Things that were used
* Collection views
* Table views
* Tab bars
* Core Data
* Notifications
* Manual segues

## Features
* Data stored in **Core Data**
* **Notification** with direct segue to the asociated homework assignment.
* Color coded classes.
* Today tab to show homework assginments that are due a current date.
* Homework tab to show all homework classes
* Classes tab to show all user classes

## How to
How to use homework buddy

### Adding new classes
In order to add new classes
* Select the classes tab item
* Tap the **+** button
* Input the class name and tap add

![Alt Text](https://github.com/jir-f/Homework-Buddy/raw/master/Gifs/Add-Class.gif)


### Deleting a class
**Deleting a class will remove all homeworks**
* Select the classes tab item
* Tap the **Edit** button
* Edit mode will turn on
* Tap the **x** icon on the classes that you wish to delete
* Confirm that you want to delete the class
* Deleting a class will remove it from core data*

![Alt Text](https://github.com/jir-f/Homework-Buddy/raw/master/Gifs/Delete-Class.gif)


### Add a new homework
* Select the classes tab item
* Select the class that you want to add a homework to
* Tap the **+** button
* Enter the homework information
* Tap add homework

![Alt Text](https://github.com/jir-f/Homework-Buddy/raw/master/Gifs/Add-Homework.gif)

### Deleting a homework
#### Method 1
* From the classes tab select the classes that you wish to delete the homework from
* From the table, swipe left on the homework cell
* Confirm the deletion
* Homework deleted!

![Alt Text](https://github.com/jir-f/Homework-Buddy/raw/master/Gifs/Delete-Homework.gif)


#### Method 2
* In the homework detail view
* Tap the complete button 
* Confirm the completion
* Homework removed

![Alt Text](https://github.com/jir-f/Homework-Buddy/raw/master/Gifs/Complete-Homework.gif)


### Notifications
* When a homework is being added, the user enters a alert time
* Notifcation will be pushed to the user 
* Tapping on the notification will segue to the detail view of the homework

![Alt Text](https://github.com/jir-f/Homework-Buddy/raw/master/Gifs/Notification.gif)

