#pragma once

namespace AliasFill
{
	// The actors a_quest's reference aliases would hold if the quest were started now,
	// one entry per alias in alias order (nullptr where nothing would fill). Only aliases
	// filled by conditions ("Find Matching Reference") are simulated; any other fill type
	// yields nullptr. Never empty: Papyrus receives an empty array as None.
	std::vector<RE::Actor*> Fill(RE::TESQuest* a_quest);
}
