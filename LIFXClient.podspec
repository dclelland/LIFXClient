#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name                    = "LIFXClient"
  s.version                 = "1.1.0"
  s.summary                 = "iOS/macOS client for LIFX lightbulbs."
  s.homepage                = "https://github.com/dclelland/LIFXClient"
  s.license                 = { :type => 'MIT' }
  s.author                  = { "Daniel Clelland" => "daniel.clelland@gmail.com" }
  s.source                  = { :git => "https://github.com/dclelland/LIFXClient.git", :tag => "1.1.0" }
  s.platform                = :ios, '12.0'
  s.swift_version           = '5.0'
  
  s.dependency 'PromiseKit', '~> 6.8.4'
  
  s.macos.deployment_target = '10.14'
  s.macos.source_files      = 'Sources/Common/**/*.swift', 'Sources/macOS/**/*.swift'
  
  s.ios.deployment_target   = '12.0'
  s.ios.source_files        = 'Sources/Common/**/*.swift', 'Sources/iOS/**/*.swift'
end
