Scriptname PNO_ConfigScript extends Quest

; Compile-time header for _SLS_IntPno only, never shipped: the real script is PNO's MCM (it extends
; SKI_ConfigBase). Only the members SLS reads, from PNO 1.10.5 and 1.11.0 (pno_configscript.psc).

Bool Property bladdertoggleVal Auto
Quest Property PNO_MainQuest Auto
