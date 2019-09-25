Pod::Spec.new do |spec|
  spec.name         = "SuccessStatusAlert"
  spec.version      = "0.0.1"
  spec.summary      = "Alert, consistent with iOS 13"

  spec.homepage     = "https://github.com/HvrlK"

  spec.license      = { :type => "MIT", :file => "LICENSE.md" }

  spec.author             = { "Vitalii Havryliuk" => "v.havryliuk@noisyminer.com" }

  spec.platform     = :ios
  spec.ios.deployment_target = "11.0"

  spec.source       = { :git => "https://github.com/HvrlK/SuccessStatusAlert.git", :branch => "master", :tag => "0.0.1" }

  spec.source_files  = "SuccessStatusAlert/*"
  spec.exclude_files = "Examples/*"
  spec.frameworks = 'UIKit'
end