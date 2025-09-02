# windows-workspaces

An AutoHotkey script for Windows that lets a user switch between virtual desktops with similar keybinds as i3wm. It also provides other features, such as auto creating n number of workspaces on startup (default: 10, like in i3wm), swapping windows between monitors (dual monitor only), customizing the key combinations etc. (see Hotkeys section below).

## Hotkeys

Action | Keys 
--- | :-:
**Switch** to virtual desktop **1, 2, etc.**<br>*(you can also use the Numpad)*|<kbd>Alt</kbd> + <kbd>1</kbd><br><kbd>Alt</kbd> + <kbd>2</kbd><br>...<br><kbd>Alt</kbd> + <kbd>0</kbd>
**Switch back** to the last desktop used|<kbd>Alt</kbd> + <kbd>p</kbd>
**Swap** windows between two monitors|<kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>m</kbd>
**Switch** to the virtual desktop on the **left**<br>*(auto-cycles from the first to the last desktop)*|<kbd>Alt</kbd> + <kbd>h</kbd>
**Switch** to the virtual desktop on the **right**<br>*(auto-cycles from the last to the first desktop)*|<kbd>Alt</kbd> + <kbd>l</kbd>
**Create** a new virtual desktop|<kbd>Alt</kbd> + <kbd>Ctrl</kbd> + <kbd>c</kbd>
**Delete** the current virtual desktop|<kbd>Alt</kbd> + <kbd>Ctrl</kbd> + <kbd>d</kbd>
**Move** the current window to another desktop<br>|<kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>1</kbd><br><kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>2</kbd><br>...<br><kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>0</kbd>
**Move** the current window to the desktop on the left or the right, then switch to it|<kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>h</kbd><br><kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>l</kbd>
Toggle **Maximize/Non-Maximize** focused window|<kbd>Alt</kbd> + <kbd>f</kbd>
**Change** Monitor **Resolution** and **Refresh Rate** (Change config for your monitor spec)|<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>1</kbd><br><kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>2</kbd><br>...<br><kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>0</kbd>
**Quit** focused window|<kbd>Alt</kbd> + <kbd>q</kbd>
**Open** search|<kbd>Alt</kbd> + <kbd>d</kbd>


