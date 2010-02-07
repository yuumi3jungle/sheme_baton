;;
;;  Entry point for a Nu program.
;;

(load "Nu:nu")
(load "Nu:cocoa")
(load "Nu:menu")
(load "words")
(load "wordsapp")

(class ApplicationDelegate is NSObject
     (- applicationDidFinishLaunching:sender is
          (build-menu default-application-menu "WordsApp")
          ((WordsAppWindowController alloc) init))

     (- applicationShouldTerminateAfterLastWindowClosed:theApplication is 1)
)

((NSApplication sharedApplication) setDelegate:(set delegate ((ApplicationDelegate alloc) init)))

((NSApplication sharedApplication) activateIgnoringOtherApps:YES)

(NSApplicationMain 0 nil)
