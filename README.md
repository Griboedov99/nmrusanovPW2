Question 1:
title.translatesAutoresizingMaskIntoConstraints = false - this line disables automatic constraints, we cant use our custom constraints if it is enabled
view.addSubview(title) - adds our title UILabel to the screen

Question 2:
Safe area Layout Guide - physical borders of the screen (depends on device)

Question 3:
[weak self] - array of weak pointers which exclude closures, works similar to smart pointers in C++ (if ViewController stops existing this pointer becomes nil)

Question 4:
clipsToBounds - if its true inherited view will be clipped if it goes beyond parent view bounds

Question 5:
valueChanged - it is so called "closure" field, it is template for our future lambda which we will pass into it. So Double is a tyoe of parametr and Void is output type
