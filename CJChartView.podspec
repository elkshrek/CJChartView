Pod::Spec.new do |s|

    # 库名称
    s.name         = "CJChartView"

    # 库的版本
    s.version      = "0.0.4"

    # 库摘要
    s.summary      = "简单易用的统计图表(包括：扇形图、进度条、柱状图、折线图。。。)"

    # 库描述（最好比summary多写一些描述）
    s.description  = <<-DESC
                        简单易用的统计图表(包括：扇形图、进度条、柱状图、折线图。。。)
                        提供方便用户集成使用的统计图表绘制
                        持续更新中。。。
                    DESC

    # 远程仓库地址，即 GitHub 的地址，或者你使用的其他的 Gitlab，码云的地址
    s.homepage     = "https://github.com/CircusJonathan/CJChartView"

    # 协议
    s.license      = "MIT"
    # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

    # 作者信息
    s.author             = { "Jonathan" => "Jonathan_dk@163.com" }

    # 支持的系统及支持的最低系统版本
    s.platform     = :ios
    s.platform     = :ios, "8.0"

    # 支持多个平台使用时
    # s.ios.deployment_target = "8.0"
    # s.osx.deployment_target = "10.7"
    # s.watchos.deployment_target = "2.0"
    # s.tvos.deployment_target = "9.0"

    # 下载地址，即远程仓库的 GitHub下载地址(clone 地址)，使用.git结尾
    s.source       = { :git => "https://github.com/CircusJonathan/CJChartView.git", :tag => "#{s.version}" }

    # 库文件在仓库中的相对路径
    # 等号后面的第一个参数表示的是要添加 CocoaPods 依赖的库在项目中的相对路径
    # 因为我的库就放在库根目录，所以直接就是 CJChartView
    # 如果你的是在其他地方，比如 CJChart/CJChartView，填写实际的相对路径
    # 等号后的第二个参数，用来指示 CJChartView 文件夹下的哪些文件需要添加 CocoaPods依赖
    # “**”这个通配符代表 CJChartView 文件夹下的所有文件，"*.{h,m}"代表所有的.h,.m文件
    s.source_files  = "CJChartView", "CJChartView/**/*.{h,m}"

    # 指明 CJChartView 文件夹下不需要添加到 CocoaPods 的文件
    # 这里是 Exclude 文件夹内的内容
    s.exclude_files = "CJChartView/CJTool"

    # 是否需要项目是 ARC
    s.requires_arc = true

    # 库中用到的框架或系统库（没用到可以没有）
    s.ios.frameworks = 'Foundation', 'UIKit'
    # s.framework  = "SomeFramework"
    # s.frameworks = "SomeFramework", "AnotherFramework"

    # 如果你的库依赖其他的 Podspecs，可以添加这些依赖项，例如
    # s.dependency 'AFNetworking', '~> 3.2.1'

end
