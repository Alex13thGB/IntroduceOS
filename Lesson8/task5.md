Действия:
1. Просмотр логов /var/log/auth.log.
Выяснилось, что cron каждую минуту выполняет задание для пользователя deploy.
2. Поиск файла заданий cron 
find / -name cron*
3. Найден каталог /var/spool/cron/crontabs, содержащий файл заданий - deploy
4. При анализе файла найдены задания ежеминутного запуска скриптов:
~/.ttp/start
/tmp/.ssh/.rsync/start

Которые и проявляли "нежелательную" активность.