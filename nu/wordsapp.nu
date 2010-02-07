;; create a standard button
(function standard-cocoa-button (frame)
     (((NSButton alloc) initWithFrame:frame)
      set: (bezelStyle:NSRoundedBezelStyle)))

;; create a standard textfield
(function standard-cocoa-textfield (frame)
     (((NSTextField alloc) initWithFrame:frame)
      set: (bezeled:0 editable:0 alignment:NSLeftTextAlignment drawsBackground:1)))

;; define the window controller class
(class WordsAppWindowController is NSObject
     (ivars)
     
     (- init is
          (super init)
          (let (w ((NSWindow alloc)
                   initWithContentRect: '(300 200 420 120)
                   styleMask: (+ NSTitledWindowMask NSClosableWindowMask NSMiniaturizableWindowMask)
                   backing: NSBackingStoreBuffered
                   defer: 0))
               (w set: (title:"Words"))
               (let (v ((NSView alloc) initWithFrame:(w frame)))
                    (let (b (standard-cocoa-button '(280 60 116 32)))
                         (b set: (title: "Check" target: self action:"check:"))
                         (v addSubview:b)
                         (set @checkButton b))
                    (let (b (standard-cocoa-button '(280 20 58 32)))
                         (b set: (title: "Yes" target: self action:"yes:"))
			             (b setEnabled:nil)
                         (v addSubview:b)
                         (set @yesButton b))
                    (let (b (standard-cocoa-button '(340 20 58 32)))
                         (b set: (title: "No" target: self action:"no:"))
			             (b setEnabled:nil)
                         (v addSubview:b)
                         (set @noButton b))
                    (let (t (standard-cocoa-textfield '(50 66 200 22)))
		    	         (t setStringValue:"")
                         (v addSubview:t)
                         (set @englishText t))
                    (let (t (standard-cocoa-textfield '(50 26 200 22)))
		    	         (t setStringValue:"")
                         (v addSubview:t)
                         (set @japaneseText t))
                    (w setContentView:v))
               (w center)
               (set @window w)
               (w makeKeyAndOrderFront:self))
          (self main)
          self)

     
     (- check:sender is (@check_proc))

     (- yes:sender is (@answer_proc t))
	
     (- no:sender is (@answer_proc nil))
      	
     (- main is
        (let ((words (Words wordsWithResorceFile:"words" ofType:"txt")))
             (words sortByNg)
             (@englishText setStringValue:(((words top) car) stringValue))
             (set @check_proc (do ()
          	    (@japaneseText setStringValue:(((words top) cadr) stringValue))
     	        (@yesButton setEnabled:t)
     	        (@noButton  setEnabled:t)))
             (set @answer_proc (do (yn)
                (if yn (then (words setOk)) (else (words setNg)))
                (words writeToResorceFile:"words" ofType:"txt")
          	    (words next)
          	    (if (words isEnd)
          	        (then
          	            (self terminate:nil))
          	        (else 
                        (@englishText setStringValue:(((words top) car) stringValue))
          	            (@japaneseText setStringValue:"")
          	            (@yesButton setEnabled:nil)
          	            (@noButton  setEnabled:nil)))))))

     
)
