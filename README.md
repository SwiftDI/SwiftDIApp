# SwiftDIApp

An iOS app using the [`SwiftDIHLP`](https://github.com/alexbasson/SwiftDIHLP) high-level policy module for all business logic.

## Notes about Cocoapods vs. Swift Package Manager

As of this writing, iOS apps do not support the Swift Package Manager. As such, `SwiftDIApp` uses [Cocoapods](https://cocoapods.org) to manage its dependencies.

This has some inconvenient consequences (the need to re-specify the Framework Search Paths after each `pod install` being one of them; see below in the Installation section). In the long-term, it is hoped that iOS apps will support SwiftPM, at which point `SwiftDIApp` can abandon Cocoapods in favor of SwiftPM.

## Installation

- If you haven't installed `SwiftDIApp` as part of `SwiftDI`, clone it to your local machine:

    ```bash
    $ git clone https://github.com/alexbasson/SwiftDIApp.git
    $ cd SwiftDIApp
    ```

- Install the Cocoapods dependencies (this assumes you've already installed [the Cocoapods gem](https://cocoapods.org)):

    ```bash
    $ pod install
    ```

- Open `SwiftDIApp.xcoworkspace` (**not** `SwiftDIApp.xcodeproj`) in Xcode.

- Click on the `Pods` project and locate the `SwiftDIHLP` target. Click on 'Build Settings' and in the search box, search for "framework search paths". Double-click on the Framework Search Paths settings and add the following line:

    ```
    $(PLATFORM_DIR)/Developer/Library/Frameworks
    ```

    This allows the SwiftDIHLP project to find `XCTest.framework` testing framework necessary for testing the repository contract tests.

    **Important:** You will have to repeat this step every time you run `pod install`, as Cocoapods will overwrite the change to the framework search paths.

## Building and Running

In Xcode, `Cmd-B` builds the project; `Cmd-R` runs the app in the iOS Simulator.

## Testing

In Xcode, `Cmd-U` runs the tests.
