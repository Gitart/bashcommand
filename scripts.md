# Скрипты оболочки

> ## обзор
>
> **Обучение:** 30 мин.
> **Упражнения:** 15 мин.
>
> **Вопросов**
>
> *   Как я могу сохранить и повторно использовать команды?
>
>
> **Цели**
>
> *   Напишите сценарий оболочки, который запускает команду или серию команд для фиксированного набора файлов.
>
> *   Запустите сценарий оболочки из командной строки.
>
> *   Напишите сценарий оболочки, который работает с набором файлов, определенных пользователем в командной строке.
>
> *   Создайте конвейеры, которые включают сценарии оболочки, которые вы и другие написали.
>

Мы наконец готовы посмотреть, что делает оболочку такой мощной средой программирования. Мы собираемся взять команды, которые мы часто повторяем, и сохранить их в файлах, чтобы мы могли снова запустить все эти операции позже, набрав одну команду. По историческим причинам куча команд, сохраненных в файле, обычно называется **сценарием оболочки** , но не ошибайтесь: на самом деле это небольшие программы.

Давайте начнем с возвращения к `molecules/` созданию нового файла, `middle.sh` который станет нашим сценарием оболочки:

```
$ cd molecules
$ nano middle.sh

```

Команда `nano middle.sh` открывает файл `middle.sh` в текстовом редакторе 'nano' (который запускается внутри оболочки). Если файл не существует, он будет создан. Мы можем использовать текстовый редактор для непосредственного редактирования файла \- мы просто вставим следующую строку:

```
head -n 15 octane.pdb | tail -n 5

```

Это вариант конвейера, который мы построили ранее: он выбирает строки 11\-15 файла `octane.pdb` . Помните, мы пока *не* запускаем его как команду: мы помещаем команды в файл.

Затем мы сохраняем файл ( `Ctrl-O` в nano) и выходим из текстового редактора ( `Ctrl-X` в nano). Убедитесь, что каталог `molecules` теперь содержит файл с именем `middle.sh` .

После сохранения файла мы можем попросить оболочку выполнить содержащиеся в ней команды. Наша оболочка называется `bash` , поэтому мы запускаем следующую команду:

```
$ bash middle.sh

```

```
ATOM      9  H           1      -4.502   0.681   0.785  1.00  0.00
ATOM     10  H           1      -5.254  -0.243  -0.537  1.00  0.00
ATOM     11  H           1      -4.357   1.252  -0.895  1.00  0.00
ATOM     12  H           1      -3.009  -0.741  -1.467  1.00  0.00
ATOM     13  H           1      -3.172  -1.337   0.206  1.00  0.00

```

Конечно же, вывод нашего скрипта \- это именно то, что мы получили бы, если бы запустили этот конвейер напрямую.

> ## Текст против чего угодно
>
> Мы обычно называем такие программы, как Microsoft Word или LibreOffice Writer, «текстовыми редакторами», но мы должны быть немного осторожнее, когда дело доходит до программирования. По умолчанию Microsoft Word использует `.docx` файлы для хранения не только текста, но и форматирования информации о шрифтах, заголовках и т. Д. Эта дополнительная информация не сохраняется в виде символов и ничего не значит для таких инструментов, как `head` : они ожидают, что входные файлы не будут содержать ничего, кроме букв, цифр и знаков препинания на стандартной компьютерной клавиатуре. Поэтому при редактировании программ вы должны либо использовать текстовый редактор, либо сохранять файлы в виде простого текста.

Что если мы хотим выбрать строки из произвольного файла? Мы могли бы редактировать `middle.sh` каждый раз, чтобы изменить имя файла, но это, вероятно, заняло бы больше времени, чем повторный ввод команды в оболочке и выполнение ее с новым именем файла. Вместо этого давайте отредактируем `middle.sh` и сделаем его более универсальным:

```
$ nano middle.sh

```

Теперь, внутри «nano», замените текст `octane.pdb` специальной переменной `$1` :

