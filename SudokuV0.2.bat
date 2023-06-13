@echo off
@chcp 65001
title SudokuV0.2 Ponowna Proba
color 70
setlocal enableDelayedExpansion
mode 125, 40


:start
cd %~dp0
cls
echo ==========
echo Witam !!!
echo ==========
echo Wybierz:
echo 1. Start gry
echo 2. Opcje
echo 3. Wyjdz
echo.
set /p "opcje11=>>"
if "%opcje11%"=="1" goto danegry
if "%opcje11%"=="2" goto optio
if "%opcje11%"=="3" exit
goto start

:optio
cls 
echo A.Wybierz kolor tła     
echo B.Wybierz kolor liter
echo C.Powrót do menu
choice /c:abc /n
if ERRORLEVEL 3 goto start
if ERRORLEVEL 2 goto olitery
if ERRORLEVEL 1 goto okolor


:okolor
cls
color %mm%%y%
echo A.Wybierz kolor tła:
echo 1. Zielony
echo 2. Jasno niebieski
echo 3. Czerwony
echo 4. Czarny
echo 5. Żółty
echo 6. Biały
echo 7. Powrót
echo B.Wybierz kolor liter:
echo C.Powrót do menu
choice /c:1234567bc /n

if ERRORLEVEL 9 goto start

if ERRORLEVEL 8 goto olitery

if ERRORLEVEL 7 goto option

if ERRORLEVEL 6 set mm=7&goto okolor

if ERRORLEVEL 5 set mm=6&goto okolor

if ERRORLEVEL 4 set mm=0&goto okolor

if ERRORLEVEL 3 set mm=4&goto okolor

if ERRORLEVEL 2 set mm=B&goto okolor

if ERRORLEVEL 1 set mm=A&goto okolor
goto okolor


:olitery
cls
color %mm%%y%
echo A.Wybierz kolor tła:
echo B.Wybierz kolor liter:
echo 1. Czarny 
echo 2. Czerwony
echo 3. Niebieski
echo 4. Biały
echo 5. Zielony
echo 6. Żółty
echo 7. Powrót
echo C.Powrót do menu
choice /c:a1234567c /n

if ERRORLEVEL 9 goto start

if ERRORLEVEL 8 goto option

if ERRORLEVEL 7 set y=6&goto olitery

if ERRORLEVEL 6 set y=A&goto olitery

if ERRORLEVEL 5 set y=7&goto olitery

if ERRORLEVEL 4 set y=1&goto olitery

if ERRORLEVEL 3 set y=4&goto olitery

if ERRORLEVEL 2 set y=0&goto olitery

if ERRORLEVEL 1 goto okolor
goto olitery


:danegry
set wyborpoziomu=0
set poziomhard=9345
cls
echo Wybierz poziom trudnosc od 1 do 10:
set /p "wyborpoziomu=>>"
set /a poziomhard=!poziomhard! + !wyborpoziomu!
set /a poziomhard=!poziomhard! - 9345
if errorlevel 1 goto danegry
if !poziomhard! GTR 0 if !poziomhard! LSS 11 goto ladowanie
cls
echo Nie istnieje taki poziom trudnosc
pause>nul
goto danegry

:ladowanie
set key=0
set /a key=%time:~6,2%+%random:~2%
set /a key=%key%*%time:~6,1%
if "%key%"=="0" goto ladowanie
(echo ladowanie
echo %key%
echo %poziomhard%)>ladowanie.txt
if not exist ladowanie.txt goto ladowanie
start SudokuCMD.exe
:WaitingToKeyFile
if not exist %key%.txt (
	cls
	echo Ladowanie
	goto WaitingToKeyFile
)
set boolgit=0
set boolodp=0
set loading=1
for /f "tokens=*" %%a in (%key%.txt) do (
	if "%%a"=="koniecsudoku" (
		set /a boolgit=0
	)
	if "%%a"=="koniecodpowiedz" (
		set /a boolodp=0
		set /a loading=0
	)
	if "!boolgit!"=="1" (
		set %%a
	) 
	if "!boolodp!"=="1" (
		set %%a
	)
	if "%%a"=="sudoku" (
		set /a boolgit=1
	)
	if "%%a"=="odpowiedz" (
		set /a boolodp=1
	)
)
if !loading!==1 goto WaitingToKeyFile
::Marking fields that can be changed / Oznaczanie pól, które można zmienić
for /l %%a in (1,1,81) do (
	if !x%%a!==0 (
		set "change%%a=1"
	) else (
		set "change%%a=0"
	)
)
del %key%.txt
del ladowanie.txt
goto ladowaniezmiennych

