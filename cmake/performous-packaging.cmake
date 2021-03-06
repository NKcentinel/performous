set(CPACK_PACKAGE_NAME "${CMAKE_PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "A karaoke, band and dancing game where one or more players perform a song and the game scores their performances. Supports songs in UltraStar, Frets on Fire and StepMania formats. Microphones and instruments from SingStar, Guitar Hero and Rock Band as well as some dance pads are autodetected.")
set(CPACK_PACKAGE_CONTACT "http://performous.org/")
set(CPACK_SOURCE_IGNORE_FILES
   "/.cvsignore"
   "/.gitignore"
   "/songs/"
   "/build/"
   "/.svn/"
   "/.git/"
)
set(CPACK_PACKAGE_EXECUTABLES performous)
set(CPACK_SOURCE_GENERATOR "TBZ2")
set(CPACK_GENERATOR "TBZ2")

if("${CMAKE_BUILD_TYPE}" MATCHES "Release")
	set(CPACK_STRIP_FILES TRUE)
endif("${CMAKE_BUILD_TYPE}" MATCHES "Release")

if(APPLE)
	set(CPACK_GENERATOR "PACKAGEMAKER;OSXX11")
endif(APPLE)
if(UNIX)
	# Try to find architecture
	execute_process(COMMAND uname -m OUTPUT_VARIABLE CPACK_PACKAGE_ARCHITECTURE)
	string(STRIP "${CPACK_PACKAGE_ARCHITECTURE}" CPACK_PACKAGE_ARCHITECTURE)
	# Try to find distro name and distro-specific arch
	execute_process(COMMAND lsb_release -is OUTPUT_VARIABLE LSB_ID)
	execute_process(COMMAND lsb_release -rs OUTPUT_VARIABLE LSB_RELEASE)
	string(STRIP "${LSB_ID}" LSB_ID)
	string(STRIP "${LSB_RELEASE}" LSB_RELEASE)
	set(LSB_DISTRIB "${LSB_ID}${LSB_RELEASE}")
	if(NOT LSB_DISTRIB)
		set(LSB_DISTRIB "unix")
	endif(NOT LSB_DISTRIB)
	# For Debian-based distros we want to create DEB packages.
	if("${LSB_DISTRIB}" MATCHES "Ubuntu|Debian")
		set(CPACK_GENERATOR "DEB")
		set(CPACK_DEBIAN_PACKAGE_PRIORITY "extra")
		set(CPACK_DEBIAN_PACKAGE_SECTION "universe/games")
		set(CPACK_DEBIAN_PACKAGE_RECOMMENDS "ultrastar-songs, ultrastar-songs-restricted, ttf-mscorefonts-installer")
		# We need to alter the architecture names as per distro rules
		if("${CPACK_PACKAGE_ARCHITECTURE}" MATCHES "i[3-6]86")
			set(CPACK_PACKAGE_ARCHITECTURE i386)
		endif("${CPACK_PACKAGE_ARCHITECTURE}" MATCHES "i[3-6]86")
		if("${CPACK_PACKAGE_ARCHITECTURE}" MATCHES "x86_64")
			set(CPACK_PACKAGE_ARCHITECTURE amd64)
		endif("${CPACK_PACKAGE_ARCHITECTURE}" MATCHES "x86_64")

		# Set the dependencies based on the distro version

		# Ubuntu
		if("${LSB_DISTRIB}" MATCHES "Ubuntu9.10")
			set(CPACK_DEBIAN_PACKAGE_DEPENDS "libsdl1.2debian, libcairo2, librsvg2-2, libboost-thread1.38.0, libboost-program-options1.38.0, libboost-regex1.38.0, libboost-filesystem1.38.0, libboost-date-time1.38.0, libavcodec52, libavformat52, libswscale0, libmagick++2, libxml++2.6-2, libglew1.5, libpng12-0, libjpeg62")
		endif("${LSB_DISTRIB}" MATCHES "Ubuntu9.10")

		if("${LSB_DISTRIB}" MATCHES "Ubuntu10.04")
			set(CPACK_DEBIAN_PACKAGE_DEPENDS "libsdl1.2debian, libcairo2, librsvg2-2, libboost-thread1.40.0, libboost-program-options1.40.0, libboost-regex1.40.0, libboost-filesystem1.40.0, libboost-date-time1.40.0, libavcodec52|libavcodec-extra-52, libavformat52|libavformat-extra-52, libswscale0, libmagick++2, libxml++2.6-2, libglew1.5, libpng12-0, libjpeg62, libportmidi0, libcv4, libhighgui4")
		endif("${LSB_DISTRIB}" MATCHES "Ubuntu10.04")

		if("${LSB_DISTRIB}" MATCHES "Ubuntu10.10")
			set(CPACK_DEBIAN_PACKAGE_DEPENDS "libsdl1.2debian, libcairo2, librsvg2-2, libboost-thread1.42.0, libboost-program-options1.42.0, libboost-regex1.42.0, libboost-filesystem1.42.0, libboost-date-time1.42.0, libavcodec52|libavcodec-extra-52, libavformat52|libavformat-extra-52, libswscale0, libmagick++2, libxml++2.6-2, libglew1.5, libpng12-0, libjpeg62, libportmidi0, libcv2.1, libhighgui2.1")
		endif("${LSB_DISTRIB}" MATCHES "Ubuntu10.10")

		if("${LSB_DISTRIB}" MATCHES "Ubuntu11.04")
			set(CPACK_DEBIAN_PACKAGE_DEPENDS "libavcodec52|libavcodec-extra-52, libavformat52|libavformat-extra-52, libavutil50|libavutil-extra-50, libboost-filesystem1.42.0, libboost-program-options1.42.0, libboost-regex1.42.0, libboost-system1.42.0, libboost-thread1.42.0, libc6, libcairo2, libfreetype6, libgcc1, libgdk-pixbuf2.0-0, libgl1-mesa-glx|libgl1, libglew1.5, libglib2.0-0, libglibmm-2.4-1c2a, libglu1-mesa|libglu1, libjpeg62, libpango1.0-0, libpng12-0, libportaudio2, librsvg2-2, libsdl1.2debian, libsigc++-2.0-0c2a, libstdc++6, libswscale0|libswscale-extra-0, libxml++2.6-2, libxml2, zlib1g")
		endif("${LSB_DISTRIB}" MATCHES "Ubuntu11.04")

		if("${LSB_DISTRIB}" MATCHES "Ubuntu11.10")
			set(CPACK_DEBIAN_PACKAGE_DEPENDS "libavcodec53|libavcodec-extra-53, libavformat53|libavformat-extra-53, libavutil51|libavutil-extra-51, libboost-filesystem1.46.1, libboost-program-options1.46.1, libboost-regex1.46.1, libboost-system1.46.1, libboost-thread1.46.1, libc6, libcairo2, libgcc1, libgdk-pixbuf2.0-0, libgl1-mesa-glx|libgl1, libglew1.5, libglib2.0-0, libglibmm-2.4-1c2a, libglu1-mesa|libglu1, libjpeg62, libpango1.0-0, libpng12-0, libportaudio2, librsvg2-2, libsdl1.2debian, libstdc++6, libswscale2|libswscale-extra-2, libxml++2.6-2")
		endif("${LSB_DISTRIB}" MATCHES "Ubuntu11.10")

		# Debian
		if("${LSB_DISTRIB}" MATCHES "Debian5.*")
			set(CPACK_DEBIAN_PACKAGE_DEPENDS "libsdl1.2debian, libcairo2, librsvg2-2, libboost-thread1.42.0, libboost-program-options1.42.0, libboost-regex1.42.0, libboost-filesystem1.42.0, libboost-date-time1.42.0, libavcodec51, libavformat52, libswscale0, libmagick++10, libxml++2.6-2, libglew1.5, libpng12-0, libjpeg62, libportmidi0, libcv2.1, libhighgui2.1")
		endif("${LSB_DISTRIB}" MATCHES "Debian5.*")

		if("${LSB_DISTRIB}" MATCHES "Debiantesting")
                        set(CPACK_DEBIAN_PACKAGE_DEPENDS "libsdl1.2debian, libcairo2, librsvg2-2, libboost-thread1.46.1, libboost-program-options1.46.1, libboost-regex1.46.1, libboost-filesystem1.46.1, libboost-date-time1.46.1, libavcodec52, libavformat52, libswscale0, libmagick++3, libxml++2.6-2, libglew1.5, libpng12-0, libjpeg62, libportmidi0, libcv2.1, libhighgui2.1")
                endif("${LSB_DISTRIB}" MATCHES "Debiantesting")

		if(NOT CPACK_DEBIAN_PACKAGE_DEPENDS)
			message("WARNING: ${LSB_DISTRIB} not supported yet.\nPlease set deps in cmake/performous-packaging.cmake before packaging.")
		endif(NOT CPACK_DEBIAN_PACKAGE_DEPENDS)
		string(TOLOWER "${CPACK_PACKAGE_NAME}_${CPACK_PACKAGE_VERSION}-${LSB_DISTRIB}_${CPACK_PACKAGE_ARCHITECTURE}" CPACK_PACKAGE_FILE_NAME)
	endif("${LSB_DISTRIB}" MATCHES "Ubuntu|Debian")
	# For Fedora-based distros we want to create RPM packages.
	if("${LSB_DISTRIB}" MATCHES "Fedora")
		set(CPACK_GENERATOR "RPM")
		set(CPACK_RPM_PACKAGE_NAME "${CMAKE_PROJECT_NAME}")
		set(CPACK_RPM_PACKAGE_VERSION "${PROJECT_VERSION}")
		set(CPACK_RPM_PACKAGE_RELEASE "1")
		set(CPACK_RPM_PACKAGE_GROUP "Amusements/Games")
		set(CPACK_RPM_PACKAGE_LICENSE "GPLv3+")
		set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "A karaoke, band and dancing game")
		set(CPACK_RPM_PACKAGE_DESCRIPTION "Performous is a karaoke, band and dancing game where one or more players perform a song and the game scores their performances. Supports songs in UltraStar, Frets on Fire and StepMania formats. Microphones and instruments from SingStar, Guitar Hero and Rock Band as well as some dance pads are autodetected.")
		# We need to alter the architecture names as per distro rules
		if("${CPACK_PACKAGE_ARCHITECTURE}" MATCHES "i[3-6]86")
			set(CPACK_PACKAGE_ARCHITECTURE i386)
		endif("${CPACK_PACKAGE_ARCHITECTURE}" MATCHES "i[3-6]86")
		if("${CPACK_PACKAGE_ARCHITECTURE}" MATCHES "x86_64")
			set(CPACK_PACKAGE_ARCHITECTURE amd64)
		endif("${CPACK_PACKAGE_ARCHITECTURE}" MATCHES "x86_64")
		# Set the dependencies based on the distro version
		if("${LSB_DISTRIB}" MATCHES "Fedora15")
			set(CPACK_RPM_PACKAGE_REQUIRES "gettext, gtk2, cairo, librsvg2, libsigc++20, glibmm24, libxml++, ImageMagick-c++, boost, SDL, glew, ffmpeg, pulseaudio-libs, portaudio, opencv, portmidi")
		endif("${LSB_DISTRIB}" MATCHES "Fedora15")
		if("${LSB_DISTRIB}" MATCHES "Fedora14")
			set(CPACK_RPM_PACKAGE_REQUIRES "gettext, gtk2, cairo, librsvg2, libsigc++20, glibmm24, libxml++, ImageMagick-c++, boost, SDL, glew, ffmpeg, pulseaudio-libs, portaudio, opencv, portmidi")
		endif("${LSB_DISTRIB}" MATCHES "Fedora14")
		if("${LSB_DISTRIB}" MATCHES "Fedora13")
			set(CPACK_RPM_PACKAGE_REQUIRES "gettext, gtk2, cairo, librsvg2, libsigc++20, glibmm24, libxml++, ImageMagick-c++, boost, SDL, glew, ffmpeg, pulseaudio-libs, portaudio, opencv, portmidi")
		endif("${LSB_DISTRIB}" MATCHES "Fedora13")
		if(NOT CPACK_RPM_PACKAGE_REQUIRES)
			message("WARNING: ${LSB_DISTRIB} is not supported.\nPlease set deps in cmake/performous-packaging.cmake before packaging.")
		endif(NOT CPACK_RPM_PACKAGE_REQUIRES)
	endif("${LSB_DISTRIB}" MATCHES "Fedora")
	set(CPACK_SYSTEM_NAME "${LSB_DISTRIB}-${CPACK_PACKAGE_ARCHITECTURE}")
	message(STATUS "Detected ${CPACK_SYSTEM_NAME}. Use make package to build packages (${CPACK_GENERATOR}).")
endif(UNIX)

if(WIN32)
  set(CPACK_GENERATOR "NSIS")
  set(CPACK_PACKAGE_EXECUTABLES "performous" "Performous - game")#executable file - display name to menu programs
  set(CPACK_PACKAGE_INSTALL_DIRECTORY "${CMAKE_PROJECT_NAME}")
  # There is a bug in NSI that does not handle full unix paths properly. Make
  # sure there is at least one set of four (4) backlasshes.
  SET(CPACK_PACKAGE_ICON "${CMAKE_CURRENT_SOURCE_DIR}/themes/default\\\\icon.bmp")
  SET(CPACK_NSIS_MUI_ICON "${CMAKE_CURRENT_SOURCE_DIR}/themes/default\\\\icon.ico")
  SET(CPACK_NSIS_INSTALLED_ICON_NAME "bin\\\\${CMAKE_PROJECT_NAME}.exe")
  SET(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY} Performous!")
  SET(CPACK_NSIS_HELP_LINK "http:\\\\\\\\performous.org")
  SET(CPACK_NSIS_URL_INFO_ABOUT "http:\\\\\\\\performous.org")
  SET(CPACK_NSIS_MODIFY_PATH OFF)

endif(WIN32)

include(CPack)

