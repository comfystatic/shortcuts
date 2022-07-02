#SingleInstance Force
#Persistent
#NoEnv

*F23::
    Input UserInput, , {Space}{Enter}

    Switch UserInput
    {
        case "": If WinActive("ahk_exe chrome.exe") 
            Send, ^l
        case "o": Tab(TextSelected()) ; Generic Search

        case "d": Query("di") ; Dictionary
        ; case "d": VSCode("C:\Rainlink\") ; New JS Script
        case "t": Query("thes") ; Thesaurus
        ; case "g": Query("ddg") ; duck duck
        case "g": Query("g") ; Google
        case "i": Query("ddgi") ; images
        case "r": Query("relword") ; Related Words
        case "m": Query("maps") ; Maps
        case "w": Query("wra") ; Wolfram Alpha
        case "y": Query("yt") ; youtube
        case "a": Query("a") ; Amazon
        case "rd": Query("r") ; Reddit
        case "ii": Query("gi") ; Google Images
        case "im": Query("imdb") ; IMDB
        case "gh": Query("gh") ; Github
        case "gt": Query("gtranslate") ; Google translate
        case "tr": Query("deeplen") ; DeepL translate
        case "so": Query("so") ; Stack Overflow
        case "un": Query("uns") ; Unsplash

        case "n": Run, Notepad ; Notepad
        case "c": VSCode() ; VS Code
        case "x": VSCode(A_ScriptDir) ; VS Code
        case "js": VSCode("C:\Node") ; VS Code
        case "s": Run % "C:\Rainlink\Spotify" ; Spotify

        case "ai": Tab("https://beta.openai.com/playground") ; 420
        case "bg": Query("boardgamegeek") ; Board Game Geek

        case "dd": Tab("https://thedowntowndispensary.com/adult-use-pickup/") ; 420

        case "rpg": Query("rpg") ; RPG Stack Exchange
        case "del": Deluge() ; Deluge
        case "fan": Query("fandom") ; Fandom Wikis
        case "imd": Query("imdb") ; IMDB
        case "tor": Tor() ; Tor
        case "url": Query("gdomains") ; 420
        case "7": Query("dnd") ; DND
        case "8": Query("dndio") ; DND
        case "1": Query("bang") ; Bang search
        case "2": Chrome("Default", "https://mail.google.com/mail/u/0/?tab=rm1#inbox") ; Mail
        case "22": Send, yenmcilrath@gmail.com
        case "3": Chrome("Profile 5") ; Comfy Static
        case "6": Tab("https://www.autohotkey.com/docs/Hotkeys.htm") ; AHK
        case "=": Tab("https://desmos.com/calculator") ; Desmos
        case "/": Tab("https://frequencylist.com/") ; Frequency List
        Default: return
    }

return

*F23 Up::
    Input
return

TextSelected() {
    ClipSaved := ClipboardAll
    Str:= Clipboard
    Clipboard := "" ; Clear the 
    Send, {CTRLDOWN}c{CTRLUP}
    if (Clipboard != "" AND !InStr(ClipBoard, A_ScriptDir)) {
        ; something has been selected
        Str := Clipboard
        Clipboard := ClipSaved
        ;Clipboard := Str
        ClipSaved = ; Free the memory in case the clipboard was very large.
        return Str
    } else {
        Clipboard := ClipSaved
        ClipSaved =
        return ""
    }

}

Tab(url="", profile="") {
    url := "{Text}" url
    if WinExist("ahk_exe chrome.exe") {
        WinActivate
        Sleep, 500
        WinGetTitle, name, A
        action := WinActive("New Tab") ? "l" : "t"
            SendInput, {Ctrl down}%action%{Ctrl up}%url%
            if (url != "") {
                SendInput, {Enter}
            }
        } else {
            Chrome(profile == "" ? "Profile 5" : profile, url)
        }
    }

    VSCode(Path="") {
        if WinExist("ahk_exe Code.exe") {
            WinActivate
        } else {
            Run, C:\Program Files\Microsoft VS Code\Code.exe %Path%
        }
    }

    Query(Bang) {
        if WinActive("New Tab") {
            SendInput, ^l
        }
        TextSel := TextSelected()
        ;   StringReplace, TextSel, TextSel, . , %A_Space%, All
        StringReplace, TextSel, TextSel, + , `%2B, All
        StringReplace, TextSel, TextSel, `r`n,, All
        TextSel := (TextSel == "") ? "" : Trim(TextSel)
        StringReplace, Replaced, TextSel, %A_Space%, +, All

        Switch Bang
        {
            case "dndio": url := "https://www.dndwiki.io/search?query=" Replaced
            Default: url := "https://duckduckgo.com/?q=" Replaced "+!" Bang
        }

        Tab(url)
    }

    Deluge() {
        Run, C:\Rainlink\Deluge.lnk
        WinWait, 1
        WinActivate "Deluge"
        Send, ^o {Tab 2} {Enter}
    }

    Tor() {
        Run, C:\Rainlink\Tor.lnk
        WinWait, 1
        WinActivate "Tor Browser"
    }

    Chrome(profile_name:="Default", url:="", wait_ms_to_close:=200, wait_s_to_activate:=5) {
        static chrome_profiles := {}
        chrome_path := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"

        ; Check if profile is stored already and the hwnd still exists if no url is
        ; specified.
        if !url {
            profile_hwnd := chrome_profiles[profile_name]
            if (profile_hwnd && WinExist("ahk_id " . profile_hwnd)) {
                WinActivate, % "ahk_id " . profile_hwnd
                return profile_hwnd
            }
        }

        ; Build the target.
        run_target := """" . chrome_path """"
        run_target .= "--profile-directory=""" . profile_name . """"

        WinGet, current_process, ProcessName, A
        if (current_process = "chrome.exe") {
            ; Focus the tray to be able to wait for chrome.exe to get active later on.
            WinActivate, % "ahk_class Shell_TrayWnd"
            WinWaitActive, % "ahk_class Shell_TrayWnd", , 1
        }

        if url {
            ; If an url is specified just run the profile with that url and wait for
            ; chrome to be active.
            run_target .= " " . url
            Run, % run_target
            WinWaitActive, % "ahk_exe chrome.exe", , wait_for
            if ErrorLevel {
                return 0
            } else {
                WinGet, chrome_hwnd, ID, A
                chrome_profiles[profile_name] := chrome_hwnd
                return chrome_hwnd
            }
        } else {
            ; The seconds loops is only needed in case chrome with that profile
            ; didn't exist before and it the session doesn't have any other tabs as
            ; this code will close the new tab opened and therefore also close the
            ; chrome instance. In that case a 2nd iteration is needed which opens
            ; chrome with a new tab.
            Loop, 2 {
                if (A_Index = 1) {
                    Run, % run_target . " example.com"
                } else {
                    Run, % run_target
                }
                WinWaitActive, % "ahk_exe chrome.exe", , % wait_s_to_activate
                if ErrorLevel {
                    return 0
                } else {
                    ; Get the hwnd of the window and close the fake tab.
                    WinGet, chrome_hwnd, ID, A
                    ; Only close the tab on the first iteration.
                    if (A_Index = 1) {
                        SendInput, ^w
                        Sleep, % wait_ms_to_close
                    }
                    ; Check if the window handle still exists. If chrome with that
                    ; profile was not open before closing the tab closes chrome as well
                    ; and the hwnd will not exist anymore.
                    if WinExist("ahk_id " . chrome_hwnd) {
                        chrome_profiles[profile_name] := chrome_hwnd
                        return chrome_hwnd
                    }
                }
            }
        }
    }
