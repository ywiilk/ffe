#define _CRT_SECURE_NO_WARNINGS

#include <stdio.h>
#include <stdlib.h>
#include <time.h>


#define MAX_LENGTH 10
#define MAX_POWER 10
#define HIGHT_TRUNC 3
#define RESOURCE_COST 2
#define MAX_RESOURCES 100

// Свойства ветки
struct Line {
 int length; // длина ветви - 0 ..MAX_LENGTH
 int power; // жизненная сила ветви - 0..MAX_POWER
};

// количество веток
#define NUM_LINES 10

// Ветки
struct Line lines[NUM_LINES] = {
 {5, 8}, // length = 5, power = 8
 {5, 8},
 {5, 8},
 {5, 8},
 {5, 8},
 {5, 8},
 {5, 8},
 {5, 8},
 {5, 8},
 {5, 8}
};


// напечатать один элемент ветки
void printElement(int power) {
 const char element[MAX_POWER + 1] = {'.','\'','\"','^','o','*','O','X','M','W','#'};

 if (power >= 0 && power <= MAX_POWER) {
  printf("%c", element[power]);
 }
}

// напечатать игровое поле
void printGameField() {

 // напечатать ветки
 int i = 0;
 while (i < NUM_LINES) {

  // напечатать пустоту слева от ветки
  int empty_pos = MAX_LENGTH - lines[i].length;
  int pos = 0;
  while (pos < empty_pos) {
   printf(" ");
   pos++;
  }

  // напечатать левую ветку
  while (pos < MAX_LENGTH) {
   printElement(lines[i].power);
   pos++;
  }

  // напечатать ствол с номером ветки
  printf("[%d]", i);

  // напечатать правую ветку
  while (pos < MAX_LENGTH + lines[i].length) {
   printElement(lines[i].power);
   pos++;
  }

  // завершить печать ветки
  printf("\n");

  i++;
 }

 // напечатать ствол дерева
 while (i < NUM_LINES + HIGHT_TRUNC) {
  int pos = 0;
  while (pos < MAX_LENGTH) {
   printf(" ");
   pos++;
  }
  printf("###\n");
  i++;
 }

}

// сделать ход компьютера
void doAutoStep() {

 // в 1/3 случаев будет выполняться код под условием
 if (rand() % 3 == 0) {
  // случайно выбираем жертву
  int nline = rand() % 10;

  // выбранной жертве уменьшаем уровень жизненной силы
  lines[nline].power -= 2;
  if (lines[nline].power < 0) {
   lines[nline].power = 0;
  }
  printf("command = <D> line = <%d>\n", nline);
 }

 // укорачиваем те ветви, у которых низкая жизненная сила
 int i = 0;
 while (i < NUM_LINES) {

  // если у ветки меньше половины силы 
  if (lines[i].power < MAX_POWER / 2) {
   lines[i].length--;
  }
  // если у ветки меньше четверти силы
  else if (lines[i].power < MAX_POWER / 4) {
   lines[i].length -= 2;
  }

  if (lines[i].length < 0) {
   lines[i].length = 0;
  }

  i++;
 }

}
int resources = MAX_RESOURCES;
void cutBranch(int nline) {
    if (lines[nline].length > 0) {
        lines[nline].length = 0;
        lines[nline].power = 8; // восстановление силы
        resources -= RESOURCE_COST;
        printf("Ветвь %d обрезана! Ресурсы: %d\n", nline, resources);
    }
}
void strongHeal(int nline) {
    if (resources >= RESOURCE_COST * 2) {
        if (lines[nline].power < MAX_POWER)
            lines[nline].power = MAX_POWER;
        resources -= RESOURCE_COST * 2;
        printf("Сильное лечение ветви %d! Ресурсы: %d\n", nline, resources);
    }
}