```
head -n 15 "$1" | tail -n 5

```

Внутри сценария оболочки `$1` означает «первое имя файла (или другой аргумент) в командной строке». Теперь мы можем запустить наш скрипт следующим образом:

```
$ bash middle.sh octane.pdb

```

```
ATOM      9  H           1      -4.502   0.681   0.785  1.00  0.00
ATOM     10  H           1      -5.254  -0.243  -0.537  1.00  0.00
ATOM     11  H           1      -4.357   1.252  -0.895  1.00  0.00
ATOM     12  H           1      -3.009  -0.741  -1.467  1.00  0.00
ATOM     13  H           1      -3.172  -1.337   0.206  1.00  0.00

```

или в другом файле, как это:

```
$ bash middle.sh pentane.pdb

```

```
ATOM      9  H           1       1.324   0.350  -1.332  1.00  0.00
ATOM     10  H           1       1.271   1.378   0.122  1.00  0.00
ATOM     11  H           1      -0.074  -0.384   1.288  1.00  0.00
ATOM     12  H           1      -0.048  -1.362  -0.205  1.00  0.00
ATOM     13  H           1      -1.183   0.500  -1.412  1.00  0.00

```

> ## Двойные кавычки вокруг аргументов
>
> По той же причине, по которой мы помещаем переменную цикла в двойные кавычки, в случае, если имя файла содержит пробелы, мы заключаем в `$1` двойные кавычки.

Нам все еще нужно редактировать `middle.sh` каждый раз, когда мы хотим отрегулировать диапазон линий. Давайте исправим это, используя специальные переменные `$2` и `$3` количество строк для передачи `head` и `tail` соответственно:

```
$ nano middle.sh

```

```
head -n "$2" "$1" | tail -n "$3"

```

Теперь мы можем запустить:

```
$ bash middle.sh pentane.pdb 15 5

```

```
ATOM      9  H           1       1.324   0.350  -1.332  1.00  0.00
ATOM     10  H           1       1.271   1.378   0.122  1.00  0.00
ATOM     11  H           1      -0.074  -0.384   1.288  1.00  0.00
ATOM     12  H           1      -0.048  -1.362  -0.205  1.00  0.00
ATOM     13  H           1      -1.183   0.500  -1.412  1.00  0.00

```

Изменяя аргументы нашей команды, мы можем изменить поведение нашего скрипта:

```
$ bash middle.sh pentane.pdb 20 5

```

```
ATOM     14  H           1      -1.259   1.420   0.112  1.00  0.00
ATOM     15  H           1      -2.608  -0.407   1.130  1.00  0.00
ATOM     16  H           1      -2.540  -1.303  -0.404  1.00  0.00
ATOM     17  H           1      -3.393   0.254  -0.321  1.00  0.00
TER      18              1

```

Это работает, но может потребоваться следующий человек, который читает `middle.sh` момент, чтобы выяснить, что он делает. Мы можем улучшить наш скрипт, добавив несколько **комментариев** вверху:

```
$ nano middle.sh

```

```
# Select lines from the middle of a file.
# Usage: bash middle.sh filename end_line num_lines
head -n "$2" "$1" | tail -n "$3"

```

Комментарий начинается с `#` символа и продолжается до конца строки. Компьютер игнорирует комментарии, но они неоценимы для того, чтобы помочь людям (включая вашу будущую личность) понять и использовать сценарии. Единственное предостережение в том, что каждый раз, когда вы изменяете сценарий, вы должны проверять, что комментарий все еще точен: объяснение, которое отправляет читателя в неправильном направлении, хуже, чем ничего вообще.

Что если мы хотим обработать много файлов в одном конвейере? Например, если мы хотим отсортировать наши `.pdb` файлы по длине, мы набрали бы:

```
$ wc -l *.pdb | sort -n

```

