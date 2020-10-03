/*	HUEVOS
	Human User Element Variables Organizer Script
	
	Quickly populate or repopulate 
*/

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force  ; only allow one running instance per user
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 2

INIT:
{
	startDir :=
	ext := "*.egg"
	delay := 250
	
	FileSelectFile, fname, , %starDir%, HUEVOS - select EGG file, %ext%
	FileRead, filein, %fname%

}

^|::
{
	MsgBox, 35, INSERT VALUES?, Yes = Insert`nNo = Delete`nCancel = Quit
	IfMsgBox, Yes
		insertVals(delay)
	IfMsgBox, No
		deleteVals(delay)
	IfMsgBox, Cancel
		ExitApp
}

insertVals(delay) {
	global filein
	loop, parse, filein, `n,`r
	{
		if GetKeyState("Esc") {
			MsgBox BREAK!
			break
		}
		val:=StrSplit(A_LoopField,",")
		name := val[1]
		var := val[2]
		
		Send, %name% {tab} 
		sleep, delay
		Send, %var% {tab}
		sleep, delay
	}
	
	return
}

deleteVals(delay) {
	loop, 200
	{
		if GetKeyState("Esc") {
			break
		}
		Send, {del}{tab}
		sleep, delay
	}
	MsgBox BREAK!
	return
}