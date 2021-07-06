# Typyst
Typyst is a simple SwiftUI app that will trigger typewriter sounds while using the keyboard. Each typewriter 
soundset has been recreated from real type-writers by the creators (Evan Bezeredi and Sean Wolford). 

This repository contains code for the MacOS, iOS and iPadOS apps and mobile keyboard extensions. 

If you are interested in running on Linux, we have a Python script which is available at <a>https://github.com/PilotSSW/Typyst-Python</a>

If you have not yet installed a cocoapods manager, a guide can be found here at 
https://guides.cocoapods.org/using/getting-started.html

<B> Building Typyst </B> 

Clone the repository, open a terminal and run 'pod install' in the root directory. 
Once the pods are finished installing, open the project in Xcode or AppCode (whichever you are more familiar with) and 
build for MacOS. If the build is successful (it should be), then run Archive (<B>Menu -> Product -> Archive</B>) and 
export the app somewhere convenient. Once finished, open the folder and copy the app into the applications folder. 

<B> How the app works </B> 

When opening the app the first time, no typewriters are pre-loaded, select any of the three it comes pre-bundled with. 
The app will store in user-defaults the last selected type-writer and load this type-writer on opening. 

<B> Simulating paper feed </B>

By default, this option is off. Enabling it will play the sounds of paper being loaded and fed into the type-writer 
every 25 return presses.
