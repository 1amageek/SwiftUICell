
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
class ViewContrller: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let view: UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(content: CellView.self)
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view.addSubview(self.collectionView)
    }
}
```

```swift
extension YOUR_DELEGATE: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SwiftUICell<CellView> = SwiftUICell<CellView>.dequeue(collectionView: collectionView, indexPath: indexPath, contentView: CellView(), parent: self)
        return cell
    }
}
```
