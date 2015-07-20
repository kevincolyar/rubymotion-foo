#include <ApplicationServices/ApplicationServices.h>
#import <Carbon/Carbon.h>

@protocol EventHandlerDelegate
- (void)handle_keyboard_event:(CGEventRef)event andProxy:(CGEventTapProxy)proxy;
@end

@interface EventTap : NSObject {
  CGEventMask eventMask;
  CFRunLoopSourceRef runLoopSource;

  id _delegate;
  id <EventHandlerDelegate> eventHandlerDelegate;
}

- (EventTap *)init;

- (void)enable;

- (id)delegate;

- (id)eventHandlerDelegate;

- (void)setDelegate:(id<EventHandlerDelegate>)new_delegate;

- (void)setEventHandlerDelegate:(id)new_delegate;

@end

// This callback will be invoked every time there is a keystroke.

CGEventRef myCGEventCallback(CGEventTapProxy proxy,
                            CGEventType type,
                            CGEventRef event, void *refcon);
