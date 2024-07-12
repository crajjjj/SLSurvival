Scriptname SLIF_Language Hidden

;/
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return 
	elseIf (language == Czech)
		return 
	elseIf (language == Danish)
		return 
	elseIf (language == English)
		return 
	elseIf (language == Finnish)
		return 
	elseIf (language == French)
		return 
	elseIf (language == German)
		return 
	elseIf (language == Greek)
		return 
	elseIf (language == Italian)
		return 
	elseIf (language == Japanse)
		return 
	elseIf (language == Norwegian)
		return 
	elseIf (language == Polish)
		return 
	elseIf (language == Portuguese)
		return 
	elseIf (language == Russian)
		return 
	elseIf (language == Spanish)
		return 
	elseIf (language == Swedish)
		return 
	elseIf (language == Turkish)
		return 
	endIf
/;

string function GetPathByLanguage() global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "SexLab Inflation Framework/Language/Chinese.json"
	elseIf (language == Czech)
		return "SexLab Inflation Framework/Language/Czech.json"
	elseIf (language == Danish)
		return "SexLab Inflation Framework/Language/Danish.json"
	elseIf (language == English)
		return "SexLab Inflation Framework/Language/English.json"
	elseIf (language == Finnish)
		return "SexLab Inflation Framework/Language/Finnish.json"
	elseIf (language == French)
		return "SexLab Inflation Framework/Language/French.json"
	elseIf (language == German)
		return "SexLab Inflation Framework/Language/German.json"
	elseIf (language == Greek)
		return "SexLab Inflation Framework/Language/Greek.json"
	elseIf (language == Italian)
		return "SexLab Inflation Framework/Language/Italian.json"
	elseIf (language == Japanse)
		return "SexLab Inflation Framework/Language/Japanse.json"
	elseIf (language == Norwegian)
		return "SexLab Inflation Framework/Language/Norwegian.json"
	elseIf (language == Polish)
		return "SexLab Inflation Framework/Language/Polish.json"
	elseIf (language == Portuguese)
		return "SexLab Inflation Framework/Language/Portuguese.json"
	elseIf (language == Russian)
		return "SexLab Inflation Framework/Language/Russian.json"
	elseIf (language == Spanish)
		return "SexLab Inflation Framework/Language/Spanish.json"
	elseIf (language == Swedish)
		return "SexLab Inflation Framework/Language/Swedish.json"
	elseIf (language == Turkish)
		return "SexLab Inflation Framework/Language/Turkish.json"
	endIf
endFunction

string function GetText(string KeyName) global
	string result = JsonUtil.GetStringValue(GetPathByLanguage(), KeyName)
	Debug.Trace("SLIF DEBUG: " + result)
	return result
endFunction

string function GetTextR(string KeyName, string[] replacer) global
	string sKey = JsonUtil.GetStringValue(GetPathByLanguage(), KeyName)
	string[] split = StringUtil.Split(sKey, "{}")
	string result = ""
	int i = 0
	while(i < split.length)
		if (split[i] != "")
			result += split[i]
			if (i < replacer.length)
				if (replacer[i] != "")
					result += replacer[i]
				endIf
			endIf
		endIf
		i += 1
	endWhile
	if (result != "")
		Debug.Trace("SLIF DEBUG: " + result)
		return result
	endIf
	return sKey
endFunction

