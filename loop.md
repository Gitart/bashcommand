## Прокуртука строк из файла


## File

### urls
```
hello
world
hello world
```

## This program

```sh
#!/bin/bash

for i in $(cat urls); do
    echo "tester: $i"
done
```




## outputs
```
tester: hello
tester: world
tester: hello
tester: world
```
