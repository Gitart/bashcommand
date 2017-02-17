

## Описание проблемы при вставке в базу данных SQL данных через параметер

Есть готовая программа написанная на GO. 

При ее запусе в командном файле с параметром, в русской раскладке в базу данных попадает запись в неправильной кодировке.
Для решения этой задачи необходимо установить в начале файла кодировку конвертор **CHCP 65001**.      
Файл в создан в кодировке UTF-8. В этом случае все другие русской кодировки такие как 1251, 1252, 855, 866 не работают.  

### Run.bat

```bat
    echo off>nul         
    chcp  65001       
    r.exe "Добавление новой записи 65001"       
```


### Пример программы

```go
package main

import (
 // _ "code.google.com/p/odbc"
    _ "github.com/alexbrainman/odbc"
      "database/sql"
      "fmt"
      "os"
    //"github.com/astaxie/beedb"
    //"github.com/weigj/go-odbc"
)


func main() {
// pid:=os.Getppid()
    pif:=os.Args[1]
    Addtodatabase(pif)
}

func Addtodatabase(Txt string){

    // db, err := sql.Open("odbc", "driver={sql server};server=.;uid=sa;pwd=password;database=DB")
    db, err := sql.Open("odbc", "driver={sql server};server=170.20.60.1;uid=User1;pwd=Password;database=DB")

    if err != nil {
        fmt.Println(err)
        return
    }

    /*stms, err := db.Prepare("INSERT INTO dbo.Test (playname, MATCH ) VALUES ( ?, ? )")
    _, err = stms.Exec("zk", 23)
    CheckError(err)*/
    /*stmt, err := db.Prepare("delete from Test where playname=?")
    CheckError(err)

    res, err := stmt.Exec("zk")
    CheckError(err)

    affect, err := res.RowsAffected()
    CheckError(err)

    fmt.Println(affect)*/

    /*stms, err := db.Prepare("update Test set Match=? where playname=?")
    _, err = stms.Exec(12, "p")
    CheckError(err)*/
    
    // rows, err := db.Query("SELECT MATCH FROM Test where playname=?", "p")
    stms,_ := db.Prepare("INSERT INTO Plans(Title, Startdate, Montsname, [User], Description) VALUES(?,?,?,?,?)")
    _, Err := stms.Exec(Txt,"2016-02-03","Jaunary","adm","New") // Количество столько же сколько и переменніх

    if Err != nil {
        fmt.Println("DDD",Err)
        return
    }

    defer db.Close()

    // var match int
    // for rows.Next() {
    //     rows.Scan(&match)
    //     fmt.Println(match)
    // }


}


func CheckError(err error) {
    if err != nil {
        panic(err)
    }
}
```

* Формирования BAT файла для втавки в базу параметра
