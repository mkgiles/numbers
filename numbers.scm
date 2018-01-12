(define units '(un duo tre quattuor quinqua se septe octo nove))
(define units (map symbol->string units))
(define tens '(dec vigint trigint quadragint quinquagint sexagint septuagint octogint nonagint))
(define tens (map symbol->string tens))
(define hundreds '(cent ducent trecent quadringent quingent sescent septingent octingent nongent))
(define hundreds (map symbol->string hundreds))
(define decimals '(zero one two three four five six seven eight nine))
(define decimals (map symbol->string decimals))
(define teens '(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen))
(define teens (map symbol->string teens))
(define human-tens '(ten twenty thirty forty fifty sixty seventy eighty ninety))
(define human-tens (map symbol->string human-tens))
(define human-prefixes '("m" "b" "tr" "quadr" "quint" "sext" "sept" "oct" "non"))

(define (prefix n)
  (let
    ((k (quotient n 10)))
    (cond
      ((= k 0) (if (> n 0) (list-ref units (- n 1)) ""))
      ((< k 10) (string-append (prefix (modulo n 10)) (list-ref tens (- (quotient n 10) 1))))
      ((>= k 10) (string-append (prefix (modulo n 100)) (list-ref hundreds (- (quotient n 100) 1)))))))
(define (number-block n i b)
  (let*
    ((num (number->string n))
     (index (if (> i (string-length num)) (modulo i b) (- (string-length num) i)))
     (block (if (> i (string-length num)) (- b (- i (string-length num))) b)))
    (string->number (substring num index (+ index block)))))
(define (human-number n) (let ((k (quotient n 10))) (cond ((= k 0) (list-ref decimals n)) ((= k 1) (list-ref teens (- n 10))) ((< k 10) (string-append (list-ref human-tens (- k 1)) (if (= 0 (modulo n 10)) "" (string-append "-" (list-ref decimals (- n (* 10 k))))))) ((< k 100) (string-append (human-number (quotient k 10)) " hundred" (if (> (modulo n 100) 0) (string-append " and " (human-number (modulo n 100))) ""))))))
(define (index e)
  (if (< e 3) ""
  (let
    ((k (modulo e 6))
     (n (if (< e 60) (list-ref human-prefixes (quotient (- e 6) 6)) (prefix (quotient e 6)))))
    (if (< e 6) "thousand"
    (case k
      ((0 1 2) (string-append n "illion"))
      ((3 4 5) (string-append n "illiard")))))))
(define (namei n d s) (let* ((block (human-number (number-block n d 3))) (index (index (- d 1))) (name (if (equal? block "zero") s (string-append block (if (not (equal? index "")) " " "") index (if (not (equal? s "")) " " "") s)))) (if (<= (expt 10 d) n) (namei n (+ d 3) name) (if (and (< n 1000) (equal? block "zero")) "zero" name))))
(define (name n) (namei n 3 ""))
