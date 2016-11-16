#include <inet.au3>
#include <string.au3>

Global $url = 'http://battlepug.com/comic/2011/2/21/the-warrior-and-the-battlepug'
Global $i = 1

DirCreate(@ScriptDir & "\comics")

; Broken at 101
; http://static1.squarespace.com/static/52309c25e4b0f064c825909d/5232765ee4b00ee63fcaf307/5237555fe4b04e9390b5fca3/1379358075734/bp100.jpg?

While 1
	TraySetToolTip("Battlepug" & @CRLF & $i & "...")
	$source = _INetGetSource($url, True)
	$next = _StringBetween($source, '<a href="/comic/2', '">')
	$url = 'http://battlepug.com/comic/2' & $next[1]

	if StringInStr($source, '<meta property="og:image" content="') Then
		$img = _StringBetween($source, '<meta property="og:image" content="', 'format')
		if IsArray($img) Then
			if not FileExists(@ScriptDir & "\comics\" & $i & ".jpg") Then
				ConsoleWrite($i & ": " & $img[0] &  @CRLF)
				InetGet($img[0], @ScriptDir & "\comics\" & $i & ".png", 3, 0)
			Else
				ConsoleWrite($i & ": Skipping" & @CRLF)
			EndIf
		EndIf
	EndIf
	$i = $i + 1
	;sleep(Random(1000,2400,1))
WEnd