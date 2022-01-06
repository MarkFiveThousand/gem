#  ___________                           __________
# /\   _______\                         /\   ______\
# \ \  \______/_     ___   ____ ____ ___\ \  \_____/_     ___   ___ ___  ______    ___    ___
#  \ \  \ /\__  \  /'___`\/\   V    V   \\ \_______  \  /'   `\/\  \\  \/\   __\/' ._`\ /'___`\
#   \ \  \\/__\  \/\  ___/\ \  \/\  \/\  \\/_______\  \/\  \\  \ \  \\  \ \  \ /\  \__//\  ___/
#    \ \__________\ \____\ \ \__\ \__\ \__\ /\_________\ \_____/\ \______\ \__\\ \____/\ \____\
#     \/__________/\/____/  \/__/\/__/\/__/ \/_________/\/____/  \/______/\/__/ \/___/  \/____/

# =============================================================================
# Fedora 34 Installation Notes
#
# Configure Fedora for C++ Software Development
#
# =============================================================================



# =============================================================================
# Install C/C++ Development Tools from Fedora Repository
# =============================================================================

sudo dnf -y install kdiff3 *mercurial* npm
sudo dnf -y install python3-matplotlib cmake cmake-gui llvm clang mingw64-gcc mingw64-gcc-c++ mingw64-dlfcn-static git perl meson
sudo dnf -y groupinstall "Development Tools" "Development Libraries" "X Software Development" "C Development Tools and Libraries"
sudo dnf -y install mesa-libGLES-devel libXt-devel libXaw-devel
sudo dnf -y install 

# Noting here that I'm downloading the following files for SDL2.  Using the
# home built ones results in mouse annomolies on Fedrora and cross-compiling
# for mingw on Fedora, while the mingw version built on windows works fine.



# =============================================================================
# npm
#
# Node Package Manager
#
# https://nodejs.org/en/knowledge/getting-started/npm/what-is-npm/
# =============================================================================

sudo dnf -y install npm




# =============================================================================
# Install Python modules
# =============================================================================

pip3 install termcolor
pip3 install pylint


# ATTENTION REQUIRED!
#
# Your Python may have been installed in a different location depending on
# whether you installed it for all users or just yourself. Your Python
# installation may be found in one of the below locations:
#
# APPDATA:      The file-system directory that serves as a common repository for
#               application-specific data. A typical path is C:\Documents and
#               Settings\username\Application Data or
#               C:\Users\username\AppData\Roaming.
# 
# LOCALAPPDATA: The file-system directory that serves as a data repository for
#               local, non-roaming applications. A typical path is
#               C:\Users\username\AppData\Local.







# Source: https://pylint.pycqa.org/en/latest/user_guide/run.html
#
# Our .pylintrc configuration file is located under
# gem_fullpath_gem/local/config where it can be used for all.  If you would like
# to created your own, which is not necessary, use the following command:

Windows/DOS:
pylint --generate-rcfile > %gem_fullpath_gem%/local/config/.pylintrc
Linux/Msys/Cygwin:
pylint --generate-rcfile > ${gem_fullpath_gem}/local/config/.pylintrc


# =============================================================================
# Visual Studo Code
#
# Source: https://code.visualstudio.com/docs/setup/linux
# =============================================================================

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y check-update
sudo dnf -y install code

# Run VSCode.
#
# I have the following etension installed (as of 2021/10/1):
#
# Andromeda
#      Dark theme with a taste of the universe
#      Eliver Lara
#
# C/C++
#      C/C++ IntelliSense, debugging, and code browsing.
#      Microsoft
#
# CMake
#      CMake langage support for Visual Studio Code.
#      twxs
#
# Pretty Formatter
#      VS Code extension to format your code using Pretty Diff
#      mblode
#
# Rewrap
#      Hard word wrapping for comments and other text at a given column.
#      stkb
#
# BashDebug
#     A bash debugger GUI.
#
# Remote Development
#     An extension pack that lets you open any folder in a container, on a
#     remote machine, or in WSL.



# VSCode settings/preferences can be change via 2 methods:
# --------------------------------------------------------
# 1.) ctrl+, or File->preferences->Settings to open the settings menu.
# 2.) Edit the text file.  This is convenient for automating changes.
#
#     On Linux: $HOME/.config/Code/User/settings.json
#     On Windows: %APPDATA%\Code\User\settings.json



