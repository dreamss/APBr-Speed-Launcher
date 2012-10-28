@echo off
SET APBVOLUMELEVEL= 0.5
for /f "TOKENS=1" %%c in ('wmic PROCESS where "Name='apb.exe'" get ProcessID ^| findstr [0-9]') do (
echo Found APB pid: %%c, setting volume to %APBVOLUMELEVEL%
nircmd.exe setappvolume /%%c %APBVOLUMELEVEL%
)