string function VersionUpdate(int version) global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 升级脚本到版本 " + version
	elseIf (language == Czech)
		return "[SLIF] Aktualizování skriptu na verzi " + version
	elseIf (language == Danish)
		return "[SLIF] Updating script to version " + version
	elseIf (language == English)
		return "[SLIF] Updating script to version " + version
	elseIf (language == Finnish)
		return "[SLIF] Updating script to version " + version
	elseIf (language == French)
		return "[SLIF] Mise à jour du script vers la version " + version
	elseIf (language == German)
		return "[SLIF] Script für Version " + version + " updaten"
	elseIf (language == Greek)
		return "[SLIF] Updating script to version " + version
	elseIf (language == Italian)
		return "[SLIF] Updating script to version " + version
	elseIf (language == Japanse)
		return "[SLIF] Updating script to version " + version
	elseIf (language == Norwegian)
		return "[SLIF] Updating script to version " + version
	elseIf (language == Polish)
		return "[SLIF] Updating script to version " + version
	elseIf (language == Portuguese)
		return "[SLIF] Updating script to version " + version
	elseIf (language == Russian)
		return "[SLIF] Обновление скриптов до версии " + version
	elseIf (language == Spanish)
		return "[SLIF] Actualizando el Script a la versión " + version
	elseIf (language == Swedish)
		return "[SLIF] Updating script to version " + version
	elseIf (language == Turkish)
		return "[SLIF] Updating script to version " + version
	endIf
endFunction

string function VersionUpdateDone() global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 升级完成!"
	elseIf (language == Czech)
		return "[SLIF] Aktualizace dokončena!"
	elseIf (language == Danish)
		return "[SLIF] Updating done!"
	elseIf (language == English)
		return "[SLIF] Updating done!"
	elseIf (language == Finnish)
		return "[SLIF] Updating done!"
	elseIf (language == French)
		return "[SLIF] Mise à jour effectuée!"
	elseIf (language == German)
		return "[SLIF] Update fertig!"
	elseIf (language == Greek)
		return "[SLIF] Updating done!"
	elseIf (language == Italian)
		return "[SLIF] Updating done!"
	elseIf (language == Japanse)
		return "[SLIF] Updating done!"
	elseIf (language == Norwegian)
		return "[SLIF] Updating done!"
	elseIf (language == Polish)
		return "[SLIF] Updating done!"
	elseIf (language == Portuguese)
		return "[SLIF] Updating done!"
	elseIf (language == Russian)
		return "[SLIF] Обновление завершено!"
	elseIf (language == Spanish)
		return "[SLIF] ¡Actualización completa!"
	elseIf (language == Swedish)
		return "[SLIF] Updating done!"
	elseIf (language == Turkish)
		return "[SLIF] Updating done!"
	endIf
endFunction

string function SetupStarted() global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 开始设置!"
	elseIf (language == Czech)
		return "[SLIF] Instalace započnuta!"
	elseIf (language == Danish)
		return "[SLIF] Setup started!"
	elseIf (language == English)
		return "[SLIF] Setup started!"
	elseIf (language == Finnish)
		return "[SLIF] Setup started!"
	elseIf (language == French)
		return "[SLIF] Installation commencée!"
	elseIf (language == German)
		return "[SLIF] Setup gestartet!"
	elseIf (language == Greek)
		return "[SLIF] Setup started!"
	elseIf (language == Italian)
		return "[SLIF] Setup started!"
	elseIf (language == Japanse)
		return "[SLIF] Setup started!"
	elseIf (language == Norwegian)
		return "[SLIF] Setup started!"
	elseIf (language == Polish)
		return "[SLIF] Setup started!"
	elseIf (language == Portuguese)
		return "[SLIF] Setup started!"
	elseIf (language == Russian)
		return "[SLIF] Установка начата!"
	elseIf (language == Spanish)
		return "[SLIF] ¡Iniciando instalación!"
	elseIf (language == Swedish)
		return "[SLIF] Setup started!"
	elseIf (language == Turkish)
		return "[SLIF] Setup started!"
	endIf
endFunction

string function SetupFinished() global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 设置完成!"
	elseIf (language == Czech)
		return "[SLIF] Instalace dokončena!"
	elseIf (language == Danish)
		return "[SLIF] Setup finished!"
	elseIf (language == English)
		return "[SLIF] Setup finished!"
	elseIf (language == Finnish)
		return "[SLIF] Setup finished!"
	elseIf (language == French)
		return "[SLIF] Installation terminée!"
	elseIf (language == German)
		return "[SLIF] Setup abgeschlossen!"
	elseIf (language == Greek)
		return "[SLIF] Setup finished!"
	elseIf (language == Italian)
		return "[SLIF] Setup finished!"
	elseIf (language == Japanse)
		return "[SLIF] Setup finished!"
	elseIf (language == Norwegian)
		return "[SLIF] Setup finished!"
	elseIf (language == Polish)
		return "[SLIF] Setup finished!"
	elseIf (language == Portuguese)
		return "[SLIF] Setup finished!"
	elseIf (language == Russian)
		return "[SLIF] Установка завершена!"
	elseIf (language == Spanish)
		return "[SLIF] ¡Instalación Completa!"
	elseIf (language == Swedish)
		return "[SLIF] Setup finished!"
	elseIf (language == Turkish)
		return "[SLIF] Setup finished!"
	endIf
endFunction

string function TargetAlreadyRegistered(String name) global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 目标 " + name + " 已被注册!"
	elseIf (language == Czech)
		return "[SLIF] Cíl " + name + " je už zaregistrovaný!"
	elseIf (language == Danish)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == English)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == Finnish)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == French)
		return "[SLIF] Cible " + name + " déjà inscrite!"
	elseIf (language == German)
		return "[SLIF] Ziel " + name + " wurde bereits registriert!"
	elseIf (language == Greek)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == Italian)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == Japanse)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == Norwegian)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == Polish)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == Portuguese)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == Russian)
		return "[SLIF] Цель " + name + " уже зарегистрирована!"
	elseIf (language == Spanish)
		return "[SLIF] ¡Objetivo " + name + " ya registrado!"
	elseIf (language == Swedish)
		return "[SLIF] Target " + name + " already registered!"
	elseIf (language == Turkish)
		return "[SLIF] Target " + name + " already registered!"
	endIf
endFunction

string function TargetRegisteredForSLIF(String name) global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 目标 " + name + " 已注册给SLIF!"
	elseIf (language == Czech)
		return "[SLIF] Cíl " + name + " registrován pro SLIF!"
	elseIf (language == Danish)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == English)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == Finnish)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == French)
		return "[SLIF] Cible " + name + " inscrite dans SLIF!"
	elseIf (language == German)
		return "[SLIF] Ziel " + name + " für SLIF registriert!"
	elseIf (language == Greek)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == Italian)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == Japanse)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == Norwegian)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == Polish)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == Portuguese)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == Russian)
		return "[SLIF] Цель " + name + " зарегистрирована в SLIF!"
	elseIf (language == Spanish)
		return "[SLIF] ¡Objetivo " + name + " registrado en SLIF!"
	elseIf (language == Swedish)
		return "[SLIF] Target " + name + " registered for SLIF!"
	elseIf (language == Turkish)
		return "[SLIF] Target " + name + " registered for SLIF!"
	endIf
endFunction

string function TargetNotValid() global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 目标无效!"
	elseIf (language == Czech)
		return "[SLIF] Cíl není platný!"
	elseIf (language == Danish)
		return "[SLIF] Target not valid!"
	elseIf (language == English)
		return "[SLIF] Target not valid!"
	elseIf (language == Finnish)
		return "[SLIF] Target not valid!"
	elseIf (language == French)
		return "[SLIF] Cible non valide!"
	elseIf (language == German)
		return "[SLIF] Ungültiges Ziel!"
	elseIf (language == Greek)
		return "[SLIF] Target not valid!"
	elseIf (language == Italian)
		return "[SLIF] Target not valid!"
	elseIf (language == Japanse)
		return "[SLIF] Target not valid!"
	elseIf (language == Norwegian)
		return "[SLIF] Target not valid!"
	elseIf (language == Polish)
		return "[SLIF] Target not valid!"
	elseIf (language == Portuguese)
		return "[SLIF] Target not valid!"
	elseIf (language == Russian)
		return "[SLIF] Цель неправильная!"
	elseIf (language == Spanish)
		return "[SLIF] ¡Objetivo no válido!"
	elseIf (language == Swedish)
		return "[SLIF] Target not valid!"
	elseIf (language == Turkish)
		return "[SLIF] Target not valid!"
	endIf
endFunction

string function NoTargetSelected() global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 目标选择: 没有目标被选中!"
	elseIf (language == Czech)
		return "[SLIF] Vybrání cíle: žádný cíl vybrán!"
	elseIf (language == Danish)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == English)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == Finnish)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == French)
		return "[SLIF] Sélection d'une cible: Pas de cible sélectionnée!"
	elseIf (language == German)
		return "[SLIF] Ziel auswählen: Kein Ziel ausgewählt!"
	elseIf (language == Greek)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == Italian)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == Japanse)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == Norwegian)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == Polish)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == Portuguese)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == Russian)
		return "[SLIF] Выбор цели: Цель не выбрана!"
	elseIf (language == Spanish)
		return "[SLIF] ¡Objetivo seleccionado: Ningún objetivo seleccionado!"
	elseIf (language == Swedish)
		return "[SLIF] Target Select: No target selected!"
	elseIf (language == Turkish)
		return "[SLIF] Target Select: No target selected!"
	endIf
endFunction

string function TargetRegistered(String name, String modName) global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 目标 " + name + " 被注册给 mod " + modName
	elseIf (language == Czech)
		return "[SLIF] Cíl " + name + " registrován pro mód " + modName
	elseIf (language == Danish)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == English)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == Finnish)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == French)
		return "[SLIF] Cible " + name + " inscrit pour mod " + modName
	elseIf (language == German)
		return "[SLIF] Ziel " + name + " registriert für mod " + modName
	elseIf (language == Greek)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == Italian)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == Japanse)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == Norwegian)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == Polish)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == Portuguese)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == Russian)
		return "[SLIF] Цель " + name + " зарегистрирована в моде " + modName
	elseIf (language == Spanish)
		return "[SLIF] Objetivo " + name + " registrado para el mod " + modName
	elseIf (language == Swedish)
		return "[SLIF] Target " + name + " registered for mod " + modName
	elseIf (language == Turkish)
		return "[SLIF] Target " + name + " registered for mod " + modName
	endIf
endFunction

string function TargetAddedToList(String name) global
	int Chinese    = 0
	int Czech      = 1
	int Danish     = 2
	int English    = 3
	int Finnish    = 4
	int French     = 5
	int German     = 6
	int Greek      = 7
	int Italian    = 8
	int Japanse    = 9
	int Norwegian  = 10
	int Polish     = 11
	int Portuguese = 12
	int Russian    = 13
	int Spanish    = 14
	int Swedish    = 15
	int Turkish    = 16
	
	int language = SLIF_Config.GetInt("language", 3)
	if (language == Chinese)
		return "[SLIF] 目标 " + name + " 加入列表!"
	elseIf (language == Czech)
		return "[SLIF] Cíl " + name + " přidán na list!"
	elseIf (language == Danish)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == English)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == Finnish)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == French)
		return "[SLIF] Cible " + name + " ajouté à la liste!"
	elseIf (language == German)
		return "[SLIF] Ziel " + name + " zur Liste hinzugefügt!"
	elseIf (language == Greek)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == Italian)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == Japanse)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == Norwegian)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == Polish)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == Portuguese)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == Russian)
		return "[SLIF] Цель " + name + " добавлена в список!"
	elseIf (language == Spanish)
		return "[SLIF] ¡Objetivo " + name + " añadido a la lista!"
	elseIf (language == Swedish)
		return "[SLIF] Target " + name + " added to the list!"
	elseIf (language == Turkish)
		return "[SLIF] Target " + name + " added to the list!"
	endIf
endFunction
