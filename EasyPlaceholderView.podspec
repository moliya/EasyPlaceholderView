Pod::Spec.new do |s|

  s.name          = "EasyPlaceholderView"
  s.version       = "1.0.3"
  s.summary       = "UIView category for showing loading/empty/error views as you wish"
  s.homepage      = "https://github.com/moliya/EasyPlaceholderView"
  s.license       = "MIT"
  s.author        = {'Carefree' => '946715806@qq.com'}
  s.source        = { :git => "https://github.com/moliya/EasyPlaceholderView.git", :tag => s.version}
  s.requires_arc  = true
  s.platform      = :ios, '9.0'
  s.swift_version = '5.0'
  s.dependency 'EasyCompatible'

  s.default_subspecs = "Swift"

  s.subspec "Swift" do |ss|
    ss.source_files = "Sources/*.swift"
  end

  s.subspec "ObjC" do |ss|
    ss.source_files = "Sources/ObjC/*.swift"
    ss.dependency "EasyPlaceholderView/Swift"
  end

end
