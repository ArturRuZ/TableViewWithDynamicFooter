import UIKit

final class TableViewWithDynamicFooter: UITableView {
   private var isObservingCahnges: Bool = false
   
   private func setupHeaderHeight() {
      guard let footer = self.tableFooterView else { return }
      
      let emptySpaceUnderContent = self.bounds.height - self.contentSize.height
      
      switch isObservingCahnges {
      case true:
         guard emptySpaceUnderContent != 0 else { return }
         fallthrough
      case false:
         let minFooterHeight = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
         
         let targetHeight = max(0, emptySpaceUnderContent)
         footer.frame.size.height  = max(targetHeight, minFooterHeight)
         
         isScrollEnabled = footer.frame.size.height == minFooterHeight
         isObservingCahnges = true
      }
   }

  override func layoutSubviews() {
    super.layoutSubviews()
    setupHeaderHeight()
  }
}
