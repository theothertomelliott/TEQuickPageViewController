Pod::Spec.new do |s|
  s.name         = "TEQuickPageViewController"
  s.version      = "2.0.0"
  s.summary      = "Add pages to a PageViewController directly in Storyboard."
  s.description  = <<-DESC
					TEQuickPageViewController is an extension of UIPageViewController to allow adding Views to a Page View directly in your Storyboard, without any additional code.
					
					Just add your Page View Controller and View Controllers to your Storyboard, then set a few attributes to add your View Controllers to the sequence of pages.
                   DESC
  s.homepage     = "https://github.com/theothertomelliott/TEQuickPageViewController"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author             = { "Tom Elliott" => "tom.w.elliott@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/theothertomelliott/TEQuickPageViewController.git", :tag => "2.0.0" }
  s.source_files  = "TEQuickPageViewController/Library", "TEQuickPageViewController/Library/**/*.{h,m}"
  s.exclude_files = "TEQuickPageViewController/Library/Exclude"
  s.requires_arc  = true
end
