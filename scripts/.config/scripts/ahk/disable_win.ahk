; --- Disable Start menu when Win pressed alone, keep Win+ combos ---
~LWin:: {
    ; When Win is pressed down, immediately send a dummy key
    ; to pre-empt Windows from queuing the Start menu
    Send("{Blind}{vkE8}")
}

~RWin:: {
    ; When Win is pressed down, immediately send a dummy key
    ; to pre-empt Windows from queuing the Start menu
    Send("{Blind}{vkE8}")
}

#P:: {
    Send("{Blind}{vkE8}")
}

#E:: {
    Send("{Blind}{vkE8}")
}

#C:: {
    Send("{Blind}{vkE8}")
}
