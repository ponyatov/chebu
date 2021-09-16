## @file
## @brief meta: электронный журнал "Чебуратор"

from metaL import *

p = Project(
    title='''электронный журнал "Чебуратор"''',
    about='''
## журнал хакспейса "Контур"

* обзоры студенческих работ
* учебные материалы
* публикации материалов по научной работе школьников

## партнёры

* Самарский университет
  https://vk.com/samara_university
  https://ssau.ru/

  * Клуб любителей электроники "Контур"
    https://vk.com/ssau_kontur

  * Студенческий робототехнический клуб "ROBOTIC"
    https://ssau.ru/recreation/science/robot_tic
    https://vk.com/robotic_samara

* Самарский государственный технический университет
  https://samgtu.ru/
  https://vk.com/samgtu_officiall

  * Клуб любителей электроники "Контур-Политех"
    https://vk.com/samgtu_kontur

* Самарский региональный центр для одаренных детей "Вега"
  https://codsamara.ru/
  https://vk.com/vegasamara_163
  

<hr>
при подготовке данных материалов ни один Microsoft не пострадал
''') \
    | TeX()

p.sync()
