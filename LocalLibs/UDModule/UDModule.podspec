
Pod::Spec.new do |spec|
  spec.name         = "UDModule"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of UDModule."
  spec.homepage     = "https://github.com/masterAventador?tab=repositories"
  spec.author             = { "Aventador" => "ws419460185@gmail.com" }
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/masterAventador?tab=repositories", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"

  spec.dependency 'MMKV'

end
