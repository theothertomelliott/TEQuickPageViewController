Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "TEQuickPageViewController"
  s.version      = "1.0.0"
  s.summary      = "Add pages to a PageViewController directly in Storyboard."

  s.description  = <<-DESC
					TEQuickPageViewController is an extension of UIPageViewController to allow adding Views to a Page View directly in your Storyboard, without any additional code.
					
					Just add your Page View Controller and View Controllers to your Storyboard, then set a few attributes to add your View Controllers to the sequence of pages.
                   DESC

  s.homepage     = "http://EXAMPLE/TEQuickPageViewController"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author             = { "Tom Elliott" => "tom.w.elliott@gmail.com" }
  s.platform     = :ios
  # s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/theothertomelliott/TEQuickPageViewController.git", :tag => "1.0.0" }
  s.source_files  = "TEQuickPageViewController/Library", "TEQuickPageViewController/Library/**/*.{h,m}"
  s.exclude_files = "TEQuickPageViewController/Library/Exclude"
  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

end
