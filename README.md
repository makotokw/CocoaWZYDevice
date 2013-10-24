CocoaWZDevice
========

## Installation

by CocoaPods

```ruby:Podfile
pod 'WZDevice/DeviceId', :git => 'https://github.com/makotokw/CocoaWZDevice.git'
```

## Usage: DeviceId

```
#import "UIDevice+WZDeviceId.h"

[UIDevice currentDevice].deviceUUID;
// or
// [UIDevice currentDevice].deviceUUIDOnlyDevice;
```

``deviceUUID`` and ``deviceUUIDOnlyDevice`` are side-by-side and return different value. 

## License

The MIT License (MIT)  