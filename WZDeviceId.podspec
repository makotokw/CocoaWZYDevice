Pod::Spec.new do |s|
  s.name         = "WZDeviceId"
  s.version      = "0.0.1"
  s.summary      = "Added deviceUUID and deviceUUIDOnlyDevice to UIDevice."
  s.homepage     = "https://github.com/makotokw/CocoaWZDeviceId"
  s.license      = 'MIT'
  s.author       = { "makoto_kw" => "makoto.kw@gmail.com" }
  s.source       = { :git => "https://github.com/makotokw/CocoaWZDeviceId.git" }

  s.platform     = :ios, '5.0'
  s.source_files = 'Classes/*.{h,m}'
  s.framework    = 'Security'
  s.requires_arc = true
end
