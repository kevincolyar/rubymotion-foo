#import "EventTap.h"

CFMachPortRef eventTap;

CGEventRef handleKeyboardEvent(CGEventRef event, EventTap *sender, CGEventTapProxy proxy) {
  @autoreleasepool {
    [sender.eventHandlerDelegate handle_keyboard_event:event andProxy:proxy];

    return event;
  }
}

CGEventRef myCGEventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {

    // On 10.6, the kCGEventTapDisabledByTimeout event seems to come incorrectly. If we get it, reenable the tap.
    // see http://lists.apple.com/archives/quartz-dev/2009/Sep/msg00006.html
    if (type == kCGEventTapDisabledByTimeout) {
        /* NSLog(@"got kCGEventTapDisabledByTimeout, reenabling tap"); */
        CGEventTapEnable(eventTap, TRUE);
        return event;    // NULL also seems to work here...
    }

    EventTap *sender = (EventTap *) refcon;

    // Keyboard Events
    if(type == kCGEventKeyDown || type == kCGEventKeyUp)
      return handleKeyboardEvent(event, sender, proxy);

    return event;
}

@implementation EventTap

- (void)setDelegate:(id)new_delegate {
    _delegate = new_delegate;
}

- (void)setEventHandlerDelegate:(id)new_delegate {
    eventHandlerDelegate = new_delegate;
}

- (EventTap *)init {
    return self;
}

- (void)enable {
    if(!eventTap){

      eventMask = (1 << kCGEventKeyDown) | (1 << kCGEventKeyUp);
      eventTap = CGEventTapCreate(kCGHIDEventTap, kCGHeadInsertEventTap, kCGEventTapOptionDefault, eventMask, myCGEventCallback, self);

      if (!eventTap) {
        fprintf(stderr, "failed to create event tap\\n");
        exit(0);
      }

      // Create a run loop source.
      runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);

      CFRelease(eventTap);

      CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);

      CFRelease(runLoopSource);
    }

    /* NSLog(@"Enabling event tap"); */

    CGEventTapEnable(eventTap, true);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
}

- (id)delegate {
  return _delegate;
 }

- (id)eventHandlerDelegate {
  return eventHandlerDelegate;
}

- (void)dealloc {
    [super dealloc];
}
@end
