# HW 03 - Белкин Никита
### Description
Модуль **converter** экспортирует три функции: **to_rub/1**, **to_rub2/1** и **to_rub3/1**.

Функция **to_rub/1** принимает в качестве аргумента кортеж **{Currency, Amount}** и возвращает конвертированную сумму в рублях. Она проверяет достоверность входных данных, выполняет конвертацию и возвращает результат в виде кортежа **{ok, ConvertedAmount}** в случае успеха или **{error, badarg}** в случае неудачи.

Функции **to_rub2/1** и **to_rub3/1** по сути аналогичны **to_rub/1**, но используют разные синтаксисы для реализации одной и той же логики. 

Различие между **to_rub2/1** и **to_rub3/1**:
* **to_rub2** присваивает результат выражения case переменной Result перед тем, как вернуть его.
* **to_rub3** просто возвращает результат выражения case напрямую. 

Это различие незначительно и не влияет на функциональность кода.

### Output
```
Eshell V13.1.5  (abort with ^G)
1> c(“converter.erl”).
{ok,converter}
2> converter:to_rub({usd, 100}).
Convert usd to rub, amount 100
{ok,7550.0}
3> converter:to_rub({peso, 12}).
Convert peso to rub, amount 12
{ok,36}
4> converter:to_rub({yene, 30}).
Can't convert to rub, error {yene,30}
{error,badarg}
5> converter:to_rub({euro, -15}).
Can't convert to rub, error {euro,-15}
{error,badarg}
6> converter:to_rub2({usd, 100}).
Convert usd to rub, amount 100
{ok,7550.0}
7> converter:to_rub2({peso, 12}).
Convert peso to rub, amount 12
{ok,36}
8> converter:to_rub2({yene, 30}).
Can't convert to rub, error {yene,30}
{error,badarg}
9> converter:to_rub2({euro, -15}).
Can't convert to rub, error {euro,-15}
{error,badarg}
10> converter:to_rub3({usd, 100}).
Convert usd to rub, amount 100
{ok,7550.0}
11> converter:to_rub3({peso, 12}).
Convert peso to rub, amount 12
{ok,36}
12> converter:to_rub3({yene, 30}).
Can't convert to rub, error {yene,30}
{error,badarg}
13> converter:to_rub3({euro, -15}).
Can't convert to rub, error {euro,-15}
{error,badarg}
```

```converter:to_rub({yene, 30}).``` - функция сопоставляет входные данные с допустимыми валютами, и поскольку для "yene" нет соответствия, она переходит к последнему пункту, где возвращает кортеж ошибок.
```converter:to_rub({euro, -15}).``` - функция проверяет, является ли сумма положительным целым числом. "-15" таким не является, поэтому она переходит к последнему пункту и возвращает кортеж ошибок.

Функции **to_rub/1**, **to_rub2/1** и **to_rub3/1** возвращают одинаковый результат.