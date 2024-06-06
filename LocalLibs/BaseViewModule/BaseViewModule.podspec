
Pod::Spec.new do |spec|

  spec.name         = "BaseViewModule"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of BaseViewModule."
  spec.homepage     = "https://github.com/masterAventador?tab=repositories"
  spec.author             = { "masterAventador" => "419460185@qq.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/masterAventador?tab=repositories", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"

  # spec.dependency "JSONKit", "~> 1.4"

end
