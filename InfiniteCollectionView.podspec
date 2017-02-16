Pod::Spec.new do |s|
  s.name         = "InfiniteCollectionView"
  s.version      = "1.3.1"
  s.summary      = "Infinite Scrolling Using UICollectionView."
  s.homepage     = "https://github.com/hryk224/InfiniteCollectionView"
  s.screenshots  = "https://github.com/hryk224/InfiniteCollectionView/wiki/images/sample1.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "hyyk224" => "hryk224@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/hryk224/InfiniteCollectionView.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/*.{h,swift}"
  s.frameworks = "UIKit"
  s.requires_arc = true
end