потому что `wc -l` перечисляет количество строк в файлах (напомним, что `wc` означает «подсчет слов», добавление `-l` опции означает «подсчет строк») и `sort -n` сортирует вещи численно. Мы можем поместить это в файл, но тогда он будет только сортировать список `.pdb` файлов в текущем каталоге. Если мы хотим получить отсортированный список других типов файлов, нам нужен способ включить все эти имена в скрипт. Мы не можем использовать `$1` , `$2` и так далее, потому что мы не знаем, сколько там файлов. Вместо этого мы используем специальную переменную `$@` , которая означает «Все аргументы командной строки для сценария оболочки». Мы также должны поместить `$@` в двойные кавычки для обработки аргументов, содержащих пробелы ( `"$@"` эквивалентно `"$1"` `"$2"` …) Вот пример:

```
$ nano sorted.sh

```

```
# Sort files by their length.
# Usage: bash sorted.sh one_or_more_filenames
wc -l "$@" | sort -n

```

```
$ bash sorted.sh *.pdb ../creatures/*.dat

```

```
9 methane.pdb
12 ethane.pdb
15 propane.pdb
20 cubane.pdb
21 pentane.pdb
30 octane.pdb
163 ../creatures/basilisk.dat
163 ../creatures/minotaur.dat
163 ../creatures/unicorn.dat
596 total

```

> ## Список уникальных видов
>
> У Лии есть несколько сотен файлов данных, каждый из которых отформатирован так:
>
> ```
> 2013-11-05,deer,5
> 2013-11-05,rabbit,22
> 2013-11-05,raccoon,7
> 2013-11-06,rabbit,19
> 2013-11-06,deer,2
> 2013-11-06,fox,1
> 2013-11-07,rabbit,18
> 2013-11-07,bear,1
>
> ```
>
> Пример файла такого типа приведен в `data-shell/data/animal-counts/animals.txt` .
>
> Мы можем использовать команду `cut -d , -f 2 animals.txt | sort | uniq` для производства уникальных видов в `animals.txt` . Чтобы избежать необходимости каждый раз вводить эту серию команд, ученый может вместо этого написать сценарий оболочки.
>
> Напишите сценарий оболочки с именем, `species.sh` который принимает любое количество имен файлов в качестве аргументов командной строки и использует вариант вышеуказанной команды, чтобы напечатать список уникальных видов, появляющихся в каждом из этих файлов отдельно.
>
> > ## Решение
> >
> > ```
> > # Script to find unique species in csv files where species is the second data field
> > # This script accepts any number of file names as command line arguments
> >
> > # Loop over all files
> > for file in $@
> > do
> > 	echo "Unique species in $file:"
> > 	# Extract species names
> > 	cut -d , -f 2 $file | sort | uniq
> > done
> >
> > ```

Предположим, мы только что выполнили серию команд, которые сделали что\-то полезное \- например, создали график, который мы хотели бы использовать в статье. Мы хотели бы иметь возможность пересоздать график позже, если нам нужно, поэтому мы хотим сохранить команды в файл. Вместо того, чтобы вводить их снова (и, возможно, неправильно), мы можем сделать это:

```
$ history | tail -n 5 > redo-figure-3.sh

```

Файл `redo-figure-3.sh` теперь содержит:

```
297 bash goostats NENE01729B.txt stats-NENE01729B.txt
298 bash goodiff stats-NENE01729B.txt /data/validated/01729.txt > 01729-differences.txt
299 cut -d ',' -f 2-3 01729-differences.txt > 01729-time-series.txt
300 ygraph --format scatter --color bw --borders none 01729-time-series.txt figure-3.png
301 history | tail -n 5 > redo-figure-3.sh

```

После небольшой работы в редакторе по удалению серийных номеров команд и удалению последней строки, в которой мы вызвали `history` команду, у нас есть абсолютно точная запись о том, как мы создали эту фигуру.

