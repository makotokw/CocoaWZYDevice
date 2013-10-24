Pod::Spec.new do |s|
  s.name         = "WZDevice"
  s.version      = "0.0.1"
  s.summary      = "Added deviceUUID and deviceUUIDOnlyDevice to UIDevice."
  s.homepage     = "https://github.com/makotokw/CocoaWZDevice"
  s.license      = 'MIT'
  s.author       = { "makoto_kw" => "makoto.kw@gmail.com" }
  s.source       = { :git => "https://github.com/makotokw/CocoaWZDevice.git" }
  s.platform     = :ios, '5.0'

  s.subspec 'DeviceId' do |sub|
    sub.requires_arc  = true
    sub.source_files = 'Classes/DeviceId/*.{h,m}'
    sub.framework    = 'Security'
  end

  s.subspec 'Network' do |sub|
    sub.requires_arc  = true
    sub.source_files = 'Classes/Network/*.{h,m}'
  end

end