:ladowaniezmiennych
for /l %%a in (1,1,81) do (
	set "l%%a= "
	set "r%%a= "
)

set "l1=<"
set "r1=>"
set pozycjagracza=1


echo 	=================H=================H=================
echo 	-----+-----+-----H-----+-----+-----H-----+-----+-----
:gra
cls
echo.
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l1!!x1!!r1! ¦ !l2!!x2!!r2! ¦ !l3!!x3!!r3! H !l4!!x4!!r4! ¦ !l5!!x5!!r5! ¦ !l6!!x6!!r6! H !l7!!x7!!r7! ¦ !l8!!x8!!r8! ¦ !l9!!x9!!r9!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	-----+-----+-----H-----+-----+-----H-----+-----+-----
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l10!!x10!!r10! ¦ !l11!!x11!!r11! ¦ !l12!!x12!!r12! H !l13!!x13!!r13! ¦ !l14!!x14!!r14! ¦ !l15!!x15!!r15! H !l16!!x16!!r16! ¦ !l17!!x17!!r17! ¦ !l18!!x18!!r18!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	-----+-----+-----H-----+-----+-----H-----+-----+-----
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l19!!x19!!r19! ¦ !l20!!x20!!r20! ¦ !l21!!x21!!r21! H !l22!!x22!!r22! ¦ !l23!!x23!!r23! ¦ !l24!!x24!!r24! H !l25!!x25!!r25! ¦ !l26!!x26!!r26! ¦ !l27!!x27!!r27!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	=================H=================H=================
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l28!!x28!!r28! ¦ !l29!!x29!!r29! ¦ !l30!!x30!!r30! H !l31!!x31!!r31! ¦ !l32!!x32!!r32! ¦ !l33!!x33!!r33! H !l34!!x34!!r34! ¦ !l35!!x35!!r35! ¦ !l36!!x36!!r36!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	-----+-----+-----H-----+-----+-----H-----+-----+-----
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l37!!x37!!r37! ¦ !l38!!x38!!r38! ¦ !l39!!x39!!r39! H !l40!!x40!!r40! ¦ !l41!!x41!!r41! ¦ !l42!!x42!!r42! H !l43!!x43!!r43! ¦ !l44!!x44!!r44! ¦ !l45!!x45!!r45!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	-----+-----+-----H-----+-----+-----H-----+-----+-----
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l46!!x46!!r46! ¦ !l47!!x47!!r47! ¦ !l48!!x48!!r48! H !l49!!x49!!r49! ¦ !l50!!x50!!r50! ¦ !l51!!x51!!r51! H !l52!!x52!!r52! ¦ !l53!!x53!!r53! ¦ !l54!!x54!!r54!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	=================H=================H=================
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l55!!x55!!r55! ¦ !l56!!x56!!r56! ¦ !l57!!x57!!r57! H !l58!!x58!!r58! ¦ !l59!!x59!!r59! ¦ !l60!!x60!!r60! H !l61!!x61!!r61! ¦ !l62!!x62!!r62! ¦ !l63!!x63!!r63!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	-----+-----+-----H-----+-----+-----H-----+-----+-----
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l64!!x64!!r64! ¦ !l65!!x65!!r65! ¦ !l66!!x66!!r66! H !l67!!x67!!r67! ¦ !l68!!x68!!r68! ¦ !l69!!x69!!r69! H !l70!!x70!!r70! ¦ !l71!!x71!!r71! ¦ !l72!!x72!!r72!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	-----+-----+-----H-----+-----+-----H-----+-----+-----
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo 	 !l73!!x73!!r73! ¦ !l74!!x74!!r74! ¦ !l75!!x75!!r75! H !l76!!x76!!r76! ¦ !l77!!x77!!r77! ¦ !l78!!x78!!r78! H !l79!!x79!!r79! ¦ !l80!!x80!!r80! ¦ !l81!!x81!!r81!
echo 	     ¦     ¦     H     ¦     ¦     H     ¦     ¦
echo.
:SprawdzanieSudoku
set boolwygrana=0
for /l %%a in (1,1,81) do (
	if !x%%a!==!s%%a! (
		set /a boolwygrana=1
	) else (
		set /a boolwygrana=0
		goto Wynik
	)
)
:Wynik
if !boolwygrana!==1 echo. Brawo udalo ci sie ulozyc sudoku
:poruszanie
choice /c:wsda123456789r /n >nul
if ERRORLEVEL 14 goto SprawdzWiersz
if ERRORLEVEL 13 set liczba=9&goto NowaLiczba
if ERRORLEVEL 12 set liczba=8&goto NowaLiczba
if ERRORLEVEL 11 set liczba=7&goto NowaLiczba
if ERRORLEVEL 10 set liczba=6&goto NowaLiczba
if ERRORLEVEL 9 set liczba=5&goto NowaLiczba
if ERRORLEVEL 8 set liczba=4&goto NowaLiczba
if ERRORLEVEL 7 set liczba=3&goto NowaLiczba
if ERRORLEVEL 6 set liczba=2&goto NowaLiczba
if ERRORLEVEL 5 set liczba=1&goto NowaLiczba
if ERRORLEVEL 4 set ruch=Wlewo&goto NowyRuch
if ERRORLEVEL 3 set ruch=Wprawo&goto NowyRuch
if ERRORLEVEL 2 set ruch=Wdol&goto NowyRuch
if ERRORLEVEL 1 set ruch=Wgore&goto NowyRuch


