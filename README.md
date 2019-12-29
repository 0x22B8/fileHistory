**Алгоритм решения задачи:**
1. Помещаем скрипт ```history.sh``` в папку с файлом и делаем его исполняемым (```chmod +x history.sh```)
2. Открываем скрипт (```nano history.sh```), затем изменяем вторую строку ```cd /path/to/file```,
указывая вместо ```/path/to/file```  директорию файла
3. Открываем файл конфигурации cron: ```crontab -e```
4. Добавляем в конец файла:

```* * * * * /path/to/file/history.sh ИМЯ_ФАЙЛА > /dev/null 2>&1``` 

где ```/path/to/file``` - дирректория файла, а ```ИМЯ_ФАЙЛА``` - имя файла.