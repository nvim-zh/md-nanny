# md-nanny
> Strengthen the markdown in neovim
![head](https://user-images.githubusercontent.com/57088952/203006067-2c19be94-f1f1-4157-966f-580ab817b0e2.png)


# demo
```
# title 1
## title 2
### title 3
#### title 4
##### title 5
```
![title](https://user-images.githubusercontent.com/57088952/203004863-9c36aec8-b8da-4cfe-a96f-093ed22aaff5.png) 
```
#include <stdio.h>
int main (int argc, char *argv[])
{
  printf("hello world\n");
  return 0;
}
```
![codeblock](https://user-images.githubusercontent.com/57088952/203004928-b3f017e6-d994-4500-8b99-854373e89152.png) 
```
- [x] 学习rust
  - [x] list4 
  - asdf
1. asdf
  2. asdf
```
![list](https://user-images.githubusercontent.com/57088952/203004974-44927b81-d5ae-42c1-82db-1931fb773058.png) 
```
---
```
![break](https://user-images.githubusercontent.com/57088952/203005014-7164b26d-1ded-414c-8720-0d6897c16c52.png) 
```
| Day     |    Meal | Price |
| :------ | ------: | :---: |
| Monday  |   pasta |  $6   |
| Tuesday | chicken |  $8   |
```
![table](https://user-images.githubusercontent.com/57088952/203005052-59aad01a-9968-49a0-ac5f-fbcc0b50d7b6.png) 
```
> as
>> asdf
>>> asdf
```
![>>](https://user-images.githubusercontent.com/57088952/203005077-766e1a96-39b2-47b5-b5ef-7a661fc777b0.png) 

## install
### Using a plugin manager

Using plug:
```lua
Plug 'nvim-zh/md-nanny'
```

Using Packer:
```lua
return require("packer").startup( function(use)
 	use "nvim-zh/md-nanny"
 end
)
``` 

## Setup

```lua
require('md-nanny')
```


## Todo

- [x] add todo list
- [x] codeblock edit
- [ ] the flow chart
- [ ] The code block programming
- [ ] show image
- [ ] show link image
- [ ] mathematical formula to image show
- [ ] flow chat to image show
- [x] syntax table