:NowyRuch
set "l!pozycjagracza!= "
set "r!pozycjagracza!= "
goto !ruch!

:Wgore
set /a pozycjagracza-=9
if !pozycjagracza! LSS 1 set /a pozycjagracza+=9
goto KoniecRuchu

:Wdol
set /a pozycjagracza+=9
if !pozycjagracza! GTR 81 set /a pozycjagracza-=9 
goto KoniecRuchu

:Wprawo
set boolokejprawo=1
for /l %%a in (9,9,81) do (
	if !pozycjagracza!==%%a (
		set /a boolokejprawo=0
		goto dalejWprawo
	)
)
:dalejWprawo
if !boolokejprawo!==1 set /a pozycjagracza+=1
goto KoniecRuchu

:Wlewo
set boolokejlewo=1
for /l %%a in (1,9,73) do (
	if !pozycjagracza!==%%a (
		set /a boolokejlewo=0
		goto dalejWlewo
	)
)
:dalejWlewo
if !boolokejlewo!==1 set /a pozycjagracza-=1
goto KoniecRuchu


:KoniecRuchu
set "l!pozycjagracza!=<"
set "r!pozycjagracza!=>"
goto gra


:NowaLiczba
if !change%pozycjagracza%!==1 (
	set "x!pozycjagracza!=!liczba!"
)
goto gra

:SprawdzWiersz
set Koniecprzedzialu=1
set boolwierszgit=0
for /l %%a in (1,9,73) do (
	set /a Koniecprzedzialu=%%a+8
	if !pozycjagracza! LEQ !Koniecprzedzialu! if !pozycjagracza! GEQ %%a (
		for /l %%i in (%%a,1,!Koniecprzedzialu!) do (
			if !x%%i!==!s%%i! (
				set /a boolwierszgit=1
			) else (
				set /a boolwierszgit=0
				goto KoniecSprawdzania
			)
		) 
		goto KoniecSprawdzania
	)
)
:KoniecSprawdzania
if !boolwierszgit!==1 (
	cls
	echo Ten wiersz jest prawidlowy
	pause>nul
	goto gra
)
if !boolwierszgit!==0 (
	cls
	echo Ten wiersz jest nie prawidlowy
	pause>nul
	goto gra
)
goto gra