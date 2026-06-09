#Requires AutoHotkey v2.0
#SingleInstance Force

!c::Send "^c"
!v::Send "^v"
!a::Send "^a"
!w::Send "^w"
!x::Send "^x"
!z::Send "^z"
!+z::Send "^+z"
!s::Send "^s"
!f::Send "^f"
!t::Send "^t"
!n::Send "^n"
!r::Send "^r"

^!F12::
{
    Suspend -1
    TrayTip "Mac-style hotkeys", A_IsSuspended ? "Paused for games" : "Enabled"
}
