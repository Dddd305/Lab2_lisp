(defun check-function (name actual expected)
  "Execute `my-reverse' on `input', compare result with `expected' and print
   comparison status"
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal actual expected)
          name))

;;; ================================================================
;;; Завдання 1. reverse-and-nest-tail
;;; Опис: Обертає список та утворює вкладену структуру.
;;; Використовує ХВОСТОВУ рекурсію (Tail Recursion) з акумулятором.
;;; ================================================================

(defun reverse-and-nest-tail-helper (lst acc)
  (if (null lst)
      acc ;; Базовий випадок: список порожній, повертаємо накопичений результат
      ;; Рекурсивний крок: беремо поточний елемент і 'огортаємо' ним акумулятор
      (reverse-and-nest-tail-helper (cdr lst) (list (car lst) acc))))

(defun reverse-and-nest-tail (lst)
  (if (null lst)
      nil
      ;; Ініціалізуємо акумулятор списком з першого елемента
      (reverse-and-nest-tail-helper (cdr lst) (list (car lst)))))

;;; Тести для Завдання 1
(defun test-reverse-and-nest-tail ()
  (format t "~%--- Testing reverse-and-nest-tail ---~%")
  (check-function "test 1 (a b c)" 
                  (reverse-and-nest-tail '(a b c)) 
                  '(C (B (A))))
  (check-function "test 2 (1 2 3 4)" 
                  (reverse-and-nest-tail '(1 2 3 4)) 
                  '(4 (3 (2 (1)))))
  (check-function "test 3 (single atom)" 
                  (reverse-and-nest-tail '(A)) 
                  '(A))
  (check-function "test 4 (empty)" 
                  (reverse-and-nest-tail nil) 
                  nil))

;;; ================================================================
;;; Завдання 2. compress-list
;;; Опис: Замінює послідовності однакових елементів на пари (кількість елемент).
;;; Використовує ПРОСТУ (лінійну) рекурсію.
;;; ================================================================

(defun compress-list-helper (lst current-val current-count)
  (cond
    ((null lst) 
     (list (list current-count current-val)))
    ((equal (car lst) current-val)
     (compress-list-helper (cdr lst) current-val (+ 1 current-count)))
    (t 
     (cons (list current-count current-val)
           (compress-list-helper (cdr lst) (car lst) 1)))))

(defun compress-list (lst)
  (if (null lst)
      nil
      (compress-list-helper (cdr lst) (car lst) 1)))

(defun test-compress-list ()
  (format t "~%--- Testing compress-list ---~%")
  (check-function "test 1 (mixed)" 
                  (compress-list '(1 a a 3 3 3 b)) 
                  '((1 1) (2 A) (3 3) (1 B)))
  (check-function "test 2 (all same)" 
                  (compress-list '(a a a a)) 
                  '((4 A)))
  (check-function "test 3 (single)" 
                  (compress-list '(x)) 
                  '((1 X)))
  (check-function "test 4 (empty)" 
                  (compress-list nil) 
                  nil))
