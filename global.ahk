; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
SetKeyDelay 1
#SingleInstance, force
DetectHiddenWindows, On
#Persistent

#Include %A_ScriptDir%\shellrun.ahk

Run, workspaces.ahk

controlID	   := 0

; If the script is not elevated, relaunch as administrator and kill current instance:

full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try ; leads to having the script re-launching itself as administrator
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}





^!s::
Run "C:\Program Files\Everything\Everything.exe"
return

#q::
WinClose, A
return

#z::
WinGet MX, MinMax, A
   If MX
        WinRestore A
   Else PostMessage, 0x112, 0xF030,,, A  ; 0x112 = WM_SYSCOMMAND, 0xF030 = SC_MAXIMIZE
return

!t::
if (WinExist("ahk_class PuTTY")) {
   if WinActive("ahk_class PuTTY")
       WinMinimize, ahk_class PuTTY
   else 
       WinActivate, ahk_class PuTTY
} Else {
   Run putty
}
return


!SC029::
if (WinExist("ahk_class PuTTY")) {
   if WinActive("ahk_class PuTTY")
       WinMinimize, ahk_class PuTTY
   else 
       WinActivate, ahk_class PuTTY
} Else {
   Run putty
}
return

^!r::
ShellRun("C:\Users\i.gromov\AppData\Local\Programs\Microsoft VS Code\Code.exe", "--force-device-scale-factor=1.0") 
return

^!q::
ShellRun("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
return

*CapsLock::LButton

!$s::
Send {Down}
return

!w::
Send {Up}
return

!a::
Send {Left}
return

!d::
Send {Right}
return

!$*x::
Send {XButton2}
return


!$*z::
Send {XButton1}
return

^!c::
Run, calc
return


    !^f::
    ControlSend,, {Text}gradle deployStatic, ahk_class PuTTY ;PuTTY
    ControlSend,, {Enter}, ahk_class PuTTY
    ; Gets the control ID of google chrome
    Sleep, 2000
	ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome
	; Focuses on chrome without breaking focus on what you're doing
	ControlFocus,,ahk_id %controlID%
    ControlSend, Chrome_RenderWidgetHostHWND1, ^{f5}, Google Chrome
    ;ControlSend,, ^{f5}, ahk_class MozillaWindowClass
    RETURN

    !^d::
    ControlSend,, {Text}gradle deploy, ahk_class PuTTY
    ControlSend,, {Enter}, ahk_class PuTTY
    ; Gets the control ID of google chrome
    ;Sleep, 1000
	;ControlGet, controlID, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome
	; Focuses on chrome without breaking focus on what you're doing
	;ControlFocus,,ahk_id %controlID%
    ;ControlSend, Chrome_RenderWidgetHostHWND1, ^+{R}, Google Chrome
    RETURN

#IfWinActive ahk_exe Code - Insiders.exe
^WheelUp::Send {Numpad2}
^WheelDown::Send {Numpad3}
#IfWinActive

#IfWinActive ahk_exe Code.exe
^WheelUp::Send {Numpad2}
^WheelDown::Send {Numpad3}
#IfWinActive


#IfWinActive ahk_exe putty.exe
^Tab::Send {Numpad0}
^+Tab::Send {Numpad1}
#IfWinActive


















