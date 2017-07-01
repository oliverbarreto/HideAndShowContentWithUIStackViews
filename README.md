# How to properly programmatically define a structure that shows & hides content with stackviews 
My goal is to create a view controller that allows you to show & hide controls for better UI when used for interacting with user to capture data in a form. For this the idea is use UIStackViews rather than using long autolayout constraints definitions.

The problem is that UIStackView have their own "intrinsic anomallies"...

## First the Theory
You can learn about UIStackViews in:

 * [Apple Auto Layout Guide documentation](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html#//apple_ref/doc/uid/TP40010853-CH11-SW1)
 * [UIStackView Class Documentation](https://developer.apple.com/documentation/uikit/uistackview)

I also recommend watching the videos in [Ray Wenderlich official youtube channel](https://www.youtube.com/user/rwenderlich), which has published some of its not-so-old paid courses, also on StackViews. There you can see all the properties available to customize a StackView, specially how .distribution, alignment, spacing, and axis affect, and the difference between ArrangedSubviews and 'just' Subviews of the Stackview, which is a speciall subclass of UIView that simplifies auto layout, but it does nothing aobut rendering. This is an important concept, for instance when adding a background like [this article by UseYourLoaf](https://useyourloaf.com/blog/stack-view-background-color/). 
 * [Introduction to StackViews](https://www.youtube.com/watch?v=ftf9V_u9g9I) 
 * [Nested StackViews](https://www.youtube.com/watch?v=QN7Q1rQ89aQ)
 

Then you have a lot of resources on the Internet:
 * [How to add a Background Color view to a StackView by UseYourLoaf](https://useyourloaf.com/blog/stack-view-background-color/)
 * [Easier Auto layout with stackviews](https://useyourloaf.com/blog/easier-autolayout-with-stackviews/)
 * [Adapting Stackviews with Size Classes](https://useyourloaf.com/blog/adapting-stack-views-with-size-classes/)
* [Using Size Classes to hide StackView Contents](https://useyourloaf.com/blog/using-size-classes-to-hide-stack-view-contents/)
* [Scrolling StackViews](https://useyourloaf.com/blog/scrolling-stack-views/)
* [Stack Views conflicts when hidding views](https://useyourloaf.com/blog/stack-view-constraint-conflicts-when-hiding-views/)
* [StackViews Baseline Alignment Argument](https://useyourloaf.com/blog/stack-view-baseline-alignment-issue/)
* [More Resources, including these for stackviews, on UseYourLoaf](https://useyourloaf.com/archives/)

 
## Now the Use Case
I want to display images and UIPickerViews to enter data when pressing a button, and hiding the UIPickerView upon selection. The problem is that UIPickerViews inside UIStackViews seems to be hard to tame accoridng to this [post](https://codexample.org/questions/419376/animate-datepicker-hide-show-in-stackview.c) and in this one [Stack Views conflicts when hidding views](https://useyourloaf.com/blog/stack-view-constraint-conflicts-when-hiding-views/).

For this purpose we are going to build a nested StackView hirarchy in a Swift Playground.

StackViews used: 
 * *stackview:* is the root stackview that will vertically hold the content views. We use a backgroundView in the stackview to see it.
 * *pokemonButtonsStackview & nikeButtonsStackview:** are the stackview that will horizontally hold the buttons (hide and show content)

The main stackview:
```swift
let stackview = UIStackView()
stackview.axis = .vertical
stackview.distribution = .fill
stackview.alignment = .fill
stackview.spacing = 0
stackview.translatesAutoresizingMaskIntoConstraints = false

let stackviewBackgroundView = UIView()
stackviewBackgroundView.backgroundColor = UIColor.purple
stackviewBackgroundView.translatesAutoresizingMaskIntoConstraints = false
```

Then the content stackviews inside e.g.:
```swift
let pokemonButtonsStackview = UIStackView()
pokemonButtonsStackview.axis = .horizontal
pokemonButtonsStackview.distribution = .fillEqually
pokemonButtonsStackview.alignment = .top    // This is the key property for properly aligning the buttons to the top of the view provided by the vertical stackview!!!
pokemonButtonsStackview.spacing = 0
pokemonButtonsStackview.translatesAutoresizingMaskIntoConstraints = false

let nikeButtonsStackview = UIStackView()
nikeButtonsStackview.axis = .horizontal
nikeButtonsStackview.distribution = .fillEqually
nikeButtonsStackview.alignment = .top    // This is the key property for properly aligning the buttons to the top of the view provided by the vertical stackview!!!
nikeButtonsStackview.spacing = 0
nikeButtonsStackview.translatesAutoresizingMaskIntoConstraints = false
```

With this infrastructure it's just a matter of adding content views, that have intrinsinc content size, like the UIButtons, the UIImageViews, etc... and setting up some constraints.

The most important constraints are the ones for the root StackView. e.g.:
```swift
stackview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
stackview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
stackview.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
//stackview.heightAnchor.constraint(equalToConstant: 200).isActive = true
```
Here, we pin the stackview to the top and size edges of its superview. We let the stackview determine its hight based on the content of its views. Or we could also add more information and manually set its hight with ye one more constraint.

A special case is the case of the stackview background. In this case, since it is not an arrangedView, we must provide enough information to the auto layout system in order to properly render the view. So we pin the view to all the edges of its superview so it streches accordingly , e.g.:
```swift
stackviewBackgroundView.leadingAnchor.constraint(equalTo: stackview.leadingAnchor, constant: 0).isActive = true
stackviewBackgroundView.trailingAnchor.constraint(equalTo: stackview.trailingAnchor, constant: 0).isActive = true
stackviewBackgroundView.topAnchor.constraint(equalTo: stackview.topAnchor, constant: 0).isActive = true
stackviewBackgroundView.bottomAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 0).isActive = true
```

Now, time to build and run... the playground.


