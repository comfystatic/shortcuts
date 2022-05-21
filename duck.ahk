#SingleInstance Force
#Persistent
#NoEnv

F23::
    Input UserInput, , {Space}{Enter}

    Switch UserInput
    {
    case "":
        if WinActive("ahk_exe chrome.exe") {
            Send, ^l
        }
    case "o": Tab(TextSelected()) ; Generic Search

    case "d": Duck("di") ; Dictionary
    ; case "d": VSCode("C:\Rainlink\") ; New JS Script
    case "t": Duck("thes") ; Thesaurus
    ; case "g": Duck("ddg") ; duck duck
    case "g": Duck("g") ; Google
    case "i": Duck("ddgi") ; images
    case "r": Duck("relword") ; Related Words
    case "m": Duck("maps") ; Maps
    case "y": Duck("yt") ; youtube
    case "az": Duck("a") ; Amazon
    case "rd": Duck("r") ; Reddit
    case "ii": Duck("gi") ; Google Images
    case "im": Duck("imdb") ; IMDB
    case "gh": Duck("gh") ; Github
    case "gt": Duck("gtranslate") ; Google translate
    case "tr": Duck("deeplen") ; DeepL translate
    case "so": Duck("so") ; Stack Overflow
    case "un": Duck("uns") ; Unsplash
    
    case "n": Run, Notepad ; Notepad
    case "c": VSCode(A_ScriptDir) ; VS Code
    case "s": Run % "C:\Rainlink\Spotify" ; Spotify

    case "ai": Tab("https://beta.openai.com/playground") ; 420
    case "bg": Duck("boardgamegeek") ; Board Game Geek
    case "wr": Duck("wra") ; Wolfram Alpha

    case "dd": Tab("https://thedowntowndispensary.com/adult-use-pickup/") ; 420

    case "rpg": Duck("rpg") ; RPG Stack Exchange
    case "del": Deluge() ; Deluge
    case "fan": Duck("fandom") ; Fandom Wikis
    case "imd": Duck("imdb") ; IMDB
    case "tor": Tor() ; Tor
    case "7": Duck("dnd") ; DND
    case "1": Duck("bang") ; Bang search
    case "2": Chrome("Default", "https://mail.google.com/mail/u/0/?tab=rm1#inbox") ; Mail
    case "22": Send, yenmcilrath@gmail.com
    case "6": Tab("https://www.autohotkey.com/docs/Hotkeys.htm") ; AHK
    case "3": Chrome("Profile 5") ; Comfy Static
    case "/": Tab("https://frequencylist.com/") ; Frequency List
    Default: return
    }

    return

F23 Up::
    Input  ; End input.
    return


TextSelected() {
    ClipSaved := ClipboardAll
    Str:= Clipboard
    Clipboard := "" ; Clear the clipboard
    Send, {CTRLDOWN}c{CTRLUP}
    ClipWait, 1
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
        Run, C:\Rainlink\Visual Studio Code.lnk %Path%
    }
}

Duck(Bang) {
    if WinActive("New Tab") {
        SendInput, ^l
    }
    TextSel := TextSelected()
;   StringReplace, TextSel, TextSel, . , %A_Space%, All
    StringReplace, TextSel, TextSel, + , `%2B, All
    TextSel := (TextSel == "") ? "" : Trim(TextSel) " "
    StringReplace, Replaced, TextSel, %A_Space%, +, All
    url := "https://duckduckgo.com/?q=" Replaced "!" Bang
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