Note, <kbd>Alt</kbd> continues to function normally even when it is used as a modifier. [But you can make the button do more useful things such as open overview, or disable it altogether](https://github.com/pmb6tz/windows-desktop-switcher/issues/67).

If you'd like, you can enable the alternate configuration, to use <kbd>Super (Win key)</kbd> as modifier key instead of <kbd>Alt</kbd> (e.g. use <kbd>Super</kbd> + <kbd>1</kbd> to switch to the Desktop 1, just as you would use <kbd>Alt</kbd> + <kbd>1</kbd>).

Additional hotkeys, such as [pinning a window or app on all workspaces](https://github.com/pmb6tz/windows-desktop-switcher/issues/55), can be added as well.

You can also customize the hotkeys and actions as described in the section below.

## Overview
This script creates more convenient hotkeys for switching virtual desktops in Windows 11. I forked this to better mirror the mapping I use on linux (with i3wm), and it's always annoyed me that Windows does not have better hotkey support for this feature (for instance, there's no way to go directly to a desktop by number).

## Running
[Install AutoHotkey](https://autohotkey.com/download/) v1.1 or later, then run the `desktop_switcher.ahk` script (open with AutoHotkey if prompted). You can disable the switching animation in `Settings -> Accessibility -> Visual Effects` and toggling off `Animation effects`.

### Notes about Windows 23H2 22631.3085 ≤ Updates
This project relies partly on [VirtualDesktopAccessor.dll](https://github.com/Ciantic/VirtualDesktopAccessor) (for moving windows to other desktops). This binary is included in this repository for convenience, and was recently updated to work with the Windows 11 (requires at least 23H2 22631.3085, tested with 22631.3155) updates. 

This may cause instability for users running older versions of Windows. If this is the case, [download the older DLL](https://github.com/pmb6tz/windows-desktop-switcher/blob/5289a0968179638f6e946a4cb69723510abd0d19/virtual-desktop-accessor.dll), rename it to `VirtualDesktopAccessor.dll`, and overwrite the previous DLL.

If a future Windows Update breaks the DLL again and updating your files from this repository doesn't work, you could try [building the DLL yourself](https://github.com/Ciantic/VirtualDesktopAccessor) (given that it was since updated by its' creators).

## Customizing Hotkeys
To change the key mappings, modify the `user_config.ahk` script and then run `desktop_switcher.ahk` (program will restart if it's already running). Note, `!` corresponds to <kbd>Alt</kbd>, `<^>!` is <kbd>AltGr</kbd>, `+` is <kbd>Shift</kbd>, `#` is <kbd>Win</kbd>, and `^` is <kbd>Ctrl</kbd>. A more detailed description of hotkeys can be found [here](https://autohotkey.com/docs/Hotkeys.htm). The syntax of the config file is `HOTKEY::ACTION`. Here are some examples of the customization options. 

Single line of code example | Meaning
--- | ---
`!l::switchDesktopToRight()`&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | **Hotkey:** <kbd>Alt</kbd> + <kbd>N</kbd><br>**Action:** Switch to the desktop on the right
`#!space::switchDesktopToRight()` | **Hotkey:** <kbd>Win</kbd> + <kbd>Alt</kbd> + <kbd>Space</kbd><br>**Action:** Switch to the desktop on the right
`CapsLock & n::switchDesktopToRight()` | **Hotkey:** <kbd>Capslock</kbd> + <kbd>N</kbd><br>**Action:** Switch to the desktop on the right<br>*(& is necessary when using a non-modifier key such as Capslock)*
`^space::send, #{tab} ` | **Hotkey:** <kbd>Ctrl</kbd> + <kbd>Space</kbd><br>**Action:** Open Desktop Manager by sending <kbd>Win</kbd> + <kbd>Tab</kbd>

You can change the number of virtual desktops created on boot by changing the number passed in `setupWorkspace(10)` in `user_config.ahk`

A more detailed description of hotkeys can be found here: [AutoHotkey docs](https://autohotkey.com/docs/Hotkeys.htm).<br>
You can find the explanation for the Desktop Manager hotkey [here](https://github.com/pmb6tz/windows-desktop-switcher/issues/41).<br>
After any changes to the configuration the program needs to be closed and opened again.

## Running on boot

You can make the script run on every boot with either of these methods.

### Simple (Non-administrator method)

1. Press <kbd>Win</kbd> + <kbd>R</kbd>, enter `shell:startup`, then click <kbd>OK</kbd>
2. Create a shortcut to the `desktop_switcher.ahk` file here

### Advanced (Administrator method)

Windows prevents hotkeys from working in windows that were launched with higher elevation than the AutoHotKey script (such as CMD or Powershell terminals that were launched as Administrator). As a result, Windows Desktop Switcher hotkeys will only work within these windows if the script itself is `Run as Administrator`, due to the way Windows is designed. 

You can do this by creating a scheduled task to invoke the script at logon. You may use 'Task Scheduler', or create the task in powershell as demonstrated.
```
# Run the following commands in an Administrator powershell prompt. 
# Be sure to specify the correct path to your desktop_switcher.ahk file. 

$A = New-ScheduledTaskAction -Execute "PATH\TO\desktop_switcher.ahk"
$T = New-ScheduledTaskTrigger -AtLogon
$P = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Administrators" -RunLevel Highest
$S = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0
$D = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S
Register-ScheduledTask WindowsDesktopSwitcher -InputObject $D
```

The task is now registered and will run on the next logon, and can be viewed or modified in 'Task Scheduler'. 

## Q&A

#### How to prevent cycling of desktop switching when end desktop or start desktop is reached?

Solution is described in [#66](https://github.com/pmb6tz/windows-desktop-switcher/issues/66#issuecomment-741793147).

#### How to see at a glance, which of the desktops am I currently on (i.e. show a number of the current desktop as a tray bar icon)?

Solution is described in [#50](https://github.com/pmb6tz/windows-desktop-switcher/issues/50#issuecomment-935875918).

## Credits
- This is a fork of [pmb6tz/windows-desktop-switcher](https://github.com/pmb6tz/windows-desktop-switcher.git)
- Thanks to [Ciantic/VirtualDesktopAccessor](https://github.com/Ciantic/VirtualDesktopAccessor) (DLL) and [sdias/win-10-virtual-desktop-enhancer](https://github.com/sdias/win-10-virtual-desktop-enhancer) (DLL usage samples), our code can now move windows between desktops.

## Other
To see debug messages, download [SysInternals DebugView](https://technet.microsoft.com/en-us/sysinternals/debugview).

This script is intended to be lightweight in order to prioritize performance and robustness. For more advanced features (such as configuring different wallpapers on different desktops) check out https://github.com/sdias/win-10-virtual-desktop-enhancer.