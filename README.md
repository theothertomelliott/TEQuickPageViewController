# TEQuickPageViewController

An extension of UIPageViewController to allow adding Views to a Page View directly in your Storyboard, **without any additional code**.

Just create your Page View Controller in storyboard, add a few segues, and you have a working set of paged views.

![Pages in Storyboard](Screenshots/storyboard-example.png)

TEQuickPageViewController supports Page Curl and Scroll transition types, as well as a two-page view with a Spine Location of "Mid".

![Curled Pages](Screenshots/curl-example.png)
![Scrolled Pages](Screenshots/scroll-example.png)

## Changes in this version

Version 2 replaces the identifier-based method of linking views with a set of custom segues, to allow you to see the relationship between your controller and pages at a glance.

If moving from version 1, you will need to add segues as detailed in the setup instructions below.

## Installing

### CocoaPods

If you're using CocoaPods, just add the below to your podfile:

    pod "TEQuickPageViewController", '~> 2.0'

### Direct

To include the required source directly, just add these files to your project:

* TEQuickPageViewController.h
* TEQuickPageViewController.m
* TEQuickPageViewSegue.h
* TEQuickPageViewSegue.m

## Setting Up Your Page View

First, you'll need to prepare your UIPageViewController:

* Drag a *Page View Controller* into your Storyboard
* In the Page View Controller's Identity Inspector, set the class to *TEQuickPageViewController*

![Identity Inspector Button](Screenshots/identityinspector.png)

![Setting a Custom Class](Screenshots/2-setclass.png)

## Adding Pages

To add a page to your sequence of pages, you will need to connect it to your controller or preceding pages:

* Drag a *View Controller* into your Storyboard
* Add a *custom* segue between your Page View Controller and the new View Controller.

![Initial Segue](Screenshots/customsegue1.png)

* Set the segue's class to *TEQuickPageViewSegue* and the Identifier to "page"

![Attribute Inspector Button](Screenshots/3-attributeinspector.png)

![Configuring a segue](Screenshots/page-storyboard.png)

To add a second page, just drag another View Controller into your view and add another custom segue with the same settings, this time from your first page. This will create a chain of pages in your storyboard.

![A chain of two pages](Screenshots/twopagechain.png)

## Additional Features

### Wrap Around

The Wrap Around attribute in your TEQuickPageViewController's attributes allows your pages to "wrap" from the end back to the beginning.

When disabled, the user will not be able to swipe backwards from the first page or forwards from the last page.

## Custom Segue Identifier

By default, your page segues need an identifier of "page", but this may not be desirable.

To specify your own identifier, just set the "Segue Id" attribute on your TEQuickPageViewController. You can now change the identifier for your segues to this string.

## Known Issues

### Cycles Cause Crashes

If you have a cycle in your chain of pages (such as connecting Page 1 -> Page 2 -> Page 1), this will result in an infinite loop when establishing the array of pages, and our app will crash.

It should be easy to see if you have a loop in your chain, and remove the problem segue.

## Example Project

*TEQuickPageViewController.xcodeproj* is a simple iOS app making use of the TEQuickPageViewController class. Feel free to open it up and play around!

## License

TEQuickPageViewController is available under the MIT license. See the LICENSE file for more info.