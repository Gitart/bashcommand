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

# Var 2
 Populate it with one target URL per line:
 
## myurls.txt
```
http://www.example.com/
http://www.example.com/foo.html
http://www.example.com/foo/bar/
http://www.example.com/foo/bar/?v=1
```

This file is read and each URL will passed into ab through parallel as such:
```
cat myurls.txt | parallel "ab -n 10000 -c 10 {}"
```


