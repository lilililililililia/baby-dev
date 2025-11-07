# 第一周学习笔记

交易哈希:0x89a1a91e8e24b0a4421599f84d6f56329919c193512e121244b69a819976ccf2  
合约地址:0xe2caf24698e87a3423fa5c980760236e060a1e18  

## 基本数据类型  
uint(表示无符号整数，只能是正数), int(正数或负数), address(表示地址)，boolean(定义ture和false)  
string(字符串)  

## 定义一个函数
~~~
function 函数名 (定义传入的参数) (public or private) {  
    code;  
}  
~~~
## 定义一个结构体(类似于定义一个新的数据类型)  
~~~
struct 结构体的名字 {  
    code;  
}  
~~~
## 结构体的应用  
结构体的名字 (public/private/无) 变量名;  
类似于 uint number = 16;  
例如 People[] peoples;  

## 映射  
mapping 定义一个映射  
mapping (keytype => valuetype) 设置状态 变量名;  
keytype 称为键;  
valuetype 称为值;  
键 可以是 任何内置值类型(uint, address, bytes32, enum),但不能是复杂类型(struct, array, mapping);  
值 可以是 任何类型;  

## msg.sender  
表示地址(钱包的地址);  
