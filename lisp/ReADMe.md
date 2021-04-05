№9 Определите функцию, разделяющую исходный список на два подсписка. В первый из них должны попасть элементы с нечетными номерами, во второй - элементы с четными номерами.
 ``` Lisp
 (setq X '(1 2 3 4 5 6))
 ; элементы с четными номерами
(defun nine2 (list) 
    (cond 
        ((NULL(cdr list)) Nil) 
        (T 
            (cons (cadr list) (nine2 (cddr list)))
        )
    )
)
; элементы с нечетными номерами
(defun nine (list) 
    (cond 
        (list (cons (car list) (nine (cddr list))))
    )
)
; итог
(list (nine X) (nine2 X))
```
№14. Определите функцию, осуществляющую перестановку двух элементов списка с заданными номерами.
``` Lisp
; определяет элемент списка с заданным номером
(defun z1 (list a) 
    (cond
        ((NULL(cdr list)) Nil)
        ((= a 1) (car list) )
        (T (z1 (cdr list) (- a 1)))
    )
)
(z1 '(2 3 1 4 7 67 65 21 19 32 97 61) 5)
; 7
; array - функция, которая переставляет элементы
; l и m - 2 одинаковых списка 
; n1 и n2 - заданные номера
(defun ARRAY (l m n1 n2)
    (cond
        ((NULL l) Nil)
         ((= (car l) (funcall #'z1 m n1)) (cons (funcall #'z1 m n2) (ARRAY (cdr l) m n1 n2)))
         ((= (car l) (funcall #'z1 m n2)) (cons (funcall #'z1 m n1) (ARRAY (cdr l) m n1 n2)))
        (T
            (cons (car l) (ARRAY(cdr l) m n1 n2))
        )
    )
)
(ARRAY '(2 1 3 4 5 6 8 7 9 21 11 13 22) '(2 1 3 4 5 6 8 7 9 21 11 13 22) 2 7)
; (2 8 3 4 5 6 1 7 9 21 11 13 22)
```
№16 Определите функцию, добавляющую элементы одного списка во второй список, начиная с заданной позиции.
``` Lisp
; объединение
(defun append1 (x y)
    (cond 
        ((NULL x) y)
        (T 
            (cons (car x) (append1 (cdr x) y))
        )
    )
)
; l и m - 2 одинаковых списка 
; n1 - заданный номер
(defun ARRAY (l m n n1)
    (cond
        ((NULL l) Nil)
         ((= (car l) (funcall #'z1 m n1)) (append1 n (ARRAY (cdr l) m n n1)))
         
        (T
            (cons (car l) (ARRAY(cdr l) m n n1))
        )
    )
)
(ARRAY '(2 1 3 4 5 6 8 7 9 21 11 13 22) '(2 1 3 4 5 6 8 7 9 21 11 13 22) '(99 999 999 999 99) 4)
; (2 1 3 99 999 999 999 99 5 6 8 7 9 21 11 13 22)
```
№23 Определите функции, преобразующие список (a b с) к виду (а (b (с))) и наоборот.

```Lisp
(defun twentythree (l)
    (cond
        ((NULL (cdr l)) l)
        (T
            (list  (car l) (twentythree (cdr l))  )
        )
    )
)
(twentythree '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))
;(1 (2 (3 (4 (5 (6 (7 (8 (9 (10 (11 (12 (13 (14 (15)))))))))))))))

(defun twentythree (l)
    (cond
        ((NULL (cdr l)) l)
        ((atom (car l)) (cons (car l) (twentythree (cadr l))))
        (T
            (twentythree (car l))
        )
    )
)
(twentythree '(1 (2 (3 (4 (5 (6 (7 (8 (9 (10 (11 (12 (13 (14 (15))))))))))))))))
; (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)
```
№27 Определите функцию, которая, чередуя элементы списков (a b...) и (1 2...), образует новый список (a 1 b 2 ...).
```Lisp
;l и m - списки
; i - подсчет, изначально равно 0
(defun twentyseven (l m i)
    (cond
        ((NULL l) m)
        ((NULL m) l)
        ((= (mod i 2) 0) (cons (car l) (twentyseven (cdr l) m (+ i 1))))
        ((= (mod i 2) 1) (cons (car m) (twentyseven l (cdr m) (+ i 1))))
    )
)
(twentyseven '(1 2 3 4 5) '(a b c d e f g h j k) 0)
; (1 A 2 B 3 C 4 D 5 E F G H J K)
```
№30 Запрограммируйте интерпретатор ВЫЧИСЛИ, который преобразует инфиксную запись операций в префиксную и возвращает значение выражения. Пример:
> (ВЫЧИСЛИ ’((-2 + 4) * 3))
6
``` lisp
(defun thirty (l)
    (cond
        ((null l) nil)
        ((atom l) l)
        (T
            (eval (list (cadr l) (thirty (car l))  (thirty (caddr l))))
        )
    )
)
(thirty '((-2 + 4) * 3))
; 6
```

