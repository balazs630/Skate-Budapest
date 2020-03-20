# Robot Framework Testing with Appium

## Installation

1. [Appium Library](https://github.com/serhatbolsu/robotframework-appiumlibrary) is a testing library for [Robot Framework](https://robotframework.org/#introduction).
It uses Appium (version 1.x) to communicate with Android and iOS application similar to how Selenium WebDriver talks to web browser. 
Install the main package with [Homebrew](https://brew.sh):
```
brew install python
pip3 install robotframework-appiumlibrary
```

2. Install [Appium](http://appium.io) desktop application to be able to start an Appium server locally.
The application has a live Inspector to easily identify/find elements on the iOS Simulator by Accessibility IDs or XPaths which is a very nice feature:
```
brew cask install appium
```

3. Appium drives mobile apps using the WebDriver protocol. [WebDriverAgent](https://github.com/facebookarchive/WebDriverAgent) is a WebDriver server implementation for iOS that is used to remote control iOS devices behind the scenes.
WebDriverAgent (part of Appium) is using Carthage to fetch all dependencies:
```
brew install carthage
```

For editing .robot files I recommend using [PyCharm CE](https://www.jetbrains.com/pycharm/download/):
```
brew cask install pycharm-ce
```
In PyCharm, install `Robot Framework Support` plugin for sytax highlight and auto complete.


## Running tests

1. Open the Appium app, select `Start Server`
2. Double click on `run.command` or execute it from Terminal: `sh run.command`
3. See test results in the `/output` folder

## Documentation

* AppiumLibrary: https://serhatbolsu.github.io/robotframework-appiumlibrary/AppiumLibrary.html
* Robot Framework User Guide: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html
