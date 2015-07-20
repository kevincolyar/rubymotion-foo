#import "AccessibilityBridge.h"

extern Boolean AXIsProcessTrustedWithOptions(CFDictionaryRef options) __attribute__((weak_import));

@implementation AccessibilityBridge

+ (Boolean) process_is_trusted
{
  if (AXIsProcessTrustedWithOptions != NULL) {
    // 10.9 and later
    const void * keys[] = { kAXTrustedCheckOptionPrompt };
    const void * values[] = { kCFBooleanTrue };

    // CFDictionaryRef options = CFDictionaryCreate(
    //                                              kCFAllocatorDefault,
    //                                              keys,
    //                                              values,
    //                                              sizeof(keys) / sizeof(*keys),
    //                                              &kCFCopyStringDictionaryKeyCallBacks,
    //                                              &kCFTypeDictionaryValueCallBacks);
    // return AXIsProcessTrustedWithOptions(options);

    NSDictionary *options = @{(id)kAXTrustedCheckOptionPrompt: @YES};
    BOOL accessibilityEnabled = AXIsProcessTrustedWithOptions((CFDictionaryRef)options);
    return accessibilityEnabled;

  } else {
    // OSX 10.8
    return AXIsProcessTrusted();
  }
}
@end

