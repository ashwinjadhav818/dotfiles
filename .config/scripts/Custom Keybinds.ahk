#Requires AutoHotkey v2.0

Launch_Media::^!+S ; Launches Spotify
Launch_App2::^!+p ; Launches Notion

#Enter::Run "alacritty"

Pause::
{
    Sleep(500) ; Wait for 0.5 second
    SendMessage(0x112, 0xF170, 2,, "Program Manager")
}
