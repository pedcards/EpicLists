/*	HUEVOS
	Human User Element Variables Organizing Script
	
	Quickly populate or repopulate an Epic Patient List
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
	delay := 200
	acc_string := "Add/Remove Patients|Change Accessibility|Delete Patient List|Modify Properties|View Only"
	
	FileSelectFile, fname, , %starDir%, HUEVOS - select EGG file, %ext%
	FileRead, filein, %fname%

}

^|::
{
	insertVals()
}

insertVals() {
	global filein, delay, acc_string
	
	loop, parse, filein, `n,`r
	{
		if checkESC() {
			break
		}
		
		if (A_Index=1) {																; first row	
			acc:=parseCols()
		}
		
		val:=A_LoopField
		
		sendRow(val,acc)
		
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
/*	Check if {esc} is depressed :(
	return 1 if true
*/
	if GetKeyState("Esc") {
		MsgBox BREAK!
		return true
	}
}

parseCols() {
	global acc_string
	
	col := getRow()
	if InStr(acc_string,col.2) {
		SendInput +{tab}
		col.3 := checkfield()
	}
	
	if (col.3=col.1) {
		return col.2
	} else {
		return false
	}
}

checkField() {
	global delay
	send ^c
	sleep delay
	return Clipboard
}

getRow() {
	col1 := checkfield()
	SendInput {tab}
	col2 := checkfield()
	
	return [col1,col2]
}

sendRow(val,acc) {
	global delay
	
	SendInput, %val% 
	sleep delay
	
	SendInput, {tab} %acc% 
	sleep delay
	
	SendInput {tab}
	sleep delay
	
	return
}