# Choose a color theme
# --------------------
# We're going to install the Andromeda color theme, or whatever your favorite
# theme is. I like the Andromeda theme (colorizer variation.)
#
# Open VSCode:
#
# Fedora->Programming->Visual Studio Code
#
# From the button bar on the left side, click the bottom Extensions icon with
# the squares. Search for "Andromeda".  Choose the Andromedra "Dark theme with
# a ..." by clicking on the green Install button.
#
# The Extension:Andromeda interface opens in VS Code.  On that screen click the
# blue Set Color Scheme button.
#
# Select the "Andromeda Colorizer" theme.
#
# Close the "Extension: Andromeda" windows by clicking the X at the top.
#
# Close the extension sidebar by clicking the Extensions icon on the left.




# Running VS Code as root (No action required)
# --------------------------------------------
# When running the VSCode as root we specify --user-data-dir.  Later, we'll
# appended settings to ${USER} and root's .bashrc file that specify to use a
# separate user data directory for root and ${USER}.  This is to prevent root
# from stomping on ${USER}'s data directory.
#
#
# *TODO: Next time verify the line below containing ${HOME} will work for both root and user.
#
# For root, we'll later set the following alias:
#
# alias code='/usr/bin/code --user-data-dir=/root/.config/Code/'
#
# For our user, we'll later set the following alias, using ${USER}=mhodges:
#
# alias code='/usr/bin/code --user-data-dir=${HOME}/.config/Code/'


# *FIX: This may no longer be necessary.  Skip for now.  We can perform this
# fix if needed, but hopefully will not be.
# -----------------------------------------------------------------------------
# From VSCode update:
#
# File watching in VS Code changed to a new library, thanks to the work of the
# Parcel team with their @parcel/watcher. We will gradually roll out this change
# to all users in the upcoming weeks. Linux users will be happy to learn that
# the files.watcherExclude now applies natively so that the number of file
# handles VS Code needs open for file watching can be greatly reduced.
#
# The existing files.legacyWatcher setting was changed to an enumeration with
# these values:
#
#   * on - The new file watcher will never be used.
#   * off - The new file watcher will always be used.
#   * default - The new file watcher will only be used when you open multi-root
#     workspaces (via a .code-workspace file).
#
# You should not notice any difference in your day to day work, but if file
# watching is broken for you, please report an issue.
# -----------------------------------------------------------------------------
# Fix the "Running out of update handle" problem by increasing the limit.
# -----------------------------------------------------------------------------
# Source: https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc

su

printf "\nfs.inotify.max_user_watches=524288\n" >> /etc/sysctl.conf

# Watching files takes up ~1K bytes per file.  A maximum of 524288 bytes will
# consume 512MB.  You can ignore entire directories that you don't need to be
# notified of changes.  To do so add paths to the files.watcherExclude setting:
#
# Press ctrl+, or File->preferences->Settings to open the settings menu.
#
# Search for:
#
# files.watcherExclude
#
# Then click Add Pattern.  You probably want to add your build directories
# here.
#
# Below are the ones I'm excluding.  Substitute your user name for <your user
# name>.   You'll need to update these as project directories change over time.


