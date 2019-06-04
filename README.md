# DOOR-DELIVERY
 DOOR-DELIVERY is an iOS application which shows list of deliverables that can be ANYTHING and delivered to ANYWHERE.
 The customer address is shown on Apple Map along with the customer name.


# Requirements

* Xcode 10.2, iOS 12.2 SDK or later, OS X 10.14 or later.


# Installation

To run the project :
- a) Navigate to root folder of the project. 
- b) Open the terminal and cd to the directory containing the Podfile
- c) Delete the existing Podfile.lock, Pods, and Assignment.xcworkspace file if exists
- d) Run the "pod install" or "pod update"command
- e) Open xcworkspace and run the app 


# Design Pattern
VIPER



What is Viper ?
Viper is a design pattern that implements ‘separation of concern’ paradigm. For each module VIPER has five (sometimes four) 
different classes with distinct roles. No class go beyond its sole purpose. 
These classes are following.

View: Class that has all the code to show the app interface to the user and get their responses. 
Upon receiving a response View alerts the Presenter.

Presenter: Nucleus of a module. It gets user response from the View and work accordingly. 
Only class to communicate with all the other components. Calls the router for wire-framing,
Interactor to fetch data (network calls or local data calls), view to update the UI.

Interactor: Has the business logics of an app. Primarily make API calls and local storage to fetch or save data.

Responsible for making data calls but not necessarily from itself.

Router/Wireframe: Does the wire-framing. Listens from the presenter about which screen to present and executes that.

Entity: Contains plain model classes used by the interactor.



# Version

1.0

# Support Version

*  iOS 10.x or later


# Language

* Swift 5


# Pods

* Alamofire
* SwiftyJSON
* NotificationBannerSwift
* SDWebImage
* SwiftLint
* OHHTTPStubs/Swift
*  Fabric
*  Crashlytics


# Data Caching

* Core Data is used for offline storage of items.
* For image cache, SDWebImage is used. It is an async image downloader with cache support.
* It has “Pull to Refresh” functionality which will always return the updated data from server.


# Assumptions        

1. The app is designed for iPhones and with portrait mode.     
2.  App localization is implemented. However, currently, only the English language is supported. 
3.  Supported mobile platforms are iOS (11.x, 12.x)        
4.  Device support - iPhone 5s, iPhone 6 Series, iPhone SE, iPhone 7 Series, iPhone 8 Series, iPhone X Series    
5.  iPhone app support would be limited to portrait mode.
6.  Data caching is working in the following way
   - a) On launch when displaying list,initially local cache is checked for data
   - b) If the local cache is empty ,then the data is retrieved from server otherwise the data is displayed from cache.
   - c) On pull to refresh,delivery list is pulled from server and then saved or updated to local cache
   - d) If any cached data is deleted from the server then local cache data will not delete.
   - e) On paging,if the data is present in core data for that offset,then it is displayed otherwise fetched from server.



# Crashlytics

Fabric Crashlytics has been already integrated in the application to get the crash reports. All the crash reports can be checked on fabric dashboard. Follow the below steps and just replace the Fabric API Key in info.plist file
1. Create an account here: https://fabric.io/kits/ios/crashlytics/install and register the app.
2. follow the steps on the given link.
3. Replace the Fabric API Key in info.plist file.


# SwiftLint

It is tool to enforce Swift style and conventions. It is integrated using CocoaPod.
Any changes can be made in .swiftlint.yml file, which is located in project root folder.

# Code Coverage
- Just need to run Test on Xcode ( cmd+U )


# Unit Testing
* Unit Test cases are written using XCTestCase,XCTest,XCUITest


# Screenshots

![Simulator Screen Shot - iPhone Xʀ - 2019-05-29 at 14 09 02](https://user-images.githubusercontent.com/31967294/58542511-5d25d880-821b-11e9-8d55-51de89b2d5eb.png)

![Simulator Screen Shot - iPhone Xʀ - 2019-05-29 at 14 09 12](https://user-images.githubusercontent.com/31967294/58542517-60b95f80-821b-11e9-91bc-cd3c7c8329be.png)

![Simulator Screen Shot - iPhone Xʀ - 2019-05-29 at 14 19 21](https://user-images.githubusercontent.com/31967294/58543314-deca3600-821c-11e9-886f-354dd39bb67d.png)









