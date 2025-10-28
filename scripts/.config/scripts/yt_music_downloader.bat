@echo off
ECHO --------------------------------------
ECHO      YouTube Audio Downloader
ECHO Optimized for singles and albums
ECHO --------------------------------------

SETLOCAL ENABLEDELAYEDEXPANSION

REM --- Get URL ---
IF "%~1"=="" (
    SET /P "URL=Enter YouTube song or album URL: "
) ELSE (
    SET "URL=%~1"
)

REM --- Validate URL ---
ECHO %URL% | findstr /B /R "^https://" >nul
IF ERRORLEVEL 1 (
    ECHO Invalid URL. Must start with https://
    EXIT /B 1
)

REM --- Convert music.youtube.com to youtube.com ---
IF NOT "%URL:music.youtube.com=%"=="%URL%" (
    ECHO Detected YouTube Music URL, converting to normal YouTube URL...
    SET "URL=!URL:music.youtube.com=www.youtube.com!"
)

REM --- Get output folder ---
IF "%~2"=="" (
    SET /P "OUTPUT_DIR=Enter output folder (leave empty for %CD%\yt_playlist): "
    IF "%OUTPUT_DIR%"=="" SET "OUTPUT_DIR=%CD%\yt_playlist"
) ELSE (
    SET "OUTPUT_DIR=%~2"
)

REM --- Create output directory if missing ---
IF NOT EXIST "%OUTPUT_DIR%" (
    MKDIR "%OUTPUT_DIR%"
)

ECHO.
ECHO Fetching song/album info...
yt-dlp --flat-playlist --print "%%(title)s - %%(uploader)s - %%(id)s" "%URL%" > "%OUTPUT_DIR%\playlist.txt" 2>nul

IF %ERRORLEVEL% NEQ 0 (
    ECHO Failed to fetch info. Check the URL.
    EXIT /B 1
)

ECHO Info saved to "%OUTPUT_DIR%\playlist.txt"
ECHO.

REM --- Download audio only (Opus preferred) ---
ECHO Downloading audio in Opus format...
yt-dlp -o "%OUTPUT_DIR%\%%(title)s.%%(ext)s" -f "bestaudio[ext=opus]/bestaudio" --extract-audio --audio-format opus --audio-quality 0 "%URL%"

IF %ERRORLEVEL% EQU 0 (
    ECHO.
    ECHO Done! Files saved in "%OUTPUT_DIR%"
) ELSE (
    ECHO.
    ECHO Some files may have failed. Check yt-dlp output.
)

PAUSE

