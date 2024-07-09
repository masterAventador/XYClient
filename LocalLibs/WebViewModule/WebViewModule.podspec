
Pod::Spec.new do |spec|

  spec.name         = "WebViewModule"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of WebViewModule."
  spec.homepage     = "https://github.com/masterAventador?tab=repositories"
  spec.author             = { "Aventador" => "ws419460185@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/masterAventador?tab=repositories", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"

  # spec.dependency "JSONKit", "~> 1.4"
  spec.dependency 'CommonViewModule'

end
