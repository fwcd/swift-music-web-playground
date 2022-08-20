import Foundation
import JavaScriptKit

extension CGPoint {
    init(mouseEvent event: JSObject) {
        // TODO: Subtract origin position of target element
        self.init(x: event.clientX.number!, y: event.clientY.number!)
    }
}
