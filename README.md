# MarvelHeroes

## Table of contents
* [General info](#general-info)
* [Architecture](#architecture)
* [Frameworks](#frameworks)
* [Setup](#setup)
* [Tests](#tests)

## General info
A simple project using Marvel API to fetch a list of characters and then displaying their details.
	
## Architecture

This projects implements Clean Architecture and also MVVM in the presentation layer. 
In order for the presentation layer to work reactivity, RxSwift is implemented. 
Coordinator pattern is being used as the main navigation strategy.

## Frameworks
This project is using the following pods:
* RxSwift and RxCocoa
* Alamofire
* Kingfisher

Also, for testing purposes only, the project is also using:
* RxBlocking
* RxTest
* Mocker

`Swiftlint` is also configured in this project as a Pod.

## Setup
To run this project, install the CocoaPods dependencies first, using:

```
pod install
```

This project is integrated with `Fastlane`, so you can also use `make install` to install the dependencies.

If `fastlane` is not installed, it's possible to use the local `Gemfile` to install it, using:

```
gem install
```

## Tests
This project implements a comprehensive number of unit tests, written with `XCTest`. To mock `Alamofire`'s fetch and response, `Mocker` is being used. And to test components that are binded with `RxSwift` or `RxCocoa`, `RxTest` and `RxBlocking` is used. 

In order to see coverage, use the command `make coverage`. This command will use `slather` to produce test coverage percentage visually. 
