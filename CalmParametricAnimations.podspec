Pod::Spec.new do |s|
  s.name             = "CalmParametricAnimations"
  s.version          = "1.0.1"
  s.summary          = "Extends native CAKeyframeAnimations to use all of the complex easing functions found at http://www.easings.net"
  s.homepage         = "https://github.com/calm/CalmParametricAnimations"
  s.license          = "MIT"
  s.author           = { "tsheaff" => "tyler@calm.com" }
  s.source           = { :git => "https://github.com/calm/CalmParametricAnimations.git", :tag => s.version.to_s }

  s.frameworks = 'QuartzCore', 'CoreGraphics'

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.requires_arc = true
  s.source_files = 'Pod/Classes'
end
