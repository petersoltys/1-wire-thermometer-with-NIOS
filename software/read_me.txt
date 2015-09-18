
Autor    : Peter Soltys
Projekt  : Bakalarska praca "Procesor NIOS vo vlozenych aplikaciach"
Veduci   : doc. Ing. Milos Drutarovsky, PhD
   
Datum    : 7.april 2015
Verzia   : 1.2


Hardver   : vyvojova doska altera UP3-1C6 obsahujuca :
                FPGA obvod Altera Cyclone EP1C6 
                --> https://www.altera.com/en_US/pdfs/literature/ds/ds_cyc.pdf
                SDRAM ISSI Inc. IS42S16400B-7T,8 MByte,1 MBit x 16 bit x 4 banky 
                --> http://www.issi.com/WW/pdf/42S16400B.pdf
                SRAM ISSI Inc. IS61LV6416L-10T, 128 KByte, 64KBit x 16 bit 
                --> http://www.issi.com/WW/pdf/61LV6416_L.pdf
                FLASH Excel Semiconductor Inc. ES29LV160DB-70RTC, 
                2 MByte,2 MBit x 8 bit/1 MBit x 16 bit CMOS 
                --> http://pdf1.alldatasheet.com/datasheet-pdf/view/
                    145359/EXCELSEMI/ES29LV160DB-80RTG.html
                LCD character display 2*16
                --> http://www.lumex.com/specs/LCM-S01602DTR%20M.pdf
                hodinový obvod RTC M41T00 
                --> http://www.st.com/web/en/resource/technical/
                    document/datasheet/CD00001542.pdf
                a ine periferie 
                --> http://users.ece.gatech.edu/~hamblen/UP3/
                    UP3_1C6_REV2_Schematic.pdf

            teplomery DS18B20 --> http://datasheets.maximintegrated.com/
                                  en/ds/DS18B20.pdf

Softverovy
hardver :   Softverovy procesor NIOS II rozsireny o preriferie
            zbernica 1-wire viac na stranke:
            --> http://www.maximintegrated.com/en/products/comms/one-wire.html
            zbernica i2c viac na stranke : 
            --> http://www.nxp.com/documents/user_manual/UM10204.pdf
            standardne SPI rozhranie ponukajuce softverom SOPC Builder


Subory    : main.c   --obsahuje program riadiaci citanie teplot a ich zapis na 
                       SD kartu v presne danych intervaloch s casovym zaznamom

            /preiferie/ --priecinok obashuje vsetky potrebne subory potrebne na 
                          pracu s pripojenymi periferiami

                     one_wire.h  --prototypy funkcii a makra pre zbernicu 1-wire
                     one_wire.c  --funkcie ovladajuce zbernicu 1-wire
                     i2c.h       --prototypy funkcii a makra pre zbernicu 1-wire
                     i2c.c       --funkcie ovladajuce zbernicu i2c
                     periferie.h --linkovanie kniznic na pracu s periferiamy

             /periferie/SD_SPI/--priecinok obsahuje vsetky potrebne funkcie 
                                 potrebne na pracu so subormy na SD karte

                     diskio.c  --funkcie ovladajuce zapis na SD kartu cez SPI
                     diskio.h  --prototypy funkcii a makra pre parcu s SPI
                     ff.c      --funkcie Ovladajuce pristup k suborom na 
                                 SD karte
                     ff.h      --prototypy a makra pre pracu so subormy na SD
                                 karte
                     ffconf.h  --obsahuje makra nastavujuce kniznicu ff.c
                     integer.h --definicie premennych
