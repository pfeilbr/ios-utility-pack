# iOS Utility Pack #

A static iOS library providing utility classes for reoccurring common functionality

# Usage #

See [Using Open Source Static Libraries in Xcode 4](http://blog.carbonfive.com/2011/04/04/using-open-source-static-libraries-in-xcode-4/) for instructions on how to use/reference this iOS static library in an Xcode4 project using Xcode workspaces

Another required step in addition to the instructions above, are to drag **all** the iOS Utility Pack header `.h` files into your application project.  This creates a reference, and if you want to update them, you can do it from either project and Xcode keeps them in sync.  I recommend creating a `Vendor/ios-utility-pack` group and placing them in it to keep things tidy.

You can now add `#import "IOSUtl.h"` to any files when you want to use it.  Note that the import is double-quoted (`"`).  Angle brackets `<>` won't work.