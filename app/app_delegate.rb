class AppDelegate
  def applicationDidFinishLaunching(notification)

    unless AccessibilityBridge.process_is_trusted
      puts "process is not trusted"
      exit
    end

    buildMenu
    buildWindow

    unless AccessibilityBridge.process_is_trusted
      ap 'process is not trusted'
      exit
    end

    @event_handler = EventHandler.new
    @event_handler.retain

    @event_tap = EventTap.new
    @event_tap.delegate = self
    @event_tap.eventHandlerDelegate = @event_handler
    @event_tap.enable
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end
end
