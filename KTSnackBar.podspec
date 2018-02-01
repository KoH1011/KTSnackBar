#
#  Be sure to run `pod spec lint KTSnackBar.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "KTSnackBar"
  s.version          = "1.0.0"
  s.summary      = "KTSnackBar is a pop up library like Android AppWidget. It is written in pure swift"
  s.homepage     = "https://github.com/KoH1011/KTSnackBar"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "KoH1011" => "kosuke.t.1011@gmail.com" }
  s.source       = { :git => "https://github.com/KoH1011/KTSnackBar.git", :tag => s.version.to_s }
  s.social_media_url   = "https://twitter.com/KoH_1011"
  s.platform     = :ios, '9.0'
  s.requires_arc = true
  s.source_files = 'KTSnackBar/*.swift'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.0',
  }

end
