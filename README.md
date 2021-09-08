# EasyGameView

A SwiftUI grid view Package for "easy" game creation. 

Features:
* A "pure SwiftUI" View containing a grid of subviews. (Tested on iOS and macOS for now.)
* Change the subview appearance with a simple (`Int` based) array of state variables.
* Tap and Drag gestures handled for you, with Protocols you can implement to extend their behavior.

See the [example project](https://github.com/mgrider/EasyGameViewExample) for inspiration.

## TODO

This is still very much in progress. Don't use this package unless you are willing to lock it to a commit or put up with API changes down the road.

* finish writing this README/ add documentation
* fix/figure out bug where on first appearance, the size values set to the manager's data object are incorrect.
* subview type: hexagons
* subview type: images
* figure out how to resize the grid dynamically
