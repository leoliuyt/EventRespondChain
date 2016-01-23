//
//  UIView+EventDebug.m
//  EventRespondChain
//
//  Created by leoliu on 16/1/23.
//  Copyright © 2016年 leoliu. All rights reserved.
//

#import "UIView+EventDebug.h"
#import <objc/runtime.h>

@implementation UIView (EventDebug)

+(void)load
{
    Method orgin = class_getInstanceMethod([self class], @selector(pointInside:withEvent:));
    Method custom = class_getInstanceMethod([self class], @selector(debug_pointInside:withEvent:));
    method_exchangeImplementations(orgin, custom);
    
    orgin = class_getInstanceMethod([self class], @selector(hitTest:withEvent:));
    custom = class_getInstanceMethod([self class], @selector(debug_hitTest:withEvent:));
    method_exchangeImplementations(orgin, custom);
    
    orgin = class_getInstanceMethod([self class], @selector(touchesBegan:withEvent:));
    custom = class_getInstanceMethod([self class], @selector(debug_touchesBegan:withEvent:));
    method_exchangeImplementations(orgin, custom);
    
    orgin = class_getInstanceMethod([self class], @selector(touchesMoved:withEvent:));
    custom = class_getInstanceMethod([self class], @selector(debug_touchesMoved:withEvent:));
    method_exchangeImplementations(orgin, custom);
    
    orgin = class_getInstanceMethod([self class], @selector(touchesEnded:withEvent:));
    custom = class_getInstanceMethod([self class], @selector(debug_touchesEnded:withEvent:));
    method_exchangeImplementations(orgin, custom);
}


- (BOOL)debug_pointInside: (CGPoint)point withEvent: (UIEvent *)event
{
    BOOL canAnswer = [self debug_pointInside: point withEvent: event];
    NSLog(@"%@ can answer %d", self.class, canAnswer);
    return canAnswer;
}

- (UIView *)debug_hitTest: (CGPoint)point withEvent: (UIEvent *)event
{
    UIView * answerView = [self debug_hitTest: point withEvent: event];
    NSLog(@"hit view: %@", self.class);
    return answerView;
}

- (void)debug_touchesBegan: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- begin, %p --- %p", self.class, touches, event.allTouches);
    [self debug_touchesBegan: touches withEvent: event];
}

- (void)debug_touchesMoved: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- move, %p --- %p", self.class, touches, event.allTouches);
    [self debug_touchesMoved: touches withEvent: event];
}

- (void)debug_touchesEnded: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- end, %p --- %p", self.class, touches, event.allTouches);
    [self debug_touchesEnded: touches withEvent: event];
}
@end

@implementation UIViewController (EventDebug)

- (void)debug_touchesBegan: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- begin, %p --- %p", self.class, touches, event.allTouches);
//    [self debug_touchesBegan: touches withEvent: event];
}

- (void)debug_touchesMoved: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- move, %p --- %p", self.class, touches, event.allTouches);
//    [self debug_touchesMoved: touches withEvent: event];
}

- (void)debug_touchesEnded: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event
{
    NSLog(@"%@ --- end, %p --- %p", self.class, touches, event.allTouches);
//    [self debug_touchesEnded: touches withEvent: event];
}
@end
