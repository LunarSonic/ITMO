mkdir lab0
cd lab0
touch dugtrio4
echo "Способности Growl Astonish Mud-Slap Magnitude Bulldoze
Sucker Punch Sand Tomb Mud Bomb Earth Power Dig Slash Earthquake
Fissure" > dugtrio4
mkdir hitmontop6
cd hitmontop6
mkdir wigglytuff
touch zigzagoon
echo "Тип покемона NORMAL NONE" > zigzagoon
touch carvanha
echo "Тип диеты
Carnivore" > carvanha
mkdir tyrogue
cd ..
mkdir nuzleaf4
cd nuzleaf4
touch klink
echo "Способности Vicegrip Charge Thundershock Gear Grind
Bind Charge Beam Autotomize Mirror Shot Screech Discharge Metal Sound
Shift Gear Lock-On Zap Cannon Hyper Beam" > klink
touch cherrim
echo "Ходы Bullet Seed
Giga Drain Helping Hand Natural Gift Rollout Seed Bomb Sleep Talk
Snore Synthesis Worry Seed" > cherrim
touch skuntank
echo "weight=83.8 height=39.0 atk=9
def=7" > skuntank
mkdir octillery
touch nidorino
echo "Ходы Body Slam Counter Defense Curl Double-Edge Drill
Run Helping Hand Iron Tail Mud-Slap Shock Wave Sleep Talk Snore Sucker
Punch Super Fang Water Pulse" > nidorino
touch wormadam
echo "Развитые способности
Overcoat" > wormadam
cd ..
touch seadra9
echo "Ходы Bounce Dive Double-Edge Dragon Pulse Icy Wind
Outrage Signal Beam Sleep Talk Snore Swift Twister Water
Pulse" > seadra9
mkdir sunflora0
cd sunflora0
mkdir marill
mkdir ferrothorn
touch excadrill
echo "Возможности Overland=6 Surface=4 Burrow=10 Jump=3
Power=3 Intelligence=4 Groundshaper=0" > excadrill
cd ..
touch tyrogue0
echo "weight=46.3
height=28.0 atk=4 def=4" > tyrogue0

chmod 644 dugtrio4
chmod 573 hitmontop6
chmod 736 hitmontop6/wigglytuff
chmod 622 hitmontop6/zigzagoon
chmod 664 hitmontop6/carvanha
chmod 512 hitmontop6/tyrogue
chmod 736 nuzleaf4
chmod 404 nuzleaf4/klink
chmod 440 nuzleaf4/cherrim
chmod 624 nuzleaf4/skuntank
chmod 513 nuzleaf4/octillery
chmod 620 nuzleaf4/nidorino
chmod 622 nuzleaf4/wormadam
chmod u=r,g=r,o=r seadra9
chmod u=rwx,g=wx,o=wx sunflora0
chmod u=rx,g=rwx,o=rx sunflora0/marill
chmod u=rwx,g=rx,o=w sunflora0/ferrothorn
chmod u=,g=r,o=rw sunflora0/excadrill
chmod u=rw,g=,o= tyrogue0

#cоздать жесткую ссылку для файла seadra9 с именем lab0/nuzleaf4/cherrimseadra
ln seadra9 nuzleaf4/cherrimseadra
chmod u+r sunflora0/excadrill
#объеденить содержимое файлов lab0/sunflora0/excadrill, lab0/nuzleaf4/wormadam, в новый файл lab0/seadra9_55
cat sunflora0/excadrill nuzleaf4/wormadam > seadra9_55
chmod u+w nuzleaf4/cherrimseadra
#скопировать содержимое файла seadra9 в новый файл lab0/nuzleaf4/cherrimseadra
cat seadra9 > nuzleaf4/cherrimseadra
#cоздать символическую ссылку для файла seadra9 с именем lab0/nuzleaf4/klinkseadra
ln -s seadra9 nuzleaf4/klinkseadra
#создать символическую ссылку c именем Copy_29 на директорию hitmontop6 в каталоге lab0
ln -s hitmontop6 Copy_29
#скопировать файл seadra9 в директорию lab0/sunflora0/marill
chmod u+w sunflora0/marill
cp seadra9 sunflora0/marill
chmod -R u+w hitmontop6/wigglytuff
#скопировать рекурсивно директорию sunflora0 в директорию lab0/hitmontop6/wigglytuff
cp -r sunflora0 hitmontop6/wigglytuff
chmod u-r sunflora0/excadrill
chmod u-w nuzleaf4/cherrimseadra
chmod -R u-w hitmontop6/wigglytuff
chmod u-w sunflora0/marill

#Подсчитать количество строк содержимого файла seadra9, результат записать 
#в файл в директории /tmp, добавить вывод ошибок доступа в стандартный поток вывода
echo "Вывод 1:"
wc -l seadra9 > /tmp/total 2>&1
#Вывести рекурсивно список имен и атрибутов файлов в директории lab0, заканчивающихся 
#на символ 'n', список отсортировать по возрастанию даты изменения записи о файле, 
#ошибки доступа перенаправить в файл в директории /tmp
echo "Вывод 2:"
ls -R -ltr | grep "n$" 2>/tmp/errors
#Рекурсивно вывести содержимое файлов из директории lab0, имя которых начинается на 'n', 
#строки отсортировать по имени z->a, подавить вывод ошибок доступа
echo "Вывод 3:"
cat n* */n* */*/n* | sort -r 2>/dev/null
#Вывести два последних элемента рекурсивного списка имен и атрибутов файлов в директории lab0, 
#начинающихся на символ 's', список отсортировать по возрастанию количества жестких ссылок, 
#добавить вывод ошибок доступа в стандартный поток вывода
echo "Вывод 4:"
ls -lR 2>&1 s* */s* */*/s*| grep "^-" | sort -n -k2 | tail -n 2
#Вывести рекурсивно список имен и атрибутов файлов в директории lab0, содержащих строку "tyro", 
#список отсортировать по возрастанию размера, ошибки доступа не подавлять и не перенаправлять
echo "Вывод 5:"
ls -R -lSr | grep "tyro" 
#Вывести список имен файлов в директории sunflora0, список отсортировать по имени z->a, 
#ошибки доступа не подавлять и не перенаправлять
echo "Вывод 6:"
ls -1 sunflora0 | sort -r

rm dugtrio4
chmod u+w nuzleaf4/cherrim
rm nuzleaf4/cherrim
chmod u+w nuzleaf4/klinkseadra
rm nuzleaf4/klinksead*
chmod u+w nuzleaf4/cherrimseadra
rm nuzleaf4/cherrimsead*
chmod -R u+w sunflora0
rm -rf sunflora0
