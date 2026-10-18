set_xmakever("3.0.0")  -- the commonlibsse-ng submodule requires 3.0

-- SLSurvival.dll: native code for SL Survival's heaviest Papyrus paths. SL Survival runs
-- without it: every caller checks _SLS_Native.IsLoaded() and keeps its Papyrus path.
-- Build through plugin\build.ps1, which stamps the mod version from fomod\info.xml; a
-- bare `xmake` here builds a 0.0.0 DLL that _SLS_Native.IsLoaded() treats as absent.

PROJECT_NAME = "SLSurvival"
PROJECT_AUTHOR = "crajjjj"

-- SL Survival versions are X.YYY; build.ps1 passes them in as X.(YYY / 100).(YYY % 100),
-- because a packed SKSE plugin version has 8 bits for the minor number (0.800 -> 0.8.0).
option("sls_version")
    set_default("0.0.0")
    set_showmenu(true)
    set_description("Plugin version stamped into the DLL (from fomod\\info.xml, via build.ps1)")
option_end()

set_version(get_config("sls_version") or "0.0.0")
set_languages("cxx23")
set_license("gplv3")
set_warnings("allextra")

includes("lib/commonlibsse-ng")
set_project(PROJECT_NAME)  -- after the include: the library names the project too, and the last one wins

add_rules("mode.debug", "mode.release")

if is_mode("debug") then
    add_defines("DEBUG")
    set_optimize("none")
    set_runtimes("MTd")
elseif is_mode("release") then
    add_defines("NDEBUG")
    set_optimize("fastest")
    set_symbols("debug")
    set_runtimes("MT")
end

add_defines("NOMINMAX")  -- CommonLib v7 headers pull in Windows.h

target(PROJECT_NAME)
    set_kind("shared")
    add_deps("commonlibsse-ng")
    add_rules("commonlibsse-ng.plugin", {
        name = PROJECT_NAME,
        author = PROJECT_AUTHOR,
        description = "Native helpers for SL Survival (guard searches, licence contraband scans)."
    })
    add_files("src/**.cpp")
    add_headerfiles("src/**.h")
    add_includedirs("src")
    set_pcxxheader("src/PCH.h")

    add_cxxflags(
        "cl::/diagnostics:caret",
        "cl::/wd4200",
        "cl::/wd4201",
        "cl::/Zc:preprocessor",
        "cl::/utf-8"
    )
    if is_mode("debug") then
        add_cxxflags("cl::/bigobj")
    end

    -- NEVER install. The commonlib plugin rule runs `xmake install` after every build
    -- and, with XSE_TES5_MODS_PATH set, aims it at <mods>\<target name>: a stray
    -- "SLSurvival" folder in the live Mod Organizer mods directory.
    on_config(function (target)        -- runs after the rule's on_config
        target:set("installdir", path.join(os.projectdir(), "build", "install"))
    end)
    on_install(function (target) end)  -- a target-level on_install replaces the rule's

    after_build(function (target)
        -- the DLL only, into the mod's own SKSE\Plugins (shipped by the FOMOD and the ppj zip)
        local out = path.join(os.projectdir(), "..", "SKSE", "Plugins")
        os.cp(target:targetfile(), out)
    end)
target_end()
