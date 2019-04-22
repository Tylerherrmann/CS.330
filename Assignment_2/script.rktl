#lang racket

(define image1  
 (list            
			(list 0 1) (list 0 2)            (list 0 4)            
			(list 1 1) (list 1 2)            (list 1 4)            (list 1 6) 
 (list 2 0) (list 2 1) (list 2 2)            (list 2 4)            (list 2 6)                                             
											 (list 3 4) (list 3 5) (list 3 6)            
			(list 4 1)            
			(list 5 1) (list 5 2) (list 5 3) (list 5 4) (list 5 5)            
			(list 6 1) (list 6 2) (list 6 3) 
)) 	

; This procedure takes in two raw pixels and compares the X and Y positions to determine if they are adjacent
(define adjacent
	(lambda (li1 li2)
		(cond
			[(and (eq? (car li1) (car li2)) (eq?(+ 1 (car(cdr li1))) (car(cdr li2)))) #t]
			[(and (eq? (car li1) (car li2)) (eq?(car(cdr li1)) (+ 1 (car(cdr li2))))) #t]
			[(and (eq? (+ 1 (car li1)) (car li2)) (eq?(car(cdr li1)) (car(cdr li2)))) #t]
			[(and (eq? (car li1) (+ 1 (car li2))) (eq?(car(cdr li1)) (car(cdr li2)))) #t]
			[else #f]
		)
	)
)
			

; Takes in a single "pixel" as li2 and a list of "pixels" as li1 and checks to see 
; if the passed "pixel" is within li1
(define member?
  (lambda (li1 li2)
    (cond
      ((null? li1) #f)
      ((and (eq? (car (car li1)) (car li2)) (eq? (car(cdr(car li1))) (car(cdr li2)))) #t)
      (#t (member? (cdr li1) li2))
	)
  )
)

; This procedure is used to check our "Answer" for containing certain pixels
; It takes the "answer" as li1 and the pixel as li2. This is used within 
; connectedComponents as a helper method for our recurssion.

(define notMember?
	(lambda (li1 li2)
		(cond
			((null? li1) #f)
			((member? (car li1) li2) #t)
			(#t (notMember? (cdr li1) li2))
		)
	)
)

; Takes in the image as li1 and a pixel as li2
; It then returns a list of all adjacent pixels within the image
; to the passed in pixel
(define filterAdj
  (lambda (li1 li2)
    (cond
      ((null? li1) '())
      ((adjacent (car li1) li2)
         (cons (car li1) (filterAdj (cdr li1) li2)))
      (#t (filterAdj (cdr li1) li2))
	)
  )
)	

; Takes in two lists of "pixels" one passed potential adjacent non-member pixels
; and one that is a component. Filters out pixels that are adjacent, non-member's of the component
; and returns them to then be added to the component. 
; li1 is the component, li2 is the list of adjacent pixels that may be added
(define filterMembers
  (lambda (li1 li2)
    (cond
      ((null? li2) '())
      ((not (member? li1 (car li2)))
         (cons (car li2) (filterMembers li1 (cdr li2))))
      (#t (filterMembers li1 (cdr li2)))
	)
  )
)


; Returns next possible moves using our two filters 
; li1 is the connected component that is being checked against, li2 is the image list, and li3 is the
; pixel we are starting from
(define possibleMoves
	(lambda (li1 li2 li3)
		(filterMembers li1 (filterAdj li2 li3))
	)
)

; This is a helper function I designed to combine two lists of pixels
; It combines the two lists and returns them, this is used within findConnected
(define combinePixels
	(lambda (li1 li2)
		(cond
			((and (null? li1) (null? li2)) '())
			((not (null? li1))
				(cons (car li1) (combinePixels (cdr li1) li2))
			)
			((not (null? li2))
				(cons (car li2) (combinePixels li1 (cdr li2)))
			)
		)
	)
)

; This procedure is pretty rough to read due to the complexity of what's happeneing here
; But essentially what it does is take in two empty lists as li1 and li4 initially
; The full image as li2 and a single pixel as li2
; li1 is the connected component that's being recurssed on.
; li2 is the image
; li3 is pixel
; li4 is "answer" aka the full connected component 
(define findConnected
	(lambda (li1 li2 li3 li4)
		(cond
			; Check to see if our starting "pixel" is part of component, if not then add it
			; This is essentially our starting point for this procedure to start connecting up the component
			; This will be our first pixel to recurse on
			((not (member? li4 li3)) 
				(cons li3 (findConnected (cons li3 li1) li2 li3 (cons li3 li4)))
			)
			
			; Check to see if all possible pixels that are part of this component have been checked 
			; If they have not, then check to see if there are anymore pixels that haven't been connected up to our "answer" or our return list
			; If they have then no more additional pixels are added to the list are we recurssing on
			((not (null? li1)) 
				(combinePixels (possibleMoves li4 li2 (car li1)) (findConnected (combinePixels (possibleMoves li4 li2 (car li1)) (cdr li1)) li2 li3 (combinePixels (possibleMoves li4 li2 (car li1)) li4)))
			)
			
			; Check to see if our list of pixels we are recurssing on is null, if it is then wrap the list and recurse back.
			((null? li1) '())
		)
	)
)


; This procedure is essentially our "main" it takes list of pixels aka our "image" in
; twice, once so we can perform recurssion on each pixel, and once so we can keep a static
; list of all pixels in the image for calling our helper procedures.
; li1 is our image that we will recurse on
; li2 is our "answer" which is initially an empty list with an empty list inside
; li3 will be the static full image list
(define connectedComponents
	(lambda (li1 li2 li3)
		
		(cond
		
			((null? li1) '())

			((not (notMember? li2 (car li1))) 
				(cons (findConnected '() li3 (car li1) '()) (connectedComponents (cdr li1) (cons (findConnected '() li3 (car li1) '()) li2) li3))
			)

			((notMember? li2 (car li1))
				(connectedComponents (cdr li1) li2 li3)
			)
			
		)

	)
)

(define connectedComponents
  (lambda (li1 li2 li3) 
    (cond
      ((null? li1) '())  
      (not (notMember? li2 (car li1))
        (cons (findConnected '() li3 (car li1) '()) (connectedComponents (cdr li1) (cons (findConnected '() li3 (car li1) '()) li2) li3)))
		
		; If we find a pixel that's already part of one of our components, keep recurssing 
		((notMember? li2 (car li1))
			(write ("I hate scheme"))
			(connectedComponents (cdr li1) li2 li3)
		)
      
    )
  )
)

; Call "Main" using our image and an empty list
(connectedComponents image1 '() image1)
