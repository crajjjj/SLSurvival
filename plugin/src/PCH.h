#pragma once

#include <RE/Skyrim.h>
#include <SKSE/SKSE.h>

// CommonLib v7 (REX) pulls real <Windows.h> into the include chain; scrub the
// macro collisions we actually hit (min/max are handled by NOMINMAX in xmake.lua)
#undef GetObject

#include <algorithm>
#include <cstdint>
#include <string_view>
#include <vector>

using namespace std::literals;

namespace logger = SKSE::log;
