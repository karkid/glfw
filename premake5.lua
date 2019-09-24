project "GLFW"
    kind "StaticLib"
    language "C"
    systemversion "latest"
    staticruntime "On"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    defines { "_CRT_SECURE_NO_WARNINGS" }

    files
    {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/glfw_config.h.in",
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/vulkan.c",
        "src/window.c"
    }

    --Visual Studio IDE specific setting for Window system
    filter "system:windows"
        defines { "_GLFW_WIN32" }
        files
        {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wgl_context.c",
            "src/egl_context.c",
            "src/osmesa_context.c"
        }

    --XCode IDE specific setting for Mac system
    filter "system:macosx"
        defines { "_GLFW_COCOA" }
        buildoptions
        {
            "-std=c11",
            "-framework Cocoa",
            "-framework IOKit",
            "-framework CoreFoundation",
            "-framework CoreVideo",
        }

        files
        {
            "src/cocoa_init.m",
            "src/cocoa_joystick.m",
            "src/cocoa_monitor.m",
            "src/cocoa_time.c",
            "src/posix_thread.c",
            "src/cocoa_window.m",
            "src/osmesa_context.c",
            "src/egl_context.c",
            "src/nsgl_context.m"
        }

    --Configuration specific settings for all system
    filter "configurations:Debug"
        symbols "on"
        runtime "Debug"

    filter "configurations:Release"
        optimize "on"
        runtime "Release"
