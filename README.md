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
To run this project, use the command:

```
make install
```

This project is integrated with `Fastlane`, so this command will install all dependencies listed in the local `Gemfile` and also perform a `pod install`. 

## Tests
This project implements a comprehensive number of unit tests, written with `XCTest`. To mock `Alamofire`'s fetch and response, `Mocker` is being used. And to test components that are binded with `RxSwift` or `RxCocoa`, `RxTest` and `RxBlocking` is used. 

In order to see coverage, use the command `make coverage_report`. This command will use `slather` to produce test coverage percentage visually. `scan` command on `Fastfile` is using `iPhone 8, OS: 15.4`, make sure you have this simulator in your xcode, if not change `Fastfile` accordingly. 
