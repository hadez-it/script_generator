;*****************************************
;scriptGenerator_230518.au3 by HP
;Created with ISN AutoIt Studio v. 1.07
;*****************************************
#include "Forms\frmMain.isf"
#include <Clipboard.au3>
#include <GUIConstants.au3>
#include <GuiEdit.au3>
#include <Array.au3>
#include <GuiEdit.au3>

#Region MainCode
Opt("GUIOnEventMode", 1)
GUISetState(@SW_SHOW, $frmMain)
AutoItSetOption("GUICloseOnEsc", 0)
#EndRegion MainCode

$script = ""
$text = ""
$CodeRaw = ""

While 1
	Sleep(100)
    $msg = GUIGetMsg()

    Select
        Case $msg = $GUI_EVENT_CLOSE
            Exit
    EndSelect
WEnd
Func _exit()
	Exit
EndFunc

Func _Capture()
	$script = ""
	$text = ""
	While 1
		Sleep(500)
			$script = ClipGet()
			
			If $text <> $script Then
				_GUICtrlEdit_AppendText($editText, $script & "|")	
			EndIf
			
			$text = $script			
			
		If $script == "exit" Then
			ExitLoop			
		EndIf
	Wend	
	
EndFunc

Func GenerateCode()
	$CodeRaw = GUICtrlRead($editText)
	$Codelist = StringSplit($CodeRaw, "|")
	$ii = 1
	GUICtrlSetData($editText, "")
;~ 	_ArrayDisplay($Codelist)
	For $i = 1 to $Codelist[0]/6
		$winTitle = "WinWait(" & '"' & $Codelist[$ii] & '"' & " , " & '"' & $Codelist[$ii + 1]& '"' & ")"
		$winControl = "ControlSend(" & '"' & $Codelist[$ii + 2] & '"' &" , " & '"' & $Codelist[$ii + 3] & '"' & " , " & '"' & $Codelist[$ii + 4] & '"' & " , " & '"' & $Codelist[$ii + 5] & '"' & ")"
		_GUICtrlEdit_AppendText($editText, @CRLF & $winTitle)
		_GUICtrlEdit_AppendText($editText,  @CRLF & "Sleep(300)")
		_GUICtrlEdit_AppendText($editText, @CRLF & $winControl)
		_GUICtrlEdit_AppendText($editText,  @CRLF)
		
		$ii += 6
	Next
	
;~ 	For $i = 1 To $Codelist[0] ; Loop through the array returned by StringSplit to display the individual values.
;~         MsgBox($MB_SYSTEMMODAL, "", "$aDays[" & $i & "] - " & $Codelist[$i])
;~     Next
EndFunc