> ## Зачем записывать команды в историю, прежде чем запускать их?
>
> Если вы запустите команду:
>
> ```
> $ history | tail -n 5 > recent.sh
>
> ```
>
> последняя команда в файле \- это `history` сама команда, т. е. оболочка добавлена `history` в журнал команд перед ее фактическим запуском. Фактически, оболочка *всегда* добавляет команды в журнал перед их выполнением. Почему вы думаете, что это делает?
>
> > ## Решение
> >
> > If a command causes something to crash or hang, it might be useful to know what that command was, in order to investigate the problem. Were the command only be recorded after running it, we would not have a record of the last command run in the event of a crash.

На практике большинство людей разрабатывают сценарии оболочки, выполняя команды в командной строке несколько раз, чтобы убедиться, что они поступают правильно, а затем сохраняют их в файле для повторного использования. Этот стиль работы позволяет людям перерабатывать то, что они обнаруживают в своих данных и рабочем процессе, одним вызовом `history` и небольшим редактированием, чтобы очистить вывод и сохранить его в виде сценария оболочки.

## Трубопровод Нелле: создание сценария

Руководитель Нелле настаивал на том, что вся ее аналитика должна быть воспроизводимой. Самый простой способ захватить все шаги \- это скрипт.

Сначала мы вернемся к каталогу данных Nelle:

```
$ cd ../north-pacific-gyre/2012-07-03/

```

Она запускает редактор и пишет следующее:

```
# Calculate stats for data files.
for datafile in "$@"
do
    echo $datafile
    bash goostats $datafile stats-$datafile
done

```

Она сохраняет это в файле с именем, `do-stats.sh` так что теперь она может повторить первый этап своего анализа, набрав:

```
$ bash do-stats.sh NENE*[AB].txt

```

Она также может сделать это:

```
$ bash do-stats.sh NENE*[AB].txt | wc -l

```

так что вывод \- это только количество обработанных файлов, а не имена файлов, которые были обработаны.

Стоит отметить, что сценарий Nelle позволяет исполнителю решать, какие файлы обрабатывать. Она могла бы написать это так:

```
# Calculate stats for Site A and Site B data files.
for datafile in NENE*[AB].txt
do
    echo $datafile
    bash goostats $datafile stats-$datafile
done

```

Преимущество состоит в том, что это всегда выбирает правильные файлы: она не должна помнить, чтобы исключить файлы 'Z'. Недостатком является то, что он *всегда* выбирает только эти файлы \- она ​​не может запустить его на всех файлах (включая файлы 'Z') или на файлах 'G' или 'H', создаваемых ее коллегами в Антарктике, без редактирования скрипт. Если она хочет быть более предприимчивой, она может изменить свой сценарий для проверки аргументов командной строки и использовать, `NENE*[AB].txt` если ничего не было предоставлено. Конечно, это вводит еще один компромисс между гибкостью и сложностью.

> ## Переменные в скриптах оболочки
>
> `molecules` Представьте, что в каталоге есть сценарий оболочки, `script.sh` содержащий следующие команды:
>
> ```
> head -n $2 $1
> tail -n $3 $1
>
> ```
>
> Пока вы находитесь в `molecules` каталоге, вы вводите следующую команду:
>
> ```
> bash script.sh '*.pdb' 1 1
>
> ```
>
> Какой из следующих результатов вы ожидаете увидеть?
>
> 1.  Все линии между первой и последней строки каждого файла концовки в `.pdb` в `molecules` каталоге
> 2.  Первый и последняя строка каждого файла заканчивается в `.pdb` в `molecules` каталоге
> 3.  Первая и последняя строка каждого файла в `molecules` каталоге
> 4.  Ошибка из\-за кавычек `*.pdb`
>
> > ## Решение
> >
> > The correct answer is 2.
> >
> > The special variables $1, $2 and $3 represent the command line arguments given to the script, such that the commands run are:
> >
> > ```
> > $ head -n 1 cubane.pdb ethane.pdb octane.pdb pentane.pdb propane.pdb
> > $ tail -n 1 cubane.pdb ethane.pdb octane.pdb pentane.pdb propane.pdb
> >
> > ```
> >
> > The shell does not expand `'*.pdb'` because it is enclosed by quote marks. As such, the first argument to the script is `'*.pdb'` which gets expanded within the script by `head` and `tail`.

