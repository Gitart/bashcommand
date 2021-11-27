## Base command

```
    -o /dev/null    # no outpot
    --silent        # no vizialization
    --write-out     "%{http-code}"  #output code 
```


# Load file to service

```sh
!/bin/bash

clear
echo Test ...

# curl -i -X GET http://localhost:1255/app/info -d 'name=Joe' -d 'email=joe@labstack.com'


echo start
for number in {1..50000}
do
# echo "$number "
curl -XPOST "http://127.0.0.1:1255/insert" -H "Accept: application/json" -H "Content-type: application/json" --silent -o /dev/null     -T "dat.json"
done


echo FINISH========================
```                                            
                                            
                                            
                                            

## Show HTML code

```
~]# curl --write-out "%{http_code}" http://www.example.com/index.html
<html>
  <body>
    Hello World
  </body>
</html>
200
```

 
## Show  code
You may want to also use the -s or --silent flag and the -o /dev/null option to suppress the response body output. Now, only the HTTP response code is returned.

```
curl --silent --output /dev/null --write-out "%{http_code}" http://www.example.com/index.html

200
```

 

In this example, 404 (not found) is returned when attempting to get foo.html from the www.example.com web server, because there is no such file as foo.html on the www.example.com web server.
```
curl --silent --output /dev/null --write-out "%{http_code}" http://www.example.com/foo.html
404
```

