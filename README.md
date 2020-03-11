
# SwiftUICell

SwiftUICell runs SwiftUI as CollectionView Cell

# Installation

Swift Package Manager

`SwiftUICell`

# Usage

```swift
import SwiftUI
import SwiftUICell

struct CellView: Cell {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("@1amageek")
                .bold()
                .padding()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width)
    }
}
```

```swift
collectionView.register(content: CellView.self)
```

```swift
extension YOUR_DELEGATE: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SwiftUICell<CellView> = SwiftUICell<CellView>.dequeue(collectionView: collectionView, indexPath: indexPath, contentView: CellView(), parent: self)
        return cell
    }
}
```
