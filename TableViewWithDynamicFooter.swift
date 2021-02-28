import UIKit

final class TableViewWithDynamicFooter: UITableView {
   private var isAwaitnigReloading: Bool = false
   private var lastCalculatedFooterSize: CGFloat?
   
   private func setupHeaderHeight() {
      guard let footer = self.tableFooterView else { return }
      
      let originContentHeight = self.contentSize.height - (lastCalculatedFooterSize ?? 0)
      let emptySpaceUnderContent = self.bounds.height - originContentHeight

      let minFooterHeight = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
      assert(minFooterHeight != 0, "Footer height constraints doen't let usage of systemLayoutSizeFitting")
    
      footer.frame.size.height  = max(emptySpaceUnderContent, minFooterHeight)
      self.contentSize.height = footer.frame.origin.y + footer.frame.height
      lastCalculatedFooterSize = footer.frame.size.height
    
      isScrollEnabled = footer.frame.size.height == minFooterHeight
   }
   
   override func reloadData() {
      isAwaitnigReloading = true
      super.reloadData()
   }
   
  override func layoutSubviews() {
    super.layoutSubviews()
   
   guard isAwaitnigReloading == true else { return } // allow to calculate footer size once, after reload regardless of the number of layoutSubviews calls
   setupHeaderHeight()
   isAwaitnigReloading = false
  }
}

