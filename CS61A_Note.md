##   CS61A Note
#### 1. Basic
##### 1.1 feature

**1.doctest:**
\>>>用来测试正确性，“”“解释函数的功能

   ```shell
   python3 -m doctest a.py
   ```
**2. assert:**
	assert exp, ''

**3. lambda function:**

   ```python
   lambda x: x**2
   ```
**4. decorator: @**
   @fn1, 在fn2上面，相当于执行fn1(fn2)

   ```python
   def trace1(fn):
       def traced(x):
           print('Calling', fn, 'on argument', x)
        	return fn(x)
    	return traced
   
   @trace1
   def square(x):
       return x * x
   
   >>> square(2)
   Calling <function square at 0x1006ee170> on argument 2
   4
   ```




##### 1.2 higher-order function

输入或输出为function，比如**self refernce:**
   ```python
def print_sums(x):
    print(x)
   	def next_sum(y):
    	return print_sums(x+y)
    return next_sum

>>> print_sums(1)(3)(5)
1
4
9
   ```

**curry:**
		将输入多个参数的函数转化为每次接受一个参数的函数

   ```python
   def curry2(f):
   	def g(x):
        	def h(y):
            	return f(x, y)
        	return h
   	return g
   >>> curry = lambda f: lambda x: lambda y: f(x,y)
   ```

#### 2. Recurrence
#### 3. Container and iterator
##### 3.1 list
   ```python
   >>> len(l)
   >>> [1,3] + l
   >>> list(range(8))
   >>> l.append(obj)
   >>> l.remove(obj)
   >>> l.pop(index = -1)
   >>> l.extend(seq)
   >>> l.insert(index,obj)
   >>> t = list(l)
   # list comprehension
   >>> [exp for <i> in <> if (condition)]
   # max中key的用法
   >>> max(list,key=lambda k:abs(k)
   ```
##### 3.2 dictionary
   ```python
   >>> d = {'key':value,...}
   >>> d[key]
   >>> d.key() # items(),values()
   >>> d.has_key()
   >>> pop(key[,default])
   ```
##### 3.3 iterator
iter(iterable): 返回一迭代器
		next(iterator): 返回迭代器中下一元素，并且更新迭代器
		如果字典的大小在迭代中改变，则迭代器无法使用。
		

##### 3.4 generator
以yield结束而不是return，返回一个generator。保存环境，下次从yield处继续进行

```python
>>> def all_pairs(s):
        for item1 in s:
            for item2 in s:
                yield (item1, item2)
>>> list(all_pairs([1, 2, 3]))
[(1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3), (3, 1), (3, 2), (3, 3)]
```
+ the first next call works like this:
	+ Enter the function and run until the line with yield.
	+ Return the value in the yield statement, but remember the state of the function for future next calls.

+ subsequent next calls work like this:
	+ Re-enter the function, start at the line after, and run until the next yield statement.
	+ Return the value in the yield statement, but remember the state of the function for future next calls.
	

`yield from` will yield all values from an iterator or iterable.

**built-in functions:**

+ map (func,iterable)
+ fliter (func,iterable)，当f(x)==True时进行迭代
+ zip (first,second)，同时迭代两个对象，next返回元组

##### 3.5 mutable objects
可变类型是引用类型，本身允许修改
```python
a=[1,2,3]
a=[1,2,3] #两个a指向的对象不同
```

##### 3.6 mutable function
nonlocal 变量，指向的是parent frame中的，否则是报错referenced before assignment

```python
def make_withdraw(balance):
    """Return a withdraw function with a starting balance."""
    def withdraw(amount):
        nonlocal balance
        # 或者 b = [balance], 用mutable value
        if amount > balance: #b[0]
            return 'Insufficient funds'
        balance = balance - amount
        return balance
    return withdraw
```
#### 4. object-oriented
##### 4.1 class
+ constructor
```python
def __init__(self,...)
```
+ method: 类中的函数
  可以通过.和getattr来访问属性
+ 注意 class attribute 和 instance  attribute的区别: 
  + class: 在 类中直接定义，由所有共享。用**classname.attribute**访问
  + instance: 在constructor中定义。用**object.attribute**访问

