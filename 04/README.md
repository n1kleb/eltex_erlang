# HW 04 - Белкин Никита
## Description
### Task 1-2 
Модуль **converter** предоставляет две функции для конвертации различных валют в российские рубли с учетом комиссии.

Первая функция, **rec_to_rub/1**, принимает в качестве аргумента запись типа **conv_info**, извлекает из нее тип валюты, сумму и комиссию, вычисляет конвертированную сумму, вычитает комиссию и возвращает результат в виде кортежа. Функция также выводит сообщение на консоль с указанием деталей конвертации.

Вторая функция, **map_to_rub/1**, принимает в качестве аргумента **map** вместо записи, но в остальном функционирует так же, как и **rec_to_rub/1**.

Обе функции имеют схожую логику реализации, используя сопоставление шаблонов для соответствия входных аргументов, а затем выполняя соответствующее вычисление преобразования. Если входной аргумент недействителен, функция возвращает кортеж ошибок и выводит сообщение об ошибке на консоль.

### Task 3
Модуль **recursion** содержит реализации функций **tail_fac/1**, **duplicate/1** и **tail_duplicate/1**.

В функции **tail_fac/1** реализована хвостовая рекурсия для функции факториала. Используем аккумулятор для хранения промежуточного результата, чтобы избежать накопления стека при рекурсивных вызовах.

Функции **duplicate/1** и **tail_duplicate/1** выполняют одну и ту же задачу - дублируют элементы списка. В функции **duplicate/1** мы используем рекурсию без аккумулятора, а в функции **tail_duplicate/1** - хвостовую рекурсию с аккумулятором.

### Task 4
Для создания алиасов для функций **recursion:tail_fac/1** и **recursion:tail_duplicate/1** использовалась функция **erlang:fun/1**.

### Task 5
Для создания анонимных функций в **Eshell** так же использовалась функция **erlang:fun/1**.

## Output
### Task 1
```
Eshell V13.1.5  (abort with ^G)
1> c("converter.erl").                                                             
{ok,converter}
2> rd(conv_info, {type, amount, commission}).                                      
conv_info
3> converter:rec_to_rub(#conv_info{type = usd, amount = 100, commission = 0.01}).
Convert usd to rub, amount 100, commission 0.01
{ok,7474.5}
4> converter:rec_to_rub(#conv_info{type = peso, amount = 12, commission = 0.02}).
Convert peso to rub, amount 12, commission 0.02
{ok,35.28}
5> converter:rec_to_rub(#conv_info{type = yene, amount = 30, commission = 0.02}).
Can't convert to rub, error {conv_info,yene,30,0.02}
{error,badarg}
6> converter:rec_to_rub(#conv_info{type = euro, amount = -15, commission = 0.02}).
Can't convert to rub, error {conv_info,euro,-15,0.02}
{error,badarg}
```

```converter:rec_to_rub(#conv_info{type = usd, amount = 100, commission = 0.01}).``` - преобразует 100 долларов в рубли с комиссией 1%. Выводит сообщение "Convert usd to rub, amount 100, commission 0.01", а затем возвращает {ok, Result}, где Result равен конвертированной сумме минус комиссия.

```converter:rec_to_rub(#conv_info{type = peso, amount = 12, commission = 0.02}).``` - преобразует 12 песо в рубли с комиссией 2%. Выводит сообщение "Convert peso to rub, amount 12, commission 0.02", а затем возвращает {ok, Result}, где Result равен конвертированной сумме минус комиссия.

```converter:rec_to_rub(#conv_info{type = yene, amount = 30, commission = 0.02}).``` - так как "yene" не указана в функции, вызов приведет к выполнению последнего сопоставления с образцом, что приведет к ошибке. Выводит сообщение "Can't convert to rub, error {conv_info,yene,30,0.02}" и возвращает {error, badarg}.

```converter:rec_to_rub(#conv_info{type = euro, amount = -15, commission = 0.02}).``` - преобразует -15 евро в рубли с комиссией 2%. Так как сумма отрицательна, то условие Amount > 0 не выполняется и функция вернет {error, badarg}. Выводит сообщение "Can't convert to rub, error {conv_info,euro,-15,0.02}".

### Task 2
```
Eshell V13.1.5  (abort with ^G)
1> c("converter.erl").
{ok,converter}
2> converter:map_to_rub(#{type => usd, amount => 100, commission => 0.01}).
Convert usd to rub, amount 100, commission 0.01
{ok,7474.5}
3> converter:map_to_rub(#{type => peso, amount => 12, commission => 0.02}).
Convert peso to rub, amount 12, commission 0.02
{ok,35.28}
4> converter:map_to_rub(#{type => yene, amount => 30, commission => 0.02}).
Can't convert to rub, error #{amount => 30,commission => 0.02,type => yene}
{error,badarg}
5> converter:map_to_rub(#{type => euro, amount => -15, commission => 0.02}).
Can't convert to rub, error #{amount => -15,commission => 0.02,type => euro}
{error,badarg}
```

