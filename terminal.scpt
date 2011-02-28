tell application "System Events"
	set TerminalCount to (count (every process whose name is "Terminal"))
end tell

if (TerminalCount is not 0) then
	tell application "Terminal"
		do script
		activate
	end tell
else
	tell application "Terminal"
		activate
	end tell
end if

