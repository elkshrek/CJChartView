
Pod::Spec.new do |s|

  # 库名称
  s.name         = "CJChartView"

  # 库的版本
  s.version      = "0.0.3"

  # 库摘要
  s.summary      = "简单易用的统计图表(包括：扇形图、进度条、柱状图、折线图。。。)"

  # 库描述
  s.description  = <<-DESC
                    简单易用的统计图表(包括：扇形图、进度条、柱状图、折线图。。。)
                    提供方便用户集成使用的统计图表绘制
                    持续更新中。。。
                   DESC

  # 远程仓库地址，即GitHub的地址，或者你使用的其他的Gitlab，码云的地址
  s.homepage     = "https://github.com/CircusJonathan/CJChartView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  # 协议
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  # 作者信息
  s.author             = { "Jonathan" => "Jonathan_dk@163.com" }

  # 支持的系统及支持的最低系统版本
  s.platform     = :ios
  s.platform     = :ios, "8.0"

  # 下载地址，即远程仓库的GitHub下载地址(clone 地址)，使用.git结尾
  s.source       = { :git => "https://github.com/CircusJonathan/CJChartView.git", :tag => "#{s.version}" }

  # 库文件在仓库中的相对路径
  # 等号后面的第一个参数表示的是要添加CocoaPods依赖的库在项目中的相对路径
  # 因为我的库就放在库根目录，所以直接就是CJChartView
  # 如果你的是在其他地方，比如CJChart/CJChartView，填写实际的相对路径
  # 等号后的第二个参数，用来指示CJChartView文件夹下的那些文件需要添加CocoaPods依赖
  # “**”这个通配符代表CJChartView文件夹下的所有文件,"*.{h,m}"代表所有的.h,.m文件
  s.source_files  = "CJChartView", "CJChartView/**/*.{h,m}"
  # 指明CJChartView文件夹下不需要添加到CocoaPods的文件，这里是Exclude文件夹内的内容
  s.exclude_files = "CJChartView/Exclude"

  s.requires_arc = true

  # s.public_header_files = "Classes/**/*.h"


  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
