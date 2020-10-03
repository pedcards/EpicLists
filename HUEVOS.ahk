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
		insertVals()
	IfMsgBox, No
		deleteVals()
	IfMsgBox, Cancel
		ExitApp
}

insertVals() {
	global filein, delay
	
	loop, parse, filein, `n,`r
	{
		if checkESC() {
			break
		}
		
		val:=StrSplit(A_LoopField,",")
		name := val[1]
		var := val[2]
		
		SendInput %name%
		sleep delay
		KeyWait ``, D
		
		SendInput {tab} %var% {tab}
		sleep delay
	}
	
	MsgBox DONE!
	
	return
}

deleteVals() {
	global delay
	loop, 200
	{
		if checkEsc() {
			break
		}
		Send, {del}{tab}
		sleep, delay
	}
	return
}

checkEsc() {
	if GetKeyState("Esc") {
		MsgBox BREAK!
		return true
	}
}
