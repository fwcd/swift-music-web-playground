import Foundation
import JavaScriptKit

extension CGPoint {
    init(mouseEvent event: JSObject) {
        let parent = event.target.getBoundingClientRect()
        self.init(
            x: event.clientX.number! - parent.left.number!,
            y: event.clientY.number! - parent.top.number!
        )
    }
}
