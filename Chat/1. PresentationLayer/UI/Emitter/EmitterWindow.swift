//
//  EmitterWindow.swift
//  Chat
//
//  Created by Qurban on 22.04.2019.
//  Copyright © 2019 Qurban. All rights reserved.
//

import Foundation

class EmitterWindow: UIWindow {
    private var emitter: IEmitter?

    override init(frame: CGRect) {
        super.init(frame: frame)
        emitter = Emitter(window: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)

        if event.type == .touches, let touches = event.allTouches {
            self.animateTouches(touches: touches)
        }
    }

    func animateTouches(touches: Set<UITouch>) {
        for touch in touches {
            switch touch.phase {
            case .began:
                emitter?.startAnimation(with: touch)
            case .moved:
                emitter?.updateAnimationPosition(with: touch)
            case .ended, .cancelled:
                emitter?.stopAnimation()
            case .stationary:
                break
            }
        }
    }
}