```converter:map_to_rub(#{type => usd, amount => 100, commission => 0.01}).``` - аналогичный результат, как для функции **rec_to_rub/1**.

```converter:map_to_rub(#{type => peso, amount => 12, commission => 0.02}).``` - аналогичный результат, как для функции **rec_to_rub/1**.

```converter:map_to_rub(#{type => yene, amount => 30, commission => 0.02}).``` - аналогичный результат, как для функции **rec_to_rub/1**, только сообщение об ошибке в другом формате: Can't convert to rub, error #{amount => 30,commission => 0.02,type => yene}.

```converter:map_to_rub(#{type => euro, amount => -15, commission => 0.02}).``` - аналогичный результат, как для функции **rec_to_rub/1**, только сообщение об ошибке в другом формате: Can't convert to rub, error #{amount => -15,commission => 0.02,type => euro}.

### Task 3
```
Eshell V13.1.5  (abort with ^G)
1> c(recursion).
{ok,recursion}
2> recursion:tail_fac(5).
120
3> recursion:tail_fac(0).
1
4> recursion:duplicate([1, 2, 3]).
[1,1,2,2,3,3]
5> recursion:duplicate([]).
[]
6> recursion:tail_duplicate([1, 2, 3]).
[1,1,2,2,3,3]
7> recursion:tail_duplicate([]).
[]
```

```recursion:tail_fac(5).``` - вывод факториала числа 5 (=120).

```recursion:tail_fac(0).``` - вывод факториала числа 0 (=1).

```recursion:duplicate([1, 2, 3]).``` - вывод результата дублирования списка [1, 2, 3] (=[1,1,2,2,3,3]).

```recursion:duplicate([]).``` - вывод результата дублирования пустого списка [] (=[]).

```recursion:tail_duplicate([1, 2, 3]).``` и ```recursion:tail_duplicate([]).``` выведут то же самое, что и **duplicate/1**.

### Task 4
```
Eshell V13.1.5  (abort with ^G)
1> c("recursion.erl").           
{ok,recursion}
2> TailFac = fun recursion:tail_fac/1. 
fun recursion:tail_fac/1
3> TailFac(10).                        
3628800
4> TailDup = fun recursion:tail_duplicate/1. 
fun recursion:tail_duplicate/1
5> TailDup([1, 2, 3]).                       
[1,1,2,2,3,3]
```

```TailFac = fun recursion:tail_fac/1.``` - создали алиас для функции **recursion:tail_fac/1**.

```TailFac(10).``` - убедились в правильности работы алиаса (=3628800).

```TailDup = fun recursion:tail_duplicate/1.``` - создали алиас для функции **recursion:tail_duplicate/1**.

```TailDup([1, 2, 3]).``` - убедились в правильности работы алиаса (=[1,1,2,2,3,3]).

### Task 5
```
Eshell V13.1.5  (abort with ^G)
1> Multiply = fun(A, B) -> A * B end.
#Fun<erl_eval.41.3316493>
2> Multiply(2, 10).
20 
3> ToRub = fun ({usd, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [usd, Amount]), {ok, Amount * 75.5}; ({euro, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [euro, Amount]), {ok, Amount * 80}; ({lari, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [lari, Amount]), {ok, Amount * 29}; ({peso, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [peso, Amount]), {ok, Amount * 3}; ({krone, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [krone, Amount]), {ok, Amount * 10}; (Error) -> io:format("Can't convert to rub, error ~p~n", [Error]), {error, badarg} end.
#Fun<erl_eval.42.3316493>
4> ToRub({usd, 100}).
Convert usd to rub, amount 100
{ok,7550.0}
```

```Multiply = fun(A, B) -> A * B end.``` - создаем анонимную функцию **Multiply** для умножения двух элементов.

```Multiply(2, 10).``` - убедились в правильности работы анонимной функции (=20).

```ToRub = fun ({usd, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [usd, Amount]), {ok, Amount * 75.5}; ({euro, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [euro, Amount]), {ok, Amount * 80}; ({lari, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [lari, Amount]), {ok, Amount * 29}; ({peso, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [peso, Amount]), {ok, Amount * 3}; ({krone, Amount}) when is_integer(Amount), Amount > 0 -> io:format("Convert ~p to rub, amount ~p~n", [krone, Amount]), {ok, Amount * 10}; (Error) -> io:format("Can't convert to rub, error ~p~n", [Error]), {error, badarg} end.``` - создаем анонимную функцию **ToRub** для конвертации рублей в другие валюты.

```ToRub({usd, 100}).``` - убедились в правильности работы анонимной функции (=7550.0).
