(class NuCell is NSObject
    (- cadr is ((self cdr) car))
    (- caddr is (((self cdr) cdr) car))
    (- cadddr is ((((self cdr) cdr) cdr) car))
    (- setCaddr:x is (((self cdr) cdr) setCar:x))
    (- setCadddr:x is ((((self cdr) cdr) cdr) setCar:x))
)

(class Words is NSObject
    (ivars)
    (- initWithFile:file is
        (let ((p ((NuParser alloc) init))
              (s (NSString stringWithContentsOfFile:file encoding:4 error:nil))
              (l nil))
             (super init)
             (set l ((p parse:s) cdr))
             (set @words (l map:(do (e) (if (== (e length) 2) (append e '(0 0)) (else e)))))
             (set @top @words)
             self))

     (+ wordsWithResorceFile:file ofType:ext is
         ((Words alloc) initWithFile:((NSBundle mainBundle) pathForResource:file ofType:ext)))
              
     (- writeToFile:file is
         (let ((s "")
               (q (NSString stringWithCharacter:34)))
              (@words each:(do (e) (s appendString:
                  "(#{(e car)} #{q}#{(e cadr)}#{q} #{(e caddr)} #{(e cadddr)})#{(NSString carriageReturn)}")))
              (s writeToFile:file atomically:1 encoding:4 error:nil)))

     (- writeToResorceFile:file ofType:ext is
         (self writeToFile:((NSBundle mainBundle) pathForResource:file ofType:ext)))

     (- sortByNg is 
         (set @words (((@words array) sortedArrayUsingBlock:(do (x y) ((y cadddr) compare:(x cadddr))))
                        list))
         (set @top @words))

     (- isEnd is (== @top ()))
     (- top is  (@top car))
     (- next is (set @top (cdr @top)))
     (- setOk is ((@top car) setCaddr:(+ 1 ((@top car) caddr))))
     (- setNg is ((@top car) setCadddr:(+ 1 ((@top car) cadddr))))

     (- value is  @words)
)
     
