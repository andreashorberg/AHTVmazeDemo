# AHTVmazeDemo
Small demo using the TVmaze API 

This sample uses MVVM pattern to free up the view controller from some view logic from the View Controller. Navigation is simple in a single-view app with a searchbar and a UICollectionView that adjusts the number of columns to show depending on orientation and device kind (phone or tablet).

There are no third party frameworks used in this sample as I like to keep dependencies on a must-have basis. 
If a problem is simple enough to do myself or if I need to have good control over the source and understand problems that can arise I prefer to not rely on a third party to fix them.

Network requests return a Swift 5 Result type for a clean way of handling success and failure and uses Codables for converting JSON objects into data models.
The Network layer is very rudimentary and only handles GET as that was the only http method needed for this small demo. It also only handles the 200 OK status code and only returns a handful of different custom errors.
In a real world example this would be expanded to handle many more types of situations and more custom errors.
