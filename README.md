# Listing Impression Stalker

**Swift solution for marketing impression event tracking on UICollectionView**

## What does ListingImpressionStalker do?
Tracking impression event of cells in the collection views requires a bit of dirty work especially it has minimum percentage of cell constraint to count as viewed. ListingImpressionStalker provides a solution for it. In the demo project, cells which are counted as viewed filled with green color as you can below, of course depends on their min percent values.

%30 Min Percentage  | %90 Min Percentage
--- | ---
![](https://i.hizliresim.com/gOgV62.gif) | ![](https://i.hizliresim.com/Z96Q3Z.gif)

## How is it set up?
Just drag and drop ListingImpressionStalker to your project.

## How is it used?
* Initialize ListingImpressionStalker with a desired initializer, after your collection view is set.
```
    @IBOutlet weak var collectionView:UICollectionView!{
        didSet{
            impressionEventStalker = ListingImpressionStalker(minimumPercentageOfCell: 1.0, collectionView: collectionView, delegate: self)
        }
    }
```
* Make sure your view controller conforms "_ListingImpressionStalkerDelegate_"
* In your custom UICollectionViewCell class, conform "_ListingImpressionItem_" protocol to provide unique identifier for each item to ensure each items event sent only once.
* In your view controller, call _stalkCells()_ method in viewDidAppear() and scrollViewDidScroll() methods.
* After it is configured, _sendEventForCell(atIndexPath indexPath:IndexPath)_ method fired from ListingImpressionStalker when a cell's visible percent becomes greater than minimumPercentageOfCell. A cell index sent via this method never sent again.

## Parameters
* **minimumPercentageOfCell:** Minimum percentage of cell to count cell as viewed. If it is not set properly, it is set to 0.5 automatically.
* **delegate:** ListingImpressionStalkerDelegate object. Viewed cells index paths are sent to object that conforms this protocol.
* **collectionView:** The collection view which is tracked.

 ## Questions or Advices
 Just send me an email (ergunemr@gmail.com)