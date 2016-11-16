# Raclette
[![](http://img.shields.io/badge/ios-8.1+-FC3159.svg)]()
[![](http://img.shields.io/badge/swift-3.0-FD9426.svg)]()
[![](http://img.shields.io/badge/xcode-8.0-157EFB.svg)]()
[![](https://img.shields.io/badge/cocoapods-compatible-53D769.svg)](https://github.com/cocoapods/cocoapods)
[![](https://img.shields.io/badge/license-MIT-lightgrey.svg)](http://mit-license.org)
[![](https://travis-ci.org/rmnblm/Raclette.svg?branch=master)](https://travis-ci.org/rmnblm/Raclette)


🧀 **Raclette** is a simple `UITableView` manager to add sections and rows on-the-fly.

> Raclette (pronounced _ruck-lett_ in English) is a national dish of Switzerland. The traditional dish can be described as melted cheese eaten with boiled (or roasted) potatoes with small gherkins and pickled onions.

* [Quick Start](#quickstart)
* [Features](#features)
* [Installation](#installation)
* [Documentation](#documentation)
* [Credits](#credits)



## Quick Start

Raclette makes it easy for you to mutate your `UITableView` in a few seconds. 

**Example**

``` swift
tableView.createSection { section in 
	section.headerTitle = "Section Header"
    section.footerTitle = "Section Footer"
    section.createRow { row in
      	row.configuration = { cell in
          	cell.textLabel?.text = "Hello World!"
      	}
    }
}
```



## Features

* Integrates easily as an extension for your existing `UITableView`
* Support for dynamic cell height
* Support for inline closures to reduce code
* Use your own cells inheriting from `UITableViewCell`
* Reusing cells by it's identifier is magically managed for you ✨
* Redirection for `UIScrollViewDelegate`
* No need to worry about `UITableViewDelegate` and `UITableViewDataSource`





## Installation

Raclette is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Raclette'
```



## Credits

Raclette was heavily inspired by [Shoyu](https://github.com/yukiasai/Shoyu), [TableManager](https://github.com/Morbix/TableManager) and [Hakuba](https://github.com/nghialv/Hakuba).