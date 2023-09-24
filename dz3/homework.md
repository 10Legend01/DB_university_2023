### Домашнее задание 3. Функциональные зависимости в БД «Университет»
Дано отношение с атрибутами _StudentId_, _StudentName_, _GroupId_, _GroupName_, _CourseId_, _CourseName_, _LecturerId_, _LecturerName_, _Mark_.

1. Найдите функциональные зависимости в данном отношении.
2. Найдите все ключи данного отношения.
3. Найдите замыкание множеств атрибутов:
   1. GroupId, CourseId;
   2. StudentId, CourseId;
   3. StudentId, LecturerId.
4. Найдите неприводимое множество функциональных зависимостей для данного отношения.
   
Примечания

1. Не требуется поддержка:
   - нескольких университетов;
   - дисциплин по выбору;
   - дисциплин с необычным распределением по группам (таких как физическая культура и иностранный язык);
   - переводов между группами;
   - нескольких оценок по одной дисциплине.
2. Многосеместровые дисциплины считаются по семестрам, например: _Математический анализ (семестр 1)_, _Математический анализ (семестр 2)_;
   
[Форма для сдачи ДЗ](https://docs.google.com/forms/d/e/1FAIpQLSd9eAW7ymnEyVFgscb7Da-hz_0neTT14702aV9BpZKgvVVvHg/viewform). 
Проверка проводится в полуавтоматическом режиме, поэтому строго соблюдайте указанные форматы.

В рамках проекта:
1. Определите набор атрибутов, необходимых для проекта, и определите отношения на них.
2. Найдите функциональные зависимости полученных отношений.
3. Найдите все ключи полученных отношений.
4. Найдите неприводимые множества функциональных зависимостей для полученных отношений.

___________________

Дано отношение с атрибутами StudentId, StudentName, GroupId, GroupName, CourseId, CourseName, LecturerId, LecturerName, Mark.

___________________


### 1. Функциональные зависимости
Функциональные зависимости должны быть заданы по одной на строке в формате «A, B -> D, E». 

Названия атрибутов должны быть как в условии ДЗ.
```text
StudentId -> StudentName, GroupName, GroupId
GroupId -> GroupName
GroupName -> GroupId
CourseId -> CourseName
LecturerId -> LecturerName
StudentId, CourseId -> Mark, LecturerId, LecturerName
GroupId, CourseId -> LecturerId, LecturerName
```


### 2. Ключи

### 2.1. Процесс определения ключей
Текст в свободной форме
```text
Нельзя получить StudentId и CourseId (нет ни в одной правой части любой из функциональных зависимостей), поэтому любой надключ обязан использовать эти атрибуты.
Проверим, что множество {StudentId, CourseId} является надключом - проверим замыкание.

{StudentId, CourseId}  // + 1
{StudentId, CourseId, StudentName, GroupName, GroupId}  // + 4
{StudentId, CourseId, StudentName, GroupName, GroupId, CourseName}  // + 6
{StudentId, CourseId, StudentName, GroupName, GroupId, CourseName, Mark, LecturerId, LecturerName} = {StudentId, CourseId}^+

Перечислены все атрибуты из условия, следовательно множество {StudentId, CourseId} является надключом. 
Значит это множество является ключом, потому что любой надключ обязан использовать StudentId и CourseId (см. первое предложение), по этой же причине больше нет других ключей.
```

### 2.2. Полученные ключи
По одному на строке в формате «A, B, C»
```text
StudentId, CourseId
```


### 3. Замыкания множества атрибутов

### 3.1. GroupId, CourseId
Последовательность построения замыкания после каждого его расширения, по одному множеству на строке в формате «A, B, C».

В первой строке должно быть исходное множество, а в последней — само замыкание.
```text
GroupId, CourseId
GroupId, CourseId, GroupName
GroupId, CourseId, GroupName, CourseName
GroupId, CourseId, GroupName, CourseName, LecturerId, LecturerName
```

### 3.2. StudentId, CourseId
В формате из пункта 3.1.
```text
StudentId, CourseId
StudentId, CourseId, StudentName, GroupName, GroupId
StudentId, CourseId, StudentName, GroupName, GroupId, CourseName
StudentId, CourseId, StudentName, GroupName, GroupId, CourseName, Mark, LecturerId, LecturerName
```

### 3.3. StudentId, LecturerId
В формате из пункта 3.1.
```text
StudentId, LecturerId
StudentId, LecturerId, StudentName, GroupName, GroupId
StudentId, LecturerId, StudentName, GroupName, GroupId, LecturerName
```


### 4. Неприводимое множество функциональных зависимостей

### 4.1d. Первый этап
Описание процесса (текст в свободной форме)
```text
"По правилу расщепления делаем все правые части единичными" ©
```

### 4.1r. Результаты первого этапа
В формате из пункта 1
```text
StudentId -> StudentName
StudentId -> GroupName
StudentId -> GroupId
GroupId -> GroupName
GroupName -> GroupId
CourseId -> CourseName
LecturerId -> LecturerName
StudentId, CourseId -> Mark
StudentId, CourseId -> LecturerId
StudentId, CourseId -> LecturerName
GroupId, CourseId -> LecturerId
GroupId, CourseId -> LecturerName
```

### 4.2d. Второй этап
Описание процесса (текст в свободной форме)
```text
"Для левой части каждого правила пытаемся удалить по одному атрибуту" ©

Результат второго этапа не изменился, ничего удалить в левой части нельзя:
Нельзя удалить любой из атрибутов в этих правилах: 
StudentId, CourseId -> Mark
StudentId, CourseId -> LecturerId
StudentId, CourseId -> LecturerName
GroupId, CourseId -> LecturerId
GroupId, CourseId -> LecturerName

При попытке удаления любого из атрибутов в левой части любого правила правая его часть не принадлежит замыканию множества из левых атрибутов этого правила (не включающих удаляемый атрибут) над исходным множеством функциональных зависимостей.
```

### 4.2r. Результаты второго этапа
В формате из пункта 1
```text
StudentId -> StudentName
StudentId -> GroupName
StudentId -> GroupId
GroupId -> GroupName
GroupName -> GroupId
CourseId -> CourseName
LecturerId -> LecturerName
StudentId, CourseId -> Mark
StudentId, CourseId -> LecturerId
StudentId, CourseId -> LecturerName
GroupId, CourseId -> LecturerId
GroupId, CourseId -> LecturerName
```

### 4.3d. Третий этап
Описание процесса (текст в свободной форме)
```text
"Пытаемся удалить по одному правилу" ©

Можно удалить правила:

1) StudentId -> GroupName
Из-за наличия правил "StudentId -> GroupId", "GroupId -> GroupName"

2) StudentId, CourseId -> LecturerName
Из-за наличия правил "StudentId -> GroupId", "GroupId, CourseId -> LecturerId", "LecturerId -> LecturerName"

3) GroupId, CourseId -> LecturerName
Из-за наличия правил "GroupId, CourseId -> LecturerId", "LecturerId -> LecturerName"

4) StudentId, CourseId -> LecturerId
Из-за наличия правил "StudentId -> GroupId", "GroupId, CourseId -> LecturerId"

При попытке удалить любое оставшееся правило его правая часть не будет принадлежать замыканию множества атрибутов левой части правила над текущим множеством функциональных зависимостей без этого правила.
```

### 4.3r. Результаты третьего этапа
В формате из пункта 1
```text
StudentId -> StudentName
StudentId -> GroupId
GroupId -> GroupName
GroupName -> GroupId
CourseId -> CourseName
LecturerId -> LecturerName
StudentId, CourseId -> Mark
GroupId, CourseId -> LecturerId
```