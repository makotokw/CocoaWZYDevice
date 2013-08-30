CocoaWZDeviceId
========

## Installation

by CocoaPods

```ruby:Podfile
pod 'WZDeviceId', :git => 'https://github.com/makotokw/CocoaWZDeviceId.git'
```

## Usage

```
#import "UIDevice+WZDeviceId.h"

[UIDevice currentDevice].deviceUUID;
// or
// [UIDevice currentDevice].deviceUUIDOnlyDevice;
```

``deviceUUID`` and ``deviceUUIDOnlyDevice`` are side-by-side and return different value. 

## License

The MIT License (MIT)  