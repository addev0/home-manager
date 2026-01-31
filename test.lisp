;; Tree-sitter test for Lisp / Scheme

(define (factorial n)
  (cond
    ((<= n 1) 1)
    (else
     (* n (factorial (- n 1))))))

(let ((x 5)
      (y 10))
  (display (+ x y))
  (newline))

