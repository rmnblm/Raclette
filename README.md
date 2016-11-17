# 🧀 Raclette
[![](http://img.shields.io/badge/ios-8.1+-FC3159.svg)]()
[![](http://img.shields.io/badge/swift-3.0-FD9426.svg)]()
[![](http://img.shields.io/badge/xcode-8.0-157EFB.svg)]()
[![](https://img.shields.io/badge/cocoapods-compatible-53D769.svg)](https://github.com/cocoapods/cocoapods)
[![](https://img.shields.io/badge/license-MIT-lightgrey.svg)](http://mit-license.org)
[![](https://travis-ci.org/rmnblm/Raclette.svg?branch=master)](https://travis-ci.org/rmnblm/Raclette)


**Raclette** is a simple `UITableView` extension to add sections and rows on-the-fly.

> Raclette (pronounced _ruck-lett_ in English) is a national dish of Switzerland. The traditional dish can be described as melted cheese eaten with boiled (or roasted) potatoes with small gherkins and pickled onions.



## Contents

* [Quick Start](#quickstart)
* [Features](#features)
* [Installation](#installation)
* [Documentation](#documentation)
* [Credits](#credits)
* [License](#license)




## Quick Start

Raclette makes it easy for you to mutate your `UITableView` in seconds. 

**Example**

``` swift
tableView.createSection { section in 
	section.headerTitle = "My section header"
    section.footerTitle = "My section footer"
    section.createRow { row in
      	row.configuration = { cell in
          	cell.textLabel?.text = "Hello World!"
      	}
    }
}
```

**Result**

 ![quickstart_result](Resources/quickstart_result.png)



## Features

* Integrates easily as an extension for your existing `UITableView`
* Support for dynamic cell height
* Support for inline closures to reduce code
* Use your own cells which inherit from `UITableViewCell`
* Reusing cells by it's identifier is magically managed for you ✨
* Redirection for `UIScrollViewDelegate` available
* No need to worry about `UITableViewDelegate` and `UITableViewDataSource`





## Installation

Raclette is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Raclette'
```



## Documentation

### Rows

Rows can either be added to a table with or without specifying a section. If you don't specify a section, Raclette adds the row to the last section of the table. If you didn't add a section before, Raclette creates a default one for you.

You have three options to add a row:

**Create a row, configure it and add it to the table**

```swift
var row = Row()
row.height = 50
tableView.addRow(row)
```

**Add a default row and configure later**

```swift
var row = tableView.addRow()
row.height = 50
```

**Create, configure and add a row (preferred)**

``` swift
tableView.createRow { row in
	row.height = 50
}
```

### Cells

Cells are the actual UI representation of a row.

**Dynamic Height**

Enabling dynamic height is quite straight forward with a default `UITableViewCell`.

```swift
tableView.createRow { row in
  	row.dynamicHeight = true
  	row.configuration = { cell in
  		cell.textLabel?.numberOfLines = 0
  		cell.textLabel?.text = "Very long text..."
  	}
}
```

In order to get dynamic height working with customized cells, you have to get your constraints right.

Getting your constraints right is definitely the hardest and most important part of getting dynamic cell heights working with Auto Layout. If you make a mistake here, it could prevent everything else from working -- so take your time!

To determine the actual height for each row, the table view automatically asks each cell what height its contentView needs to be based on the known fixed width of the content view (which is based on the table view's width, minus any additional things like a section index or accessory view) and the auto layout constraints you have added to the cell's content view and subviews. [Source](http://stackoverflow.com/a/18746930/2058139)

**Custom Cells**

Custom cells must inherit from `UITableViewCell` and can be used like this:

```swift
class CustomCell: UITableViewCell {
	@IBOutlet weak var testLabel: UILabel!
}

tableView.createRow { (row: Row<CustomCell>) in
	row.configuration = { cell in
		cell.testLabel?.text = "My Test Label"
	}
}
```

### Sections

Again, you have three options to add a section:

**Create a section, configure it and add it to the table**

```swift
var section = Section()
section.headerTitle = "My Section Title"
tableView.addSection(section)
```

**Add a default section and configure later**

```swift
var section = tableView.addSection()
section.headerTitle = "My Section Title"
```

**Create, configure and add a section (preferred)**

```swift
tableView.createSection { section in
	section.headerTitle = "My Section Title"
}
```

Using the first two options has the benefit of having a reference to a specific section. From there you can actually add rows to specific sections like shown before.



## Credits

Raclette was heavily inspired by [Shoyu](https://github.com/yukiasai/Shoyu), [TableManager](https://github.com/Morbix/TableManager) and [Hakuba](https://github.com/nghialv/Hakuba).



## License

Raclette is released under the MIT license. See LICENSE for details.