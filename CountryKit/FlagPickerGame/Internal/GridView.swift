//
//  GridView.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/12/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import SwiftUI

struct GridView<Item,ItemView>: View where Item: Identifiable, ItemView: View {
    
    var items: [Item]
    
    var viewForItem: (Item) -> ItemView
    
    init(_ items:[Item], viewForItem: @escaping (Item)->ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(
                for: GridLayout(
                    itemCount: self.items.count,
                    nearAspectRatio: 1,
                    in: geometry.size
                )
            )
        }
    }
    
    func body(for layout: GridLayout ) -> some View {
        ForEach(self.items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(
                width: min(layout.itemSize.width,layout.itemSize.height),
                height: min(layout.itemSize.width,layout.itemSize.height)
        )
            .position(layout.location(ofItemAt: index))
    }
}


