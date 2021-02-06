
rem para desactivar los mensajes de los programas
@echo off

rem /************Compilando a ensamblador******************/
rem glass compiler (http://www.grauw.nl/projects/glass/) es un compilador de ensamblador z80 que puedo convertir tu código ensamblador en los archivos binarios.rom y .bin
java -jar  tools\glass\glass-0.5.jar src\main.asm main.bin main.sym
move /Y main.bin ./bin
rem del /F src/main.lst

rem /************Preparando files******************/
for /R bin/ %%a in (*.bin) do (
        copy "%%a" obj)   
for /R src/ %%a in (*.bas) do (
        copy "%%a" obj)


rem /************Diskmanager******************/
rem Añadiendo archivos al .dsk, tenemos que crear antes el archivo disco.dsk con el programa disk manager
rem para ver los comandos abrir archivo DISKMGR.chm
rem AUTOEXEC.BAS es un archivo basic con el comando bload que hará que se autoejecute el main.bas
rem start /wait tools\Disk-Manager\DISKMGR.exe -A -F -C main.dsk src/autoexec.bas 
rem main.bas contiene mi código fuente
rem start /wait tools\Disk-Manager\DISKMGR.exe -A -F -C main.dsk src/main.bas

rem /***********Abriendo el emulador***********/
rem Abriendo con openmsx, presiona f9 al arrancar para que vaya rápido
start /wait tools\emulators\openmsx\openmsx.exe -machine Philips_NMS_8255 -diska obj/
rem Abriendo con FMSX https://fms.komkon.org/fMSX/fMSX.html
rem start /wait emulators/fMSX/fMSX.exe -diska main.dsk
