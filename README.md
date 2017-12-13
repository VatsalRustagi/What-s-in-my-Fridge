<h1 align="center">What's in my Fridge</h1>
## An iOS app to take note and keep track of food items in the fridge and in how many days it expires.

> Inspiration: I could not keep track of the food in my fridge when I get too busy with work. This results in the food items going bad in the fridge. Therefore to solve my problem I made this app to keep track of these food items.

### Implementation:
- Heavily used CoreData to save the data in the app, that is the data is not lost even after the user restarts the app.
- Implemented NSFetchResultController and its delegate to maintain the insert, update, delete and move type of operations when editing the tableView data.
- Integrated tableView with CoreData.
- Implemented RevealingSplashView and Floaty pods to enhance the user interface.

## Screenshots

<table style="width:100%">
  <tr>
    <td>
      <img src="https://user-images.githubusercontent.com/26324291/29854044-6af30c54-8cf8-11e7-8a66-bae73afa0120.png" width="400">
    </td>
    <td align="center">
      Easily add food items, just enter the name and in how many days it will expire and it will appear in the tableView below.
    </td>
  </tr>
  <tr>
    <td align="center">
      Entered something wrong? Just click on the cell and edit the details and save it. You have the option to delete a particular food item here as well.
    </td>
    <td>
      <img src="https://user-images.githubusercontent.com/26324291/29854050-6fa12a24-8cf8-11e7-9f59-81dc84d581f4.png" width="400">
    </td>
  </tr>
  <tr>
    <td>
      <img src="https://user-images.githubusercontent.com/26324291/29854051-7255e944-8cf8-11e7-88cd-78c6d7399340.png" width="400">
    </td>
    <td align="center">
      Threw away all the food? Click on the plus button and clear all the items in the list.
    </td>
  </tr>
</table>




             
