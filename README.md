Spectrum Wrapper for iOS
========================

Overview
--------

The Spectrum Customizer library provides a wrapper around a UIView with helper methods for interacting with Spectrum Customizer Content.

Adding the library to a project
-------------------------------

Install using cocoapods:

```ruby
target 'App' do
  pod 'SpectrumCustomizer', '~> 1.0'
end
```


Adding a SpectrumView in Interface Builder
------------------------------------------

Drag an instance of UIView from the Library onto the Storyboard. Select the new UIView and open the Identity Inspector. Change the class to 'SpectrumCustomizerView' and the module to Spectrum Customizer. Add an IBOutlet to the UIViewController that will be responsible for the SpectrumCustomizerView.

Set up the SpectrumViewDelegate
-------------------------------

Implementing SpectrumViewDelegate is necessary in order to add an item to the cart and to provide the customizer with pricing data.

```swift

public protocol SpectrumCustomizerViewDelegate: class {
  func addToCart(sender: SpectrumCustomizerView, skus: [String], recipeSetId: String, options: [String: String])
  func getPrice(sender: SpectrumCustomizerView, skus: [String], options: [String: String]) -> [String: SpectrumPrice]
}

```

Here is the implementation of SpectrumPrice:

```swift

public struct SpectrumPrice: Codable {
  public var price: String
  public var inStock: Bool

  public init(price: String, inStock: Bool) {
    self.price = price
    self.inStock = inStock
  }
}

```

Then, in the implementing ViewController setup the delegate and initialize the customizer. Internally the SpectrumCustomizerView has an HTML page that implements the necessary methods that Spectrum needs to interact with the host environment. There are two ways to initialize the customizer, either by a SKU or a Spectrum recipe ID.

```swift

@IBOutlet weak var spectrum: SpectrumCustomizerView!

override func viewDidLoad() {
  spectrum.delegate = self

  // By sku. customizerUrl is a string url that points to the Spectrum Customizer Javascript:
  spectrum.loadSku(sku: product2, customizerUrl: customizerUrl)

  // or by recipe

  spectrum.loadRecipe(recipeId: recipeId, customizerUrl: customizerUrl)
}

```

Example Implementation
----------------------

A simple example implementation (SpectrumIntegration) can be found in the repo.
