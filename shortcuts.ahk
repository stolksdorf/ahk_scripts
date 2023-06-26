;; Collection of general shortuts & hotstrings

+CapsLock::Send("{Home}+{End}")

^Del::Run("taskmgr.exe")

; Easy Date
^!d::Send(A_YYYY . "-" . A_MM . "-" . A_DD)
^!+d::Send(A_YYYY . "-" . A_MM . "-" . A_DD . ", " . A_DDDD)

