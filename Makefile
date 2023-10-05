TARGET = main

# Указание компилятора
CC = gcc

# Вызов pkg-config, для поиска зависимостей
PKGCONFIG = $(shell which pkg-config)

# Флаги компиляции gtk4
CFLAGS = $(shell $(PKGCONFIG) --cflags gtk4)

# Бибилотечные зависимости gtk4
LIBS = $(shell $(PKGCONFIG) --libs gtk4)

# Все исходники из текущей папки
SRC = $(wildcard *.c)

# Объектные файлы из исходников
OBJ = $(patsubst %.c, %.o, $(SRC))

# Получаем объектные файлы
.c.o:	
	@$(CC) $(CFLAGS) -c -o $@ $< $(LIBS)

# Получаем исполняемый файл
$(TARGET) : $(OBJ)
	@$(CC) $(OBJ) $(CFLAGS) -o $(TARGET) $(LIBS)

# Удаляем остаточные объектные файлы
remove:	
	@for obj in $(OBJ); do\
		if (`test -f $$obj`);\
			then rm $$obj;\
		fi;\
	done;