> ## Найти самый длинный файл с заданным расширением
>
> Напишите сценарий оболочки с именем, `longest.sh` который принимает имя каталога и расширение имени файла в качестве аргументов и выводит имя файла с наибольшим количеством строк в этом каталоге с этим расширением. Например:
>
> ```
> $ bash longest.sh /tmp/data pdb
>
> ```
>
> напечатает имя `.pdb` файла, в `/tmp/data` котором больше всего строк.
>
> > ## Решение
> >
> > ```
> > # Shell script which takes two arguments:
> > #    1. a directory name
> > #    2. a file extension
> > # and prints the name of the file in that directory
> > # with the most lines which matches the file extension.
> >
> > wc -l $1/*.$2 | sort -n | tail -n 2 | head -n 1
> >
> > ```

> ## Скрипт Понимание
>
> По этому вопросу рассмотрите `data-shell/molecules` каталог еще раз. Он содержит ряд `.pdb` файлов в дополнение к любым другим файлам, которые вы, возможно, создали. Объясните , что каждый из трех следующих сценариев будет делать при запуске , как `bash script1.sh *.pdb` , `bash script2.sh *.pdb` и `bash script3.sh *.pdb` соответственно.
>
> ```
> # Script 1
> echo *.*
>
> ```
>
> ```
> # Script 2
> for filename in $1 $2 $3
> do
>     cat $filename
> done
>
> ```
>
> ```
> # Script 3
> echo $@.pdb
>
> ```
>
> > ## Решения
> >
> > In each case, the shell expands the wildcard in `*.pdb` before passing the resulting list of file names as arguments to the script.
> >
> > Script 1 would print out a list of all files containing a dot in their name. The arguments passed to the script are not actually used anywhere in the script.
> >
> > Script 2 would print the contents of the first 3 files with a `.pdb` file extension. `$1`, `$2`, and `$3` refer to the first, second, and third argument respectively.
> >
> > Script 3 would print all the arguments to the script (i.e. all the `.pdb` files), followed by `.pdb`. `$@` refers to *all* the arguments given to a shell script.
> >
> > ```
> > cubane.pdb ethane.pdb methane.pdb octane.pdb pentane.pdb propane.pdb.pdb
> >
> > ```

> ## Сценарии отладки
>
> Предположим, вы сохранили следующий скрипт в файле, который называется `do-errors.sh` в `north-pacific-gyre/2012-07-03` каталоге Nelle :
>
> ```
> # Calculate stats for data files.
> for datafile in "$@"
> do
>     echo $datfile
>     bash goostats $datafile stats-$datafile
> done
>
> ```
>
> Когда вы запустите это:
>
> ```
> $ bash do-errors.sh NENE*[AB].txt
>
> ```
>
> выход пуст. Чтобы выяснить почему, перезапустите скрипт, используя `-x` опцию:
>
> ```
> bash -x do-errors.sh NENE*[AB].txt
>
> ```
>
> Какой вывод показывает вам? Какая строка отвечает за ошибку?
>
> > ## Решение
> >
> > The `-x` option causes `bash` to run in debug mode. This prints out each command as it is run, which will help you to locate errors. In this example, we can see that `echo` isn’t printing anything. We have made a typo in the loop variable name, and the variable `datfile` doesn’t exist, hence returning an empty string.

> ## Ключевые моменты
>
> *   Сохраните команды в файлах (обычно называемых сценариями оболочки) для повторного использования.
>
> *   `bash filename` запускает команды, сохраненные в файле.
>
> *   `$@` относится ко всем аргументам командной строки сценария оболочки.
>
> *   `$1` , `$2` И т.д., относятся к первой командной строки аргумента, второй аргумент командной строки и т.д.
>
> *   Поместите переменные в кавычки, если в значениях могут быть пробелы.
>
> *   Предоставление пользователям возможности решать, какие файлы обрабатывать, является более гибким и более совместимым со встроенными командами Unix.
>