##### 4.2 inheritance
##### 4.3 representation
```python
repr(object) -> string 转为解释器读取的字符串形式
str(s)转化为人类可读
还原eval(repr(object)) == object.
```
repr和str：
```python
def repr(x):
    return type(x).__repr__(x)
#class attribute而不是instance
```
#### 5.data
##### 5.1 linked list
```python
class Link:
    empty = ()
    def __init__(self, first, rest=empty):
```
```python
def range_link(start, end):
    """Return a Link containing consecutive integers from start to end.
    >>> range_link(3, 6)
    Link(3, Link(4, Link(5)))
    """
    if start >= end:
        return Link.empty
    else:
        return Link(start, range_link(start + 1, end))


def map_link(f, s):
    """Return a Link that contains f(x) for each x in Link s.
    >>> map_link(square, range_link(3, 6))
    Link(9, Link(16, Link(25)))
    """
    if s is Link.empty:
        return s
    else:
        return Link(f(s.first), map_link(f, s.rest))


def filter_link(f, s):
    """Return a Link that contains only the elements x of Link s for which f(x)
    is a true value.

    >>> filter_link(odd, range_link(3, 6))
    Link(3, Link(5))
    """
    if s is Link.empty:
        return s
    filtered_rest = filter_link(f, s.rest)
    if f(s.first):
        return Link(s.first, filtered_rest)
    else:
        return filtered_rest
```
##### 5.2 tree
```python
class Tree:
    """A tree is a label and a list of branches."""
    def __init__(self, label, branches=[]):
        self.label = label
        for branch in branches:
            assert isinstance(branch, Tree)
        self.branches = list(branches)

def __repr__(self):
    if self.branches:
        branch_str = ', ' + repr(self.branches)
    else:
        branch_str = ''
    return 'Tree({0}{1})'.format(repr(self.label), branch_str)

def __str__(self):
    return '\n'.join(self.indented())

def indented(self):
    lines = []
    for b in self.branches:
        for line in b.indented():
            lines.append('  ' + line)
    return [str(self.label)] + lines

def is_leaf(self):
    return not self.branches
```

generator好搞人啊

#### 6.Scheme
Lisp语言，由表达式组成，[具体可以参考](https://inst.eecs.berkeley.edu/~cs61a/fa20/articles/scheme-spec.html#begin)
##### 6.1 
call expression，第一个是运算符，后面有*个算子

```scheme
(quotient 10 2)
(+ (* 3 5) (- 10 6))
```
special form
```scheme
(if <> <consequent> <alternative>)
; 只计算两个之一
(and <e1> ...<>)

; producers
(define (<name> <formal parameters>) <body>)
; 返回的是name
> (define (sqrt x)
    (define (update guess)
      (if (= (square guess) x)
          guess
          (update (average guess (/ x guess)))))
    (update 1))
> (sqrt 256)
16

; lambda
((lambda (x y z) (+ x y (square z))) 1 2 3)

; cond 后面可以接多个表达式，每个表达式中有一个predicate和一个body
(cond ((> x 10) (print 'big))
      ((> x 5)  (print 'medium))
      (else     (print 'small)))

; begin 组合多个表达式 
(if (> x 10) (begin
                (print 'big)
              	(print 'guy))
    		 (begin 
              	(print 'small)
              	(print 'fry)))

; let 暂时绑定到symbol
(define c (let ((a 3)
                (b (+ 2 2)))
            	(sqrt (+ (* a a) (* b b)))))
```
##### 6.2 lists
+ cons：两个参数，构建linked list
+ car返回第一个，cdr返回剩余元素
+ nil：empty list
+ list：
```scheme
; constructor con
> (define x (cons 2 nil))
> (car x)
1
> (cons 1 (cons 2 (cons 3 nil)))
(1 2 3)
; list procedure
> (list 1 (list 2 3) 4)
(1 (2 3) 4fil)
> (append '(1 2 3) '(4 5 6)) ; Concatenates two lists
(1 2 3 4 5 6)
> (eval (list 'quotient 10 2))
5
```
+ `'` 是quota，代指符号，` 是quasiquote
```scheme
> (define b 4)
> '(a ,(+ b 1))
(a (unquote (+ b 1)))
> `(a ,(+ b 1))
(a, 5)
```
```python
# try来处理exception
try:
	return ...
except ZeroDivisionError as e:
    print('handled',e)
    return ...
```
#### 7. SQL
declatative language：是对结果的描述，怎样得到结果是由解释器负责

imperative language: 是对计算结果的描述
```sql
#创建一行
select [exp] as [name]
#union合并行，create创建全局名称
create table [name] as [select stats];
select [columns] from [table] where [cond] order by [columns];
#alias 和 dot
select a.child as first b.child as second from parents as a, parents as b where []
#字符串连接||
#aggregate
>> count(*),avg()等等内置函数
>> group by 合并相同[]的rows
>> having
```
