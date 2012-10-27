SetTitleMatchMode, 2
#SingleInstance force
#IfWinActive, APB Reloaded

~RCtrl & ~Delete::Suspend
Loop
{
LAlt & Enter::return
~RAlt & Tab::AltTab
LAlt & Tab::return
*Lwin::return
Rwin::return
*!ESC::return
Sleep 600000
}
#IfWinActive