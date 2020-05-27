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
  pod 'SpectrumCustomizer', '~> 2.1'
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
  func getPrice(sender: SpectrumCustomizerView, skus: [String], options: [String: String]) -> [SpectrumPrice]
  func getImage(sender: SpectrumCustomizerView)
}

```

Here is the implementation of SpectrumPrice:

```swift

public struct SpectrumPrice: Codable {
  public var sku: String
  public var price: Decimal
  public var inStock: Bool

  public init(sku: String, price: Decimal, inStock: Bool) {
    self.sku = sku
    self.price = price
    self.inStock = inStock
  }
}

```

Finally, to upload images the ViewController needs to provide an implementation for the `getImage(sender: SpectrumCustomizerView)` delegate method. This method will be called when the user requests an image upload. The View Controller would allow a user to select an image using a UIImagePickerControler. The SpectrumCustomizerView provides two methods for handling images:

```swift
func loadImage(image: UIImage) // Return the selected image to the customizer
func cancelImageUpload() // Cancel current image upload.
```

Here is a simple example implementation:
```swift
func getImage(sender: SpectrumCustomizerView) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
}

// UIImagePickerControllerDelegate methods
internal func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[.originalImage] as? UIImage {
        spectrum.loadImage(image: pickedImage)
    } else {
        spectrum.cancelImageUpload()
    }
    picker.dismiss(animated: true, completion: nil)
}

internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    spectrum.cancelImageUpload()
    picker.dismiss(animated: true, completion: nil)
}

```

Then, in the implementing ViewController setup the delegate and initialize the customizer. Internally the SpectrumCustomizerView has an HTML page that implements the necessary methods that Spectrum needs to interact with the host environment. There are two ways to initialize the customizer, either by a SKU or a Spectrum recipe ID.

```swift

@IBOutlet weak var spectrum: SpectrumCustomizerView!

override func viewDidLoad() {
  spectrum.delegate = self

  // By sku. customizerUrl is a string url that points to the Spectrum Customizer Javascript:
  spectrum.loadSku(sku: product2, customizerUrl: customizerUrl)

  // or by recipe (sku is optional depending on implementation)

  spectrum.loadRecipe(recipeId: recipeId, customizerUrl: customizerUrl, sku: product2)
}

```



Example Implementation
----------------------

A simple example implementation (SpectrumIntegration) can be found in the repo.
