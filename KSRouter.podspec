Pod::Spec.new do |s|

  s.name         = "KSRouter"
  s.version      = "1.0.0"
  s.summary      = "UINavigationController wrapper with more logical way of viewControllers routing"
  s.description  = <<-DESC
                   KSRouter is a wrapper around UINavigationController which helps you to prototype the UI of your app and manage it's segues. Check out the example project for details.
                   DESC

  s.homepage     = "https://github.com/krin-san/KSRouter"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Alexandr Chaplyuk" => "krin.chap@gmail.com" }
  s.social_media_url   = "https://vk.com/krin_san"

  s.platform     = :ios
  s.ios.deployment_target = "8.0"

  s.source       = { :git => 'https://github.com/krin-san/KSRouter.git', :tag => "v#{s.version}" }
  s.source_files  = "KSRouter", "KSRouter/*.{h,m}"
  s.exclude_files = "KSRouter/Exclude"

  s.requires_arc = true

end
