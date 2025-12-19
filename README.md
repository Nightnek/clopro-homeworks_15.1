# Домашнее задание к занятию «Организация сети» Стасенко Григорий Михайлович

### Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.

 - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
 - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.

<img width="1217" height="258" alt="image" src="https://github.com/user-attachments/assets/c27018ee-13d2-4a36-9749-5ab73625ed83" />


 - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.

*Подключился по публичному IP, интернет есть*

<img width="687" height="267" alt="image" src="https://github.com/user-attachments/assets/c4ea5d0c-7e4e-4a7f-b68b-0a6147137be3" />


3. Приватная подсеть.
 - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
 - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.

*Статический маршрут:*

<img width="1212" height="111" alt="image" src="https://github.com/user-attachments/assets/d5fa5516-9bcf-457b-bc2e-331b7eade4cd" />


 - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

*Подключаемся  через условный джамп-хост:*

<img width="732" height="331" alt="image" src="https://github.com/user-attachments/assets/93c86014-8107-4769-87c9-7da5682d99ad" />

*Проверяем интернет:*

<img width="667" height="209" alt="image" src="https://github.com/user-attachments/assets/b16dc85f-2569-4f94-9d3f-0e5bd2ed0792" />


