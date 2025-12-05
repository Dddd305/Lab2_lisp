<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПІСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
з дисципліни "Вступ до функціонального програмування"<br/>
Тема: "Рекурсія"
</p>
<p align="right"><b>Студент:</b> КВ-23 Домущі Дмитро</p>
<p align="right"><b>Рік:</b> 2025</p>

## Загальне завдання
Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком (-ами), за можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно реалізувати, задаються варіантом. Вимоги до функцій:
1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій для роботи зі списками, що не наведені в четвертому розділі навчального посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.

## Варіант 8
1. Написати функцію reverse-and-nest-tail , яка обертає вхідний список та утворює
вкладeну структуру з підсписків з його елементами, починаючи з хвоста:
```lisp
CL-USER> (reverse-and-nest-tail '(a b c))
(C (B (A)))
```

2. Написати функцію compress-list , яка заміщає сукупності послідовно
розташованих однакових елементів списку двоелементними списками виду
(кількість-повторень елемент):
```lisp
CL-USER> (compress-list '(1 a a 3 3 3 b))
((1 1) (2 A) (3 3) (1 B))
```

## Лістинг функції reverse-and-nest-tail

```lisp
(defun reverse-and-nest-tail-helper (lst acc)
  (if (null lst)
      acc
      (reverse-and-nest-tail-helper (cdr lst) (list (car lst) acc))))

(defun reverse-and-nest-tail (lst)
  (if (null lst)
      nil
      (reverse-and-nest-tail-helper (cdr lst) (list (car lst)))))
```
###Тестові набори та утиліти
```lisp
(defun check-function (name actual expected)
  "Execute `my-reverse' on `input', compare result with `expected' and print
   comparison status"
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal actual expected)
          name))

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
```
###Тестування
```lisp
CL-USER> (test-reverse-and-nest-tail)

--- Testing reverse-and-nest-tail ---
passed test 1 (a b c)
passed test 2 (1 2 3 4)
passed test 3 (single atom)
passed test 4 (empty)
NIL
```
## Лістинг функції compress-list

```lisp
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
```
### Тестові набори та утиліти
```lisp
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
```

### Тестування
```lisp
CL-USER> (test-compress-list)

--- Testing compress-list ---
passed test 1 (mixed)
passed test 2 (all same)
passed test 3 (single)
passed test 4 (empty)
NIL
```


