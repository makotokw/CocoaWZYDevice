CocoaWZYDevice
========

## Installation

by CocoaPods

```ruby:Podfile
pod 'WZYDevice/DeviceId', :git => 'https://github.com/makotokw/CocoaWZYDevice.git'
```

## Usage: DeviceId

```
#import "UIDevice+WZYDeviceId.h"

[UIDevice currentDevice].wzy_deviceUUID;
// or
// [UIDevice currentDevice].wzy_deviceUUIDOnlyDevice;
```

``wzy_deviceUUID`` and ``wzy_deviceUUIDOnlyDevice`` are side-by-side and return different value. 

## License

The MIT License (MIT)  