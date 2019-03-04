require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "RNZendeskChat"
  s.version      = package["version"]
  s.summary      = "Social Share, Sending Simple Data to Other Apps"
  s.homepage     = "https://github.com/thanhcuong1990/react-native-zendesk-chat"
  s.license      = "MIT"
  s.author             = { "Cuong Lam" => "thanhcuong1990@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/thanhcuong1990/react-native-zendesk-chat.git", :tag => "#{s.version}" }

  s.source_files  = "ios/**/*.{h,m}"
  s.dependency "React"
  s.dependency 'ZDCChat'
end