scriptname zadyokequestscript extends zadheavybondagequestscript conditional
scene property postrapescene auto
zaddreliableforcegreet property fg auto
referencealias property yokerescuer auto
miscobject property itemgold auto
message property zad_yokeremovelockedmsg auto ; "take it off", no key.
message property zad_yokeremoveunlockedmsg auto ; escaped via manipulated locks.
message property zad_yokeremoveunlockedfailmsg auto ; failed to escape manipulated locks.
message property zad_yokeremoveloosemsg auto ; removed the yoke.
message property zad_yokeremoveloosefailmsg auto ; fail to remove unlocked yoke.
message property zad_yokestrugglemsg auto ; base struggle message
message property zad_yokestruggleloosemsg auto ; realization that struggling is impossible message.
message property zad_yokestrugglekeymsg auto ; attempt to use key message.
message property zad_yokestrugglekeyloosemsg auto ; got the locks loose, move to removing the lock.
message property zad_yokeimpossiblestrugglemsg auto ; struggling disabled
perk property merchantcurse auto
spell property merchantcursespell auto
int property merchantcursegoldthreshold = 0 auto
int property merchantcursegoldowed  = 0 auto
int property merchantcursegoldstolen auto
bool property smithescapedialogueenabled = true auto conditional
function updateblacksmithremoval(bool enabledisable=true)
endfunction
bool function attemptremoveyoke()
endfunction
function dostruggle()
endfunction
function devicemenuremove()
endfunction
key function getkey()
endfunction
function devicemenupoststruggle()
endfunction
function devicemenuendurebonds()
endfunction
function devicemenuext(int msgchoice=0)
endfunction
function sexscene(objectreference akspeaker, bool aggressive)
endfunction
function consensualsex(objectreference akspeaker)
endfunction
function rapesex(objectreference akspeaker)
endfunction
function postrape(objectreference akspeaker)
endfunction
event startpostrape(string eventname, string argstring, float argnum, form sender)
endevent
function blacksmithremoveheavybondage(objectreference akspeaker)
endfunction
;This file was cleaned with PapyrusSourceHeadliner 1