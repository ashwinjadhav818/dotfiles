@echo off
echo Choose a Ryzen preset:
echo [1] Standard (balanced)
echo [2] Low Power (ultra battery saver)
echo [3] Performance (max boost)
set /p choice=Enter 1, 2, or 3: 

:: Standard preset (balanced)
if "%choice%"=="1" ryzenadj --stapm-limit=10000 --fast-limit=12500 --slow-limit=10000 --stapm-time=2000 --slow-time=5 --tctl-temp=75 --vrm-current=9000 --vrmsoc-current=9000 --vrmmax-current=14000 --vrmsocmax-current=12000 --psi0-current=0 --psi0soc-current=0

:: Low Power preset
if "%choice%"=="2" ryzenadj --stapm-limit=8000 --fast-limit=10000 --slow-limit=7000 --stapm-time=4000 --slow-time=5 --tctl-temp=70 --vrm-current=7000 --vrmsoc-current=7000 --vrmmax-current=10000 --vrmsocmax-current=9000 --psi0-current=0 --psi0soc-current=0

:: Performance preset (safe for 3250U)
if "%choice%"=="3" ryzenadj --stapm-limit=15000 --fast-limit=22000 --slow-limit=17000 --stapm-time=100 --slow-time=5 --tctl-temp=89 --vrm-current=12000 --vrmsoc-current=10000 --vrmmax-current=18000 --vrmsocmax-current=13000

echo Done.
pause

