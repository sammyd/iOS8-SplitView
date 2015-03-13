# iOS 8 Split View

iOS 8 made `UISplitViewController` universal - i.e. it works on all iOS devices.
In order to support this, it can change its view controller hierarchy dependent
on the horizontal size class of the container. Since this has the ability to change
at runtime, new APIs have been added to support the expansion and collapse of a
`UISplitViewController`.

It seems that this new behaviour can cause confusion with model hierarchies of
non-unit depth. This project will demonstrate how to use the new APIs to control
the split view in this scenario.

## Code

This project demonstrates the new functionality, and how to control it. It was 
created using a beta of Xcode 6.3 (and therefore Swift 1.2). It might still work
when you get to use it, but I offer no guarantees.

## Me

I'm sam. You should follow me on the twitter - [@iwantmyrealname](https://twitter.com/iwantmyrealname).


sam
