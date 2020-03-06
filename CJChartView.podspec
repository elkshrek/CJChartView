Pod::Spec.new do |s|

    # 库名称
    s.name         = "CJChartView"
    
    # 库的版本
    s.version      = "0.0.6"

    # 库摘要
    s.summary      = "简单易用的统计图表(包括：扇形图、进度条、柱状图、折线图。。。)"

    # 库描述（最好比summary多写一些描述）
    s.description  = <<-DESC
                        简单易用的统计图表(包括：扇形图、进度条、柱状图、折线图。。。)
                        提供方便用户集成使用的统计图表绘制
                        持续更新中。。。
                    DESC

    s.homepage     = "https://github.com/elkshrek/CJChartView"

    s.license      = "MIT"
    # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
    
    s.author             = { "Jonathan" => "Jonathan_dk@163.com" }

    s.platform     = :ios
    s.platform     = :ios, "9.0"

    # 下载地址
    s.source       = { :git => "https://github.com/elkshrek/CJChartView.git", :tag => "#{s.version}" }
    
    
    s.public_header_files = 'CJChartView/CJChartHeader.h'
    s.source_files = 'CJChartView/CJChartHeader.h'
    
    s.subspec 'ChartView' do |cvs|
        cvs.source_files = 'CJChartView/ChartView/**/*.{h,m}'
        cvs.ios.frameworks = 'Foundation', 'UIKit'
    end
    
    s.subspec 'PieChartView' do |pcs|
        pcs.source_files = 'CJChartView/PieChartView/**/*.{h,m}'
        pcs.ios.frameworks = 'Foundation', 'UIKit'
    end
    
    s.subspec 'ProgressChartView' do |pvs|
        pvs.source_files = 'CJChartView/ProgressChartView/**/*.{h,m}'
        pvs.ios.frameworks = 'Foundation', 'UIKit'
    end
    
    s.subspec 'LineChartView' do |lvs|
        lvs.source_files = 'CJChartView/LineChartView/**/*.{h,m}'
        lvs.ios.frameworks = 'Foundation', 'UIKit'
    end


    # ARC
    s.requires_arc = true
    s.ios.frameworks = 'Foundation', 'UIKit'
    

end
