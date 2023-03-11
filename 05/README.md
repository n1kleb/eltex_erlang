# HW 05 - Белкин Никита
## Description
### Task 1
Заголовочный файл person.hrl используется для определения записей (record) и макросов. Здесь определен record person со следующими полями: id, name, age, gender. Макросы MALE и FEMALE используются для определения значения поля gender записи person.
Модуль persons определяет несколько функций для работы с записями person, определенными в файле person.hrl. Функции filter, all, any и update принимают список Persons записей и функцию Fun, которая определяет, какие записи будут отфильтрованы, проверены или изменены. Функция get_average_age вычисляет средний возраст всех записей в списке Persons.

### Task 2
Для выполнения List comprehensions в Eshell использовались генераторы списков.

### Task 3
Модуль exceptions содержит функцию catch_all/1. Она принимает один аргумент, который должен быть функцией с нулевым аргументом. Выполнение этой функции обернуто блоком try-catch, который перехватывает и печатает любое возникающее исключение. Функция catch_all/1 возвращает кортеж, содержащий либо {ok, Result} при успешном выполнении функции, либо исключение при возникновении ошибки.

## Output
### Task 1
```
Eshell V13.1.5  (abort with ^G)
1> c(persons).       
{ok,persons}
2> rr("person.hrl").
[person]
3> Persons = [#person{id = 1, name = "Bob", age = 23, gender = male}, #person{id = 2, name = "Kate", age = 20, gender = female}, #person{id = 3, name = "Jack", age = 34, gender = male}, #person{id = 4, name = "Nata", age = 54, gender = female}].
[#person{id = 1,name = "Bob",age = 23,gender = male},   
 #person{id = 2,name = "Kate",age = 20,gender = female},
 #person{id = 3,name = "Jack",age = 34,gender = male},  
 #person{id = 4,name = "Nata",age = 54,gender = female}]
4> persons:filter(fun(#person{age = Age}) -> Age >= 30 end, Persons).
[#person{id = 3,name = "Jack",age = 34,gender = male},  
 #person{id = 4,name = "Nata",age = 54,gender = female}]
5> persons:filter(fun(#person{gender = Gender}) -> Gender =:= male end, Persons).
[#person{id = 1,name = "Bob",age = 23,gender = male}, 
 #person{id = 3,name = "Jack",age = 34,gender = male}]
6> persons:any(fun(#person{gender = Gender}) -> Gender =:= female end, Persons).
true
7> persons:all(fun(#person{age = Age}) -> Age >= 20 end, Persons).
true
8> persons:all(fun(#person{age = Age}) -> Age =< 30 end, Persons).
false
9> UpdateJackAge = fun(#person{name = "Jack", age = Age} = Person) -> Person#person{age = Age + 1}; (Person) -> Person end.
#Fun<erl_eval.42.3316493>
10> persons:update(UpdateJackAge, Persons).
[#person{id = 1,name = "Bob",age = 23,gender = male},
 #person{id = 2,name = "Kate",age = 20,gender = female},
 #person{id = 3,name = "Jack",age = 35,gender = male},
 #person{id = 4,name = "Nata",age = 54,gender = female}]
11> UpdateFemaleAge = fun(#person{gender = female, age = Age} = Person) -> Person#person{age = Age - 1}; (Person) -> Person end.
#Fun<erl_eval.42.3316493>
12> persons:update(UpdateFemaleAge, Persons).
[#person{id = 1,name = "Bob",age = 23,gender = male},
 #person{id = 2,name = "Kate",age = 19,gender = female},
 #person{id = 3,name = "Jack",age = 34,gender = male},
 #person{id = 4,name = "Nata",age = 53,gender = female}]
```

```c(persons).``` - компилируется модуль "persons" с помощью команды "c(persons)".

```rr("person.hrl").``` - подключается заголовочный файл "person.hrl" с помощью команды "rr("person.hrl")".

```Persons = [#person{id = 1, name = "Bob", age = 23, gender = male}, #person{id = 2, name = "Kate", age = 20, gender = female}, #person{id = 3, name = "Jack", age = 34, gender = male}, #person{id = 4, name = "Nata", age = 54, gender = female}].``` - создаются четыре записи типа #person и сохраняются в переменной Persons.

```persons:filter(fun(#person{age = Age}) -> Age >= 30 end, Persons).``` - выполняется фильтрация записей Persons по возрасту, оставляя только тех, кто старше или равен 30 лет.