**/home/<your user name>/mnt/**     # Mine: **/home/mhodges/mnt/**

**/local/media/**
**/local/src/freeimage-3.18.0/build/**
**/local/src/freetype-2.10.1/build/**
**/local/src/ogre-1.12.4/build/**
**/local/src/pkgconf-1.6.3/build/**
**/local/src/pugixml-1.10/build/**
**/local/src/sdl2-2.0.11/build/**
**/local/src/zlib-1.2.11/build/**
**/local/src/zziplib-0.1.3/build/**



# =============================================================================
# Set TERM
# =============================================================================
# It seems we only set TERM when we open a urxvt terminal, but not for apps
# launched via the start menu.  VS Code's debug console will spew message and
# TERM not being set.

su

sed -i "s|Exec=/usr/share/code/code --unity-launch %F|Exec=env TERM=xterm-256color /usr/share/code/code --unity-launch %F|g" /usr/share/applications/code.desktop



# =============================================================================
# wclang for cross compiling for Windows (optional)
# =============================================================================
#
# ALERT!  As of 9/26/2021, enabling the repository fails.  Move onto the
# alternative option below.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# DEPRECATED: Download WCLang
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# clang is a tool to cross compile source code easily with clang on Linux/Unix
# for Windows.  Wclang is basically a wrapper for clang, which allows you to
# directly target Windows.  Wclang detects the target and headers automatically
# and adds them to the clang invocation command.  After the installation you
# will have "<mingw-triplet>-clang", "<mingw-triplet>-clang++" available as
# "compiler".

# Enable the repository.
sudo dnf -y copr enable mati865/wclang

# Install wclang.
sudo dnf -y install wclang

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# ALTERNATE: Build WCLang:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Source:  https://github.com/tpoechtrager/wclang
#
# Download from repository.
mkdir -p ${HOME}/gem/local/src
cd ${HOME}/gem/local/src
git clone https://github.com/tpoechtrager/wclang.git

# Build it.
cd ${HOME}/gem/local/src/wclang
cmake -DCMAKE_INSTALL_PREFIX=~/gem/local
make
make install
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



# =============================================================================
# NOTE: Skip this remaining two application ESLint.  Their installation
# instructions are under construction.
=============================================================================

# ESLint
# ------
# *FIX: Skip for now.  We need to figure out how to not go through making a new
# eslint.js (or whatever it's called) for every project. It seems we can create
# on once, put in in our home directory and have it work for all projects. We
# can install npm just fine, but "eslint --init".  See:
# https://github.com/eslint/eslint/issues/10618
#
# Here's what I had from the first time around.  In ${HOME}/www/eslint, I
# had the following file:

mkdir -p ~/www/eslint/
cat > ~/www/eslint/.eslintrc.json << EOF
{
    "env": {
        "browser": true,
        "es6": true
    },
    "extends": "eslint:recommended",
    "parserOptions": {
        "ecmaVersion": 2018
    },
    "rules": {
        "no-undef": 0,
        "no-unused-vars": 0,
        "indent": 0,
        "no-console": 0,
        "linebreak-style": [
            "error",
            "windows"
        ],
        "quotes": [
            "error",
            "double"
        ],
        "semi": [
            "error",
            "always"
        ]
    }
}
EOF

# It seems like others had luck running "eslint --init" ina temp directory,
# then just copying it to where they would like it.  This seems like a good
# avenue to persue.


# https://eslint.org/
# ESList checks javascript for correctness.

# IMPORTANT! The below steps result in .eslintrc.json being created in /root.
# Maybe we should run as user.  As this file is not accessible from typical
# user accounts, my expectation is that this will not work.  However, eslint
# does run from the command line.


# Must be run as root.
su

npm install eslint -g
exit    # back to user.

eslint --init

? How would you like to configure ESLint? Answer questions about your style
? Which version of ECMAScript do you use? ES2018
? Are you using ES6 modules? No
? Where will your code run? (Press <space> to select, <a> to toggle all, <i> to 
invert selection)Browser
? Do you use CommonJS? No
? Do you use JSX? No
? What style of indentation do you use? Tabs
? What quotes do you use for strings? Double
? What line endings do you use? Windows
? Do you require semicolons? Yes
? What format do you want your config file to be in? JSON
Local ESLint installation not found.
The config that you've selected requires the following dependencies:

eslint@latest
Successfully created .eslintrc.json file in /home/mhodges/www/homepage
ESLint was installed locally. We recommend using this local copy instead of your globally-installed copy.

# It's safe to ignore their recommendation.

# Set up eslint.
# Source: https://code.visualstudio.com/docs/languages/javascript

# In your projects .eslintrc.json add the following rules so it doesn't
# complain about global variables not being defined in the same file.  I think
# this goes just inside of the outer enclosing curly braces.
#
#        "no-undef": 0,
#        "no-unused-vars": 0
#
# 0- disable, 1- warn, 2- error






# =============================================================================
# Autostart
#
# *FIX: Skip, for now.  It needs to be updated for Fedora 30+.
#
# =============================================================================
# Set up apps to start automatically upon login.  The autostart desktop file
# gets run upon login.  It calls the ~/gem/local/sbin/gem_autostart script that
# launches the apps.

mkdir -p ~/.config/autostart

cat > ~/.config/autostart/gem_autostart.desktop << EOF
[Desktop Entry]
Name=gem_autostart
Exec=/home/mhodges/gem/local/sbin/gem_autostart
Terminal=true
Type=Application
EOF

# The following file should already be present as a part of the gem codebase.
cat > ~/gem/local/sbin/gem_autostart << EOF
sleep 5	# Give other start up processes a chance to do their thing.
pcmanfm &
urxvt &
#"/usr/share/code/code --unity-launch" &
"/usr/share/code/code" &
"/usr/bin/google-chrome-stable" &
EOF







# =============================================================================
# Install & Configure Oracle Java
# =============================================================================

# Download the JDK from here:
http://www.oracle.com/technetwork/java/javase/downloads/index.html


su

# Update the file name version accordingly:

gem_fullpath_rpm=/home/${USER}/Downloads/jdk-16.0.2_linux-x64_bin.rpm

# Install:
sudo rpm -ivh ${gem_fullpath_rpm}

# Update:
sudo rpm -Uvh ${gem_fullpath_rpm}



# Setup Alternatives:
# -------------------------------------
sudo alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java 200000
sudo alternatives --install /usr/bin/javaws javaws /usr/java/latest/jre/bin/javaws 200000
sudo alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/jre/lib/amd64/libnpjp2.so 200000
sudo alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
sudo alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 200000



# Choose Alternatives.  Switch from default to /usr/java/jdk-13/bin/javac.
# EXECUTE EACH OF THE FOLLOWING LINES, ONE AT A TIME:

sudo alternatives --config java
sudo alternatives --config javaws
sudo alternatives --config libjavaplugin.so.x86_64
sudo alternatives --config javac
sudo alternatives --config jar







# =============================================================================
# Download Gem
# =============================================================================

# By default, gem will be installed in your home directory under ~/gem.  If
# you'd like to change it, modify gem_fullpath_gem below.  However, portions of
# these instructions, in their current state, may not work if gem is installed
# elsewhere.

# NOTE: The clone operation will fail if you already have a gem directory.  If
# you do, you'll either need to rename your existing gem directory, or perform
# a "git pull" from within your gem directory to update it from github.
if [[ -d ${HOME}/gem ]]; then

	if [[ -d ${HOME}/gem_saved ]]; then
		echo "Unable to save a copy of the existing gem directory.  A directory named 'gem_saved' already exists."
	else
		mv ${HOME}/gem ${HOME}/gem_saved

		# If wclang is installed, move it
	fi
fi

gem_fullpath_gem_parent=${HOME}

cd ${gem_fullpath_gem_parent}

git clone https://github.com/MarkFiveThousand/gem.git


# Gem includes some preference settings that may vary bewteen users.  See
# ../gem/home/mhodges for an example of the kind of files you might want to
# include in the file tree.



# =============================================================================
# Initialize Git
#
# Git is a version control package installed on a public web server.  Pushing to
# and pulling from the Git server will be the primary means by which you and I
# share changes to our code.  It and other public version control servers called
# repositories host software projects, libraries and various other packages.
#
# These instructions detail configuring the Git application and downloading the
# Gem source code.  Our Gem project is hosted at
# https://github.com/MarkFiveThousand/gem.
#
# Resources:
#
#    Git Handbook:
#        https://www.git-tower.com/learn/git/ebook/en/command-line/remote-repositories/integrating-remote-changes#start
#
# =============================================================================


# The following commands must be executed in the gem directory.
cd ${gem_fullpath_gem_parent}/gem

# Identify yourself to Git by setting the my_email and my_name variables below
# to your information.

gem_user_name="First Last"
gem_user_email="your@email.address"

# I use the following:
# gem_user_name="Mark Hodges"
# gem_user_email="markhodges5000@gmail.com"

git config --global user.email ${gem_user_email}
git config --global user.name ${gem_user_name}

# Direct Git to our Gem repository.
git remote rm origin
git remote add origin git@github.com:MarkFiveThousand/gem
git config master.remote origin
git config master.merge refs/heads/master


# Should you wish to change your details later on, you can manually edit
# the ~/.gitconfig file for global settings, or edit .git/config to change
# settings on a particular repo. Most simply, you can run the above commands
# again with new details.



# -----------------------------------------------------------------------------
# Enable Write Access to Gem Repository (Not applicable to most people.)
#
# Source: https://www.git-tower.com/learn/git/ebook/en/command-line/advanced-topics/ssh-public-keys
# Source: https://stackoverflow.com/questions/749544/pipe-to-from-the-clipboard-in-bash-script
# -----------------------------------------------------------------------------
#
# Most of you will not require write access to the Gem repository.  You already
# have read access.  If you don't need to write to the Gem repository, you may
# skip this section.
#
# This will require cooperation with the Gem repository maintainer,
# markhodges5000@gmail.com.  That's me.
#
# Run the ssh-keygen command shown below, replacing "name@example.com" with
# your own email address.


ssh-keygen -t rsa -C "your@email.address"

# The following section is mostly quoted from the above link:
#
# With the "-t" flag, we demand an "RSA" type key, which is one of the newest
# and safest types. With the "-C" flag, we provide a comment which you can
# think of as a kind of description or label for this key. Using your email
# address, e.g., lets you identify it more easily later.
# After confirming this command, you'll be asked to:
#
# (1) Enter a name for this new key. Just hit RETURN to accept the default name
# and location.
#
# (2) Provide a passphrase. Although SSH public key authentication can be used
# safely without any password, you should nonetheless enter a strong passphrase
# to enhance security even further.
#
# Now, two files will have been created for you: "id_rsa.pub" (your public key)
# and "id_rsa" (your private key). If you're on a [Linux-based system], you'll
# find these in the ".ssh" folder inside your home directory (~/.ssh/).
#
# If you take a look at the actual contents of your public key file, you'll see
# something like this:

cat ~/.ssh/id_rsa.pub

# ssh-rsa AAAB3nZaC1aycAAEU+/ZdulUJoeuchOUU02/j18L7fo+ltQ0f322+Au/9yy9oaABBRCrH
# N/yo88BC0AB3nZaC1aycAAEU+/ZdulUJoeuchOUU02/j18L7fo+ltQ0f322AB3nZaC1aycAAEU+/Z
# dulUJoeuchOUU02/j18L7fo+ltQ0f322AB3nZaC1aycAAEU+/ZdulUJoeuchOUU02/j18L7fo+ltQ
# 0f322AB3nZaC1aycAAEU+/ZdulUJoeuchOUU02/j18L7fo+ltQ0f322klCi0/aEBBc02N+JJP you
# r@email.address
#
# It's this output that needs to be installed on the Git GitHub server you want
# to get access to. You'll have to provide this to the Git maintainer,
# markhodges5000@gmail.com.
#
# You have to copy the content of the public key file exactly as it is - no
# whitespace or the like is accepted. To make this as safe and easy as
# possible, you can use the following commands to have this copied to your
# clipboard:

# The public key will be stored at ~/.ssh/id_rsa.pub.

function gem_copy_id_rsa_pub()
{
    # Change if needed.
    gem_fullpath_id_rsa_pub=~/.ssh/id_rsa.pub

    if [[ ! -f ${gem_fullpath_id_rsa_pub} ]]; then
        echo "ERROR: Public key does not exist: ${gem_fullpath_id_rsa_pub}."; return
    fi
    gem_os=$(uname -s)
    if [[ ${gem_os} == "MINGW64"* ]]; then
        gem_fullpath_clip_exe=/c/Windows/System32/clip
    elif [[ ${gem_os} == "CYGWIN"* ]]; then
        gem_fullpath_clip_exe=/cygdrive/c/Windows/System32/clip
    elif [[ ${gem_os} == "Linux" ]]; then
        gem_fullpath_clip_exe="$(which xclip)"
        gem_clip_params="-selection c"
    else
        echo "ERROR: Failed to recognise os: ${gem_os}."; return
    fi
    if [[ ! -f ${gem_fullpath_clip_exe} ]]; then
        echo "ERROR: Failed to locate executable: ${gem_fullpath_clip_exe}."; return
    fi
    cat ${gem_fullpath_id_rsa_pub} | ${gem_fullpath_clip_exe} ${gem_clip_params}
}
gem_copy_id_rsa_pub


# Finally, paste the contents of the clipboard (ctrl-alt-v) into the body of an
# email to the Git maintainer, markhodges5000@gmail.com.
#
# Wait for the Git maintainer to add your key to the repository, thereby
# allowing you to perform push operations.
#
# IMPORTANT!  Leave yourself a sticky note: When you have write access come
# back and do this, or else your won't be able to push or pull from the repo.:


cd ~/gem

# Add upstream (tracking) reference, used by argument-less git-pull and other
# commands.  It tells git fetch/git pull which branch to merge.

git branch --set-upstream-to=origin/master master






# =============================================================================
# Update .bashrc to Run Scripts Initializing the Gem Development Environment
#
# The file .bashrc located in ${HOME}/ is a shell script that gets run each
# time the user logs into a shell.  We're going to insert commands to
# initialize the shell for our Gem development environment.
#
# Scripts that personalize the shell environment are located in
# ~/gem/home/mhodges/ and sibling directories per user.
# =============================================================================

# Remove temporary gem_colors() function from ~/.bashrc:
sed -i "/function gem_colors()/,/gem_colors  # Call it./d" ~/.bashrc

# The user_bash_init script performs tasks to set up the user's environment.
# This includes mounting network drives, declaring the location of the Android
# SDK, defining shell aliases, and configuring the environment for various
# installed packages.

# Copy mhodges' user_bash_init file as our own for a starter.
if [[ $(whoami) != "root" ]]; then

    gem_fullpath_user_sbin=~/gem/home/${USER}/local/sbin/

	# Create a directory under gem for our personal settings:
    mkdir -p ${gem_fullpath_user_sbin}

	# Copy user mhodges' environment settings
    cp ~/gem/home/mhodges/local/sbin/user_bash_init ${gem_fullpath_user_sbin}
fi


# Add calls to gem's bash scripts to ~/.bashrc to prepare the environment.
#
# *FIX: The command below is producing "-bash: y: command not found", but
# otherwise works.

y | cp ~/.bashrc ~/.bashrc.bak
cat << EOF >> ~/.bashrc

# Source our definitions.  NOTE: When running as root ${USER}'s gem installation
# will be referenced.
if [[ ${USER} != "root" ]]; then
    gem_fullpath_gem_bash_init=${HOME}/gem/local/sbin/gem_bash_init
    gem_fullpath_user_bash_init=${HOME}/gem/home/${USER}/local/sbin/user_bash_init

    if [[ -f \${gem_fullpath_gem_bash_init} ]]; then
        source \${gem_fullpath_gem_bash_init}
        if [[ -f \${gem_fullpath_user_bash_init} ]]; then
            source \${gem_fullpath_user_bash_init}
        else
            echo "\$BASH_SOURCE(\${LINENO}) WARNING: \${gem_fullpath_user_bash_init} not found."
        fi
    else
        echo "\$BASH_SOURCE(\${LINENO}) WARNING: \${gem_fullpath_gem_bash_init} not found."
    fi
fi
EOF


# IMPORTANT!  If you initialized the color prompt earlier for root, you should
# repeat the above steps as root.

# Note: You must use "su -", not just "su":

su -



# =============================================================================
# Did You Remember to Do This?
# =============================================================================
# 1.) After receiving confirmation that the Gem github administrator has
#     provided you with write access to the Gem repository, you must execute
#     the "git push ..." command described earlier, or else you won't be able
#     to write to the github repository.




# =============================================================================
# Build the Gem Libraries
# =============================================================================

# Build each of the Gem libraries.
cd ${gem_fullpath_gem}/local/src


# Build zlib
# ----------
cd zlib-1.2.11
./gem_build_zlib -d -m -b -i
cd ..


# Build ZZipLib
# -------------
cd zziplib-0.1.3
./gem_build_zziplib -d -m -b -i
cd ..


# Build SDL
# ---------
cd 
./gem_build_sdl2 -d -m -b -i
cd ..


# Build Ogre
# ----------
cd 
./gem_build_ogre -d -m -b -i
cd ..


