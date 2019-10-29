Spectrum Wrapper for iOS
========================

Overview
--------

The Spectrum Customizer library provides a wrapper around a UIView with helper methods for interacting with Spectrum Customizer Content.

Adding the library to a project
-------------------------------

First, download the project from https://github.com/spectrum-customizer/spectrum-ios-native-wrapper. Then, in XCode:

1. Click on the project
2. Click on embedded binaries
3. Navigate to the Spectrum Customizer project
4. Click Add XCode project

Adding a SpectrumView in Interface Builder
------------------------------------------

Drag an instance of UIView from the Library onto the Storyboard. Select the new UIView and open the Identity Inspector. Change the class to 'SpectrumCustomizerView' and the module to Spectrum Customizer. Add an IBOutlet to the UIViewController that will be responsible for the SpectrumCustomizerView.

Initializing the Customizer
---------------------------

Use the SpectrumCustomizerView's loadCustomizer method to load the application. Internally the SpectrumCustomizerView has an HTML page that implements the necessary methods that Spectrum needs to interact with the host environment.

```swift

spectrum.loadCustomizer(customizerUrl: "https://madetoorderdev.blob.core.windows.net/spectrum-native-test/app.js")

```

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

```

public struct SpectrumPrice: Codable {
  public var price: String
  public var inStock: Bool

  public init(price: String, inStock: Bool) {
    self.price = price
    self.inStock = inStock
  }
}

```

Loading a recipe or a product
-----------------------------

Existing recipes can be loaded by calling loadRecipe and products can be loaded by calling loadSku. Both expect a SpectrumArguments object:

```swift

// recipe
let arg = SpectrumArguments(fromRecipeId: "P2LD123")
spectrum.loadRecipe(args: arg)

// Product
let arg = SpectrumArguments(fromSku: "example-pro-product-1")
spectrum.loadSku(args: arg)

```


Example Implementation
----------------------

A simple example implementation (SpectrumIntegration) can be found in the repo.