№33 Определите функцию МНОЖЕСТВО, преобразующую список в множество.
``` Lisp
(defun thirtythree (l)
   (cond 
        ((null l) nil)
        ((member (car l) (cdr l)) (thirtythree (cdr l)))
        (T 
            (cons (car l) (thirtythree (cdr l)))
        )
    )
)
(thirtythree '(1 2 3 3 2 4 1 4 1 4 5))
;(3 2 1 4 5)
```

№34 Определите предикат РАВЕНСТВО-МНОЖЕСТВ, проверяющий совпадение двух множеств (независимо от порядка следования элементов). Подсказка: напишите функцию УДАЛИТЬ, удаляющую данный элемент из множества.
``` Lisp
(defun thirtyfour (l m)
   (cond
        ((null l) 'yes)
        ((member (car l) m) (thirtyfour (cdr l) m))
        (T
            'no
        )
    )
)
(thirtyfour '(1 2 3 4 5) '(5 4 3 2 1))
; YES
(thirtyfour '(1 2 3 4 5) '(5 4 3 21))
;NO
```

№41 Реализовать генератор деревьев, чтобы выдаваемые им деревья имели количество вершин, точно соответствующее числу, указанному в его первом аргументе.

 ``` Lisp
 ; i - количество вершин
 ; j - подсчет
 (defun tree (i j)
    (cond 
        ((= i j) (list `( ,(eval j)  ())))
        ((= j 1) (list 1 (tree i (+ j 1)) ))
        (T
            ( cons `( ,(eval j)  ()) (tree i (+ j 1)) )
        )
    )
)
(tree 4 1)
; (1 ((2 NIL) (3 NIL) (4 NIL)))
```
№48 . Функция GET возвращает в качестве результата NIL в том случае, если у символа нет данного свойства, либо если значением этого свойства является NIL. Следовательно, функцией GET нельзя проверить, есть ли некоторое свойство в списке свойств. Напишите предикат (ИМЕЕТ-СВОЙСТВО символ свойство), который проверяет, обладает ли символ данным свойством.
``` Lisp
(defun hasfeature (i l)
    (cond 
        ((null (symbol-plist i)) 'yes)
        ((equal (car (symbol-plist i)) (car l)) 
            (remprop i (car (symbol-plist i)))
            (hasfeature i (cddr l))) 
        (T
            'no
        )
    )
)
(setf (get 'task '1) '10)
(setf (get 'task '2) '(11 12))
(setf (get 'task '3) '(13))
(setf (get 'task '4) '14)
(symbol-plist 'task)
; (4 14 3 (13) 2 (11 12) 1 10)
(hasfeature 'task '(2 3 1))
; NO
(hasfeature 'task '(4 14 3 (13) 2 (11 12) 1 10))
; YES
```
### Функции высших порядков
№1 Определите FUNCALL через функционал APPLY.
``` Lisp
(defun funcall1 (f &rest x) (apply f x))

(funcall1 '* 2 3 5)
(funcall1 '+ 2 3 5)
```
№3 Определите функционал (APL-APPLY f x), который применяет каждую функцию fi списка
(f1 f2 ... fn)
к соответствующему элементу списка
x = (x1 x2 ... xn)
и возвращает список, сформированный из результатов.
``` Lisp
(defun apl-apply (f x)
    (cond
        ((null x) nil)
        (T (cons (apply (car f) (car x)) (apl-apply (cdr f) (cdr x))))
    )
)
; f1, f2,f3 - созданы для примера apl-apply
(defun f1 (x) (* x x))
(defun f2 (x) (* x (f1 x)))
(defun f3 (x) (* x (f2 x)))

(apl-apply '(f1 f2 f3) '((3) (3) (3)))
```
