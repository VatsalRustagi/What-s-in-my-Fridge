# What-s-in-my-Fridge
An iOS app to take note and keep track of food items in the fridge and in how many days it expires.

- Easily add food items, just enter the name and in how many days it will expire and it will appear in the tableView below.

![simulator screen shot aug 29 2017 8 09 07 pm](https://user-images.githubusercontent.com/26324291/29853703-49255a8e-8cf6-11e7-9a99-34191a5ad46f.png)

- Entered something wrong? Just click on the cell and edit the details and save it. You have the option to delete a particular food item here as well.

![simulator screen shot aug 29 2017 8 09 20 pm](https://user-images.githubusercontent.com/26324291/29853707-4b0f94c2-8cf6-11e7-82e6-35d93d3aeabd.png)

- Threw away all the food? Click on the plus button and clear all the items in the list.

![simulator screen shot aug 29 2017 8 11 26 pm](https://user-images.githubusercontent.com/26324291/29853713-4d406640-8cf6-11e7-993a-e6d9bd4dfa9b.png)

Inspiration: I could not keep track of the food in my fridge when I get too busy with work. This results in the food items going bad in the fridge. Therefore to solve my problem I made this app to keep track of these food items.

Implementation:
- Heavily used CoreData to save the data in the app, that is the data is not lost even after the user restarts the app.
- Implemented NSFetchResultController and its delegate to maintain the insert, update, delete and move type of operations when editing the tableView data.
- Integrated tableView with CoreData.
- Implemented RevealingSplashView and Floaty pods to enhance the user interface.
             
