;; main.nu
;;  Entry point for a Nu program.
;;

(load "Nu:nu")		;; basics
(load "Nu:cocoa")	;; cocoa definitions
(load "Nu:menu")	;; menu generation
(load "words")
(load "wordsapp")

;; define the application delegate class
(class ApplicationDelegate is NSObject
     (imethod (void) applicationDidFinishLaunching: (id) sender is
          (build-menu default-application-menu "WordsApp")
          (set $random ((WordsAppWindowController alloc) init)))
     (imethod (BOOL) applicationShouldTerminateAfterLastWindowClosed: (id) theApplication is
         1)
)

;; install the delegate and keep a reference to it since the application won't retain it.
((NSApplication sharedApplication) setDelegate:(set delegate ((ApplicationDelegate alloc) init)))

;; this makes the application window take focus when we've started it from the terminal
((NSApplication sharedApplication) activateIgnoringOtherApps:YES)

;; run the main Cocoa event loop
(NSApplicationMain 0 nil)
