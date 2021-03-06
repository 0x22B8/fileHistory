#!/bin/bash
# Переходим в рабочую директорию
cd /path/to/file
IFS=""
FILE="$1"
HISTDIR=./history_$FILE
# Если существует директория с прошлыми версиями,
# то копируем туда наш файл и переходим в эту директорию
if [ -d $HISTDIR ]
  then
  cp $FILE $HISTDIR
  cd $HISTDIR
# Если в этой директории уже есть предыдущие версии файла,
# то сравниваем последнюю версюю с текущей
  LAST=$(ls -tr|tail -n2|head -n1)
  if [ -f $LAST ]
    then
    mv $FILE $(date +%d%m%y%H%M%S)_$FILE
    FILE=$(ls -tr|tail -n1)
    diff -q <(xxd $FILE) <(xxd $LAST)
# Если текущая версия отличается от последней, то она остаётся в директории
# Если в директории больше 24 версий, то при добавлении
# новой версии удаляется самая старая версия файла в этой директории
    if [ $? -ne 0 ]
      then
      if [ $(ls|wc -l) -gt 24  ]
        then
        rm $(ls -tr|head -n1)
      fi
    else
# Если отличий между текущей и последней версией нет,
# то текущая версия не записывается в директорию
      if [ $(ls|wc -w) -ne 1 ]
        then
        rm $FILE
      fi
    fi
  fi

else
# Если директории с предыдущими версиями не существует,
# то создаём её и создаём там текущую версию файла
  mkdir ./history_$FILE
  cp $FILE $HISTDIR
  cd $HISTDIR
  mv $FILE $(date +%d%m%y%H%M%S)_$FILE
fi