```persons:filter(fun(#person{gender = Gender}) -> Gender =:= male end, Persons).``` - выполняется фильтрация записей Persons по полу, оставляя только мужчин.

```persons:any(fun(#person{gender = Gender}) -> Gender =:= female end, Persons).``` - проверяется, есть ли в Persons хотя бы одна женщина.

```persons:all(fun(#person{age = Age}) -> Age >= 20 end, Persons).``` - проверяется, что все записи Persons старше или равны 20 лет.

```persons:all(fun(#person{age = Age}) -> Age =< 30 end, Persons).``` - проверяется, что не все записи Persons младше или равны 30 годам.

```UpdateJackAge = fun(#person{name = "Jack", age = Age} = Person) -> Person#person{age = Age + 1}; (Person) -> Person end.``` - создается функция UpdateJackAge, которая увеличивает возраст Джека на 1 год, и затем она применяется к каждой записи в Persons с помощью функции update из модуля persons.

```persons:update(UpdateJackAge, Persons).``` - выводится обновленный список Persons после применения функции UpdateJackAge.

```UpdateFemaleAge = fun(#person{gender = female, age = Age} = Person) -> Person#person{age = Age - 1}; (Person) -> Person end.``` - создается функция UpdateFemaleAge, которая уменьшает возраст женщин на 1 год, и затем она применяется к каждой записи в Persons с помощью функции update из модуля persons.

```persons:update(UpdateFemaleAge, Persons).``` - выводится обновленный список Persons после применения функции UpdateFemaleAge.

### Task 2
```
Eshell V13.1.5  (abort with ^G)
1> [X || X <- lists:seq(1, 10), X rem 3 =:= 0].  
[3,6,9]
2> [X * X || X <- [1, "hello", 100, boo, "boo", 9], is_integer(X)].  
[1,10000,81]
```

```[X || X <- lists:seq(1, 10), X rem 3 =:= 0].``` - генератор списка X <- lists:seq(1, 10) создает список чисел от 1 до 10, затем используется условие X rem 3 =:= 0, которое выбирает только числа, которые делятся на 3 без остатка. В результате получается список [3,6,9].

```[X * X || X <- [1, "hello", 100, boo, "boo", 9], is_integer(X)].``` - генератор списка X <- [1, "hello", 100, boo, "boo", 9] создает список из различных типов значений. Затем используется условие is_integer(X), которое выбирает только целочисленные значения. Каждое значение из списка, проходящее через условие, возводится в квадрат с помощью оператора *. В результате получается список [1,10000,81].

### Task 3
```
Eshell V13.1.5  (abort with ^G)
1> c(exceptions).
{ok,exceptions}
2> exceptions:catch_all(fun() -> 1/0 end).
Action #Fun<erl_eval.43.3316493> failed, reason badarith
error
3> exceptions:catch_all(fun() -> throw(custom_exceptions) end).  
Action #Fun<erl_eval.43.3316493> failed, reason custom_exceptions
throw
4> exceptions:catch_all(fun() -> exit(killed) end).
Action #Fun<erl_eval.43.3316493> failed, reason killed
exit
5> exceptions:catch_all(fun() -> erlang:error(runtime_exception) end).
Action #Fun<erl_eval.43.3316493> failed, reason runtime_exception
error
```

```exceptions:catch_all(fun() -> 1/0 end).``` - функция деления на ноль вызывает исключение badarith, которое обрабатывается блоком error:Reason и выводится сообщение об ошибке с указанием функции, вызвавшей исключение, и причиной ошибки.

```exceptions:catch_all(fun() -> throw(custom_exceptions) end).``` - функция throw/1 вызывает пользовательское исключение custom_exceptions, которое обрабатывается блоком throw:Reason и выводится сообщение об ошибке с указанием вызвавшей функции и причины исключения.

```exceptions:catch_all(fun() -> exit(killed) end).``` - функция exit/1 прерывает выполнение программы с помощью сигнала killed, который обрабатывается блоком exit:Reason и выводится сообщение об ошибке с указанием вызвавшей функции и причины исключения.

```exceptions:catch_all(fun() -> erlang:error(runtime_exception) end).``` - функция erlang:error/1 вызывает исключение runtime_exception, которое обрабатывается блоком error:Reason и выводится сообщение об ошибке с указанием вызвавшей функции и причины ошибки.