echo off
cd Debug
copy FortranDll.dll ..\..\Cproj\Debug
copy FortranDll.lib ..\..\Cproj\Debug
copy FortranDll.map ..\..\Cproj\Debug

copy FortranDll.dll c:\Users\User\source\repos\CsFort\bin\Debug
copy FortranDll.lib c:\Users\User\source\repos\CsFort\bin\Debug
copy FortranDll.map c:\Users\User\source\repos\CsFort\bin\Debug

exit
