# FSLeyes_Gygwin

steps to setup and run **FSLeyes** (https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FSLeyes) \
under Windows using **Cygwin** (https://www.cygwin.com)

### Install Cygwin64 & FSLeyes
- from within your Browser download "**setup-x86_64.exe**" from https://www.cygwin.com
- from Windows execute the following command: \
  (either paste this into Windows Start Menu search, or use a Windows command shell)
```
   %HOMEPATH%\Downloads\setup-x86_64.exe -q -P wget
```
&emsp; when the Installer Window opens, choose your prefered Download Site from the list \
&emsp; In the following two windows that open just hit the "Next" botton and at the end "Finish" 
- from the Windows Startup Menu (or the Desktop Shortcut) open a Cygwin64 Terminal
- inside the Cygwin Terminal Window execute the following commands
```
   wget https://raw.githubusercontent.com/bfoe/FSLeyes_Gygwin/master/Setup_FSLeyes.sh
   chmod +x Setup_FSLeyes.sh
   . ./Setup_FSLeyes.sh
```
&emsp; this will automatically download and install all required packages

##

### Run FSLeyes
- either simply run the provided script as "**./RUN_FSLeyes.sh**"
- or: manually start the XWin server under the Cygwin-X Windows Start menu \
  then start the Cygwin64 terminal, enter "**export DISPLAY=:0**", and then "**fsleyes**"

##

### Compile wheels (optional)
for those who want to install FSLeyes from scratch compiling source code ...
- run the complile script with "**.&nbsp; ./Setup_FSLeyes_CompileAll**" \
  this replaces the "Setup_FSLeyes" script (be warned, compiling takes a while;) \
  you will find compilation results (mainly the wheels) in the "~/backuped" folder

##

### Known Problems
- FSLeyes integrates with FSL, which is not yet available under Cygwin
- Warning message (hidden when running from the script)
```
   Warning: Error retrieving accessibility bus address: org.freedesktop.DBus.Error.NoReply
   Message recipient disconnected from message bus without replying
```
&emsp; this may be the reason why each time fsleyes is run it leave a process "dbus-deamon.exe" running \
&emsp; when running fsleyes manually this can be killed from the Windows task manager 
- Error message (hidden when running from the script) \
  Upon exit fsleyes displays a message related to Python threading
```
   File /usr/local/lib/python3.8/site-packages/fsleyes/filtermain.py,
   line 112, in read_loop line = fin.readline()
   OSError: [Errno 9] Bad file descriptor
```

##

### License
- FSLeyes is under the Apache License v2 (https://git.fmrib.ox.ac.uk/fsl/fsleyes/fsleyes/blob/master/LICENSE)
- Cygwin license terms: https://cygwin.com/licensing.html
- the additional Python packages used in this project are mostly under some 
<a href="https://en.wikipedia.org/wiki/BSD_licenses">BSD license</a>  \
  (if this is of crucial importance to you, be sure to check with "pip3.8 show \<packagename\>")
- the content of this project is under the
<a href="https://en.wikipedia.org/wiki/MIT_License">MIT license</a> 
