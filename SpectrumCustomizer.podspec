Pod::Spec.new do |spec|

  spec.name         = "SpectrumCustomizer"
  spec.version      = "1.0.3"
  spec.summary      = "A library for interacting with Spectrum Customizer Content."

  spec.description  = <<-DESC
The Spectrum Customizer library provides a wrapper around a UIView with helper methods for interacting with Spectrum Customizer Content (https://www.spectrumcustomizer.com/).
                   DESC

  spec.homepage     = "https://github.com/spectrum-customizer/spectrum-ios-native-wrapper"
  spec.license      = { :type => "MIT", :file => "SpectrumCustomizer/LICENSE" }


  spec.author             = { "Spectrum" => "tom.falkner@pollinate.com" }
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/spectrum-customizer/spectrum-ios-native-wrapper.git", :tag => "#{spec.version}" }

  spec.source_files  = "SpectrumCustomizer/SpectrumCustomizer/**/*{swift,h}"
  spec.exclude_files = "SpectrumCustomizer/Classes/Exclude"

  spec.resources  = "SpectrumCustomizer/SpectrumCustomizer/**/*.{html,xib}"
  spec.swift_versions = "4.2"

end
