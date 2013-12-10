on run this_file
	set operationMode to 0
	set localFileName to this_file
	set completeFilePath to getCurrentDir() of me & localFileName
	set serversList to readFileContents(completeFilePath) of me

	tell application "iTerm"
        	activate

        	set myterm to (make new terminal)
        	tell myterm
                	set number of columns to 100
                	set number of rows to 100

                	set currentCount to 0
                	repeat with i in serversList
                        	# the next commented line shows a dialog box!
                        	#display dialog i

                        	set mysession to (launch session "default")
                        	tell mysession
                                	set foreground color to "yellow"
                                	set cursor color to "white"
                                	#set background color to "black"
                                	set transparency to "0.2"
                                	set name to "" & i
                                	set currentCount to currentCount + 1
                                	write text "ssh -o StrictHostKeyChecking=no " & i & return
                                	#write text "sudo su -"
                        	end tell
                	end repeat
        	end tell
	end tell
end run

(*
 reads the contents of a file
 and returns a list containing
 one element for each line
 on the original file
 *)
on readFileContents(filePath)
        set fileContent to (do shell script "grep -v ^# '" & filePath & "'")
        set listVariable to every paragraph of fileContent
        return listVariable
end readFileContents

(*
 returns the POSIX path of
 the current script path
*)
on getCurrentDir()
        tell application "Finder" to get folder of (path to me) as Unicode text
        set workingDir to POSIX path of result
        return workingDir
end getCurrentDir
