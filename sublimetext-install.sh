#!/bin/bash

#############################################################################
#                                                                           #
#  sublimetext-install.sh - Install/uninstall Sublime Text on Linux         #
#  Copyright (C) 2014 Christian Heinrichs <christian.heinrichs@mykolab.ch>  #
#                                                                           #
#  This program is free software: you can redistribute it and/or modify     #
#  it under the terms of the GNU General Public License as published by     #
#  the Free Software Foundation, either version 3 of the License, or        #
#  (at your option) any later version.                                      #
#                                                                           #
#  This program is distributed in the hope that it will be useful,          #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of           #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
#  GNU General Public License for more details.                             #
#                                                                           #
#  You should have received a copy of the GNU General Public License        #
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.    #
#                                                                           #
#############################################################################

# Disclaimer: I cannot be held responsible for any system damage or data loss.
# Use this script at your own risk!

# sublimetext-install.sh written by Christian Heinrichs
# Last modified on 14 January 2022

# This script is based on the Sublime Text 2 documentation at:
# https://sublime-text-unofficial-documentation.readthedocs.io/en/sublime-text-2/getting_started/install.html
#
# For the Sublime Text 3 part I referred to:
# http://docs.sublimetext.info/en/latest/getting_started/install.html
#
# I know there are many other similar scripts on GitHub Gists, but feel free to
# choose any script you like for installing Sublime Text.
# sublimetext-install.sh has been tested on Arch Linux 64-bit, Lubuntu 13.04
# 32-bit and Ubuntu 12.04 64-bit

read -p "Do you want to install/uninstall Sublime Text 2 or Sublime Text 3? Please enter either st2 or st3. " versiondecision

# Sublime Text 2 installation/uninstallation dialog
if [[ $versiondecision == "st2" || $versiondecision == "ST2" ]]
    then

        read -p "Do you want to [i]nstall or [u]ninstall Sublime Text 2? " installdecision

        if [[ $installdecision == "i" || $installdecision == "I" ]]
            then
                read -p "Do you have a [i386] or [x64] system architecture? " archdecision

                if [ $archdecision == "i386" ]
                    then
                        # Download the .tar archive
                        printf "Downloading Sublime Text 2 for i386 system.\n"
                        wget https://download.sublimetext.com/Sublime\ Text\ 2.0.2.tar.bz2
                        # Extract the .tar archive
                        tar -jvxf "Sublime Text 2.0.2.tar.bz2"
                        # Move the extracted folder to /opt/
                        printf "Moving Sublime Text 2 folder to /opt/\n"
                        sudo mv Sublime\ Text\ 2 /opt/
                        # Create the symlink /usr/bin/sublime linked to
                        # ???/opt/Sublime Text 2???
                        printf "Creating Sublime Text 2 symlink\n"
                        sudo ln -s /opt/Sublime\ Text\ 2/sublime_text /usr/bin/sublime
                        # Write the sublime.desktop configuration file
                        printf "Writing sublime.desktop file\n"
                        # Thanks to grawity for solving the sudo cat redirection
                        # problem here:
                        # https://superuser.com/questions/340074/bash-permission-denied-issue-when-trying-to-append-to-eof/340083#340083
                        sudo bash -c 'cat >> /usr/share/applications/sublime.desktop' <<EOF
[Desktop Entry]
Version=2.0.2
Name=Sublime Text 2
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Text Editor

Exec=sublime
Terminal=false
Icon=/opt/Sublime Text 2/Icon/48x48/sublime_text.png
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n
TargetEnvironment=Unity
EOF
                elif [ $archdecision == "x64" ]
                    then
                        # Download the .tar archive
                        printf "Downloading Sublime Text 2 for x64 system.\n"
                        wget https://download.sublimetext.com/Sublime\ Text\ 2.0.2\ x64.tar.bz2
                        # Extract the .tar archive
                        tar -jvxf "Sublime Text 2.0.2 x64.tar.bz2"
                        # Move the extracted folder to /opt/
                        printf "Moving Sublime Text 2 folder to /opt/\n"
                        sudo mv Sublime\ Text\ 2 /opt/
                        # Create the symlink /usr/bin/sublime linked to
                        # ???/opt/Sublime Text 2???
                        printf "Creating Sublime Text 2 symlink\n"
                        sudo ln -s /opt/Sublime\ Text\ 2/sublime_text /usr/bin/sublime
                        # Write the sublime.desktop configuration file
                        printf "Writing sublime.desktop file\n"
                        # Thanks to grawity for solving the sudo cat redirection
                        # problem here:
                        # https://superuser.com/questions/340074/bash-permission-denied-issue-when-trying-to-append-to-eof/340083#340083
                        sudo bash -c 'cat >> /usr/share/applications/sublime.desktop' <<EOF
[Desktop Entry]
Version=2.0.2
Name=Sublime Text 2
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Text Editor

Exec=sublime
Terminal=false
Icon=/opt/Sublime Text 2/Icon/48x48/sublime_text.png
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n
TargetEnvironment=Unity
EOF
                else
                    printf "Please enter either i386 or x64.\n"
                    bash sublime-inst.sh
                fi
        elif [[ $installdecision == "u" || $installdecision == "U" ]]
            then
                # Delete the folder ???/opt/Sublime Text 2/???
                printf "Deleting Sublime Text 2 folder\n"
                sudo rm -fr /opt/Sublime\ Text\ 2/
                # Unlink /usr/bin/sublime
                printf "Removing Sublime Text 2 symlink\n"
                sudo unlink /usr/bin/sublime
                # Remove the .desktop file
                printf "Deleting Sublime Text 2 menu association\n"
                sudo rm /usr/share/applications/sublime.desktop
                # Remove all packages and configuration files in the home
                # directory
                printf "Removing Sublime Text 2 package and configuration file in the home directory\n"
                rm -fr $HOME/.config/sublime-text-2/
                # Remove all packages and configuration files in the root
                # directory
                printf "Removing Sublime Text 2 package and configuration file in the root directory\n"
                sudo rm -fr /root/.config/sublime-text-2/

                # It???s not clear to me if the following step is necessary. Maybe
                # such an entry was made in old versions.
                # Answer was given by WebbyIT here: https://askubuntu.com/questions/327747/how-to-remove-sublime-from-ubuntu-12-04/327752#327752
                # sudo sed -i 's/sublime\.desktop/gedit.desktop/g' /usr/share/applications/defaults.list
        else
            printf "Please enter i, I, u or U. Restarting script!\n"
            bash sublimetext-install.sh
        fi
# Sublime Text 3 installation/uninstallation dialog
elif [[ $versiondecision == "st3" || $versiondecision == "ST3" ]]
    then
        read -p "Do you want to [i]nstall or [u]ninstall Sublime Text 3? " installdecision

        if [[ $installdecision == "i" || $installdecision == "I" ]]
            then
                read -p "Do you have a [i386] or [x64] system architecture? " archdecision

                if [ $archdecision == "i386" ]
                    then
                        # Download the .tar archive
                        printf "Downloading Sublime Text 3 for i386 system.\n"
                        wget https://download.sublimetext.com/sublime_text_3_build_3207_x32.tar.bz2
                        # Extract the .tar archive
                        printf "Extracting tar archive\n"
                        tar -jvxf sublime_text_3_build_3207_x32.tar.bz2
                        # Move the extracted folder to /opt/
                        printf "Moving Sublime Text 3 folder to /opt/\n"
                        sudo mv sublime_text_3 /opt/
                        # Create the symlink /usr/bin/sublime linked to
                        # ???/opt/Sublime Text 2???
                        printf "Creating Sublime Text 3 symlink\n"
                        sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/sublime
                        # Write the sublime.desktop configuration file
                        printf "Writing sublime.desktop file\n"
                        # Thanks to grawity for solving the sudo cat redirection
                        # problem here:
                        # https://superuser.com/questions/340074/bash-permission-denied-issue-when-trying-to-append-to-eof/340083#340083
                        sudo bash -c 'cat >> /usr/share/applications/sublime.desktop' <<EOF
[Desktop Entry]
Version=3.2.1
Name=Sublime Text 3
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Text Editor

Exec=sublime
Terminal=false
Icon=/opt/sublime_text_3/Icon/48x48/sublime_text.png
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n
TargetEnvironment=Unity
EOF
                elif [ $archdecision == "x64" ]
                    then
                        # Download the .tar archive
                        printf "Downloading Sublime Text 3 for x64 system.\n"
                        wget https://download.sublimetext.com/sublime_text_3_build_3207_x64.tar.bz2
                        # Extract the .tar archive
                        printf "Extracting tar archive\n"
                        tar -jvxf sublime_text_3_build_3207_x64.tar.bz2
                        # Move the extracted folder to /opt/
                        printf "Moving Sublime Text 3 folder to /opt/\n"
                        sudo mv sublime_text_3 /opt/
                        # Create the symlink /usr/bin/sublime linked to
                        # ???/opt/Sublime Text 2???
                        printf "Creating Sublime Text 3 symlink\n"
                        sudo ln -s /opt/sublime_text_3/sublime_text /usr/bin/sublime
                        # Write the sublime.desktop configuration file
                        printf "Writing sublime.desktop file\n"
                        # Thanks to grawity for solving the sudo cat redirection
                        # problem here:
                        # https://superuser.com/questions/340074/bash-permission-denied-issue-when-trying-to-append-to-eof/340083#340083
                        sudo bash -c 'cat >> /usr/share/applications/sublime.desktop' <<EOF
[Desktop Entry]
Version=3.2.1
Name=Sublime Text 3
# Only KDE 4 seems to use GenericName, so we reuse the KDE strings.
# From Ubuntu's language-pack-kde-XX-base packages, version 9.04-20090413.
GenericName=Text Editor

Exec=sublime
Terminal=false
Icon=/opt/sublime_text_3/Icon/48x48/sublime_text.png
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n
TargetEnvironment=Unity
EOF
                else
                    printf "Please enter either i386 or x64.\n"
                    bash sublimetext-install.sh
                fi
        elif [[ $installdecision == "u" || $installdecision == "U" ]]
            then
                # Delete the folder /opt/Sublime Text 3/
                printf "Deleting Sublime Text 3 folder\n"
                sudo rm -fr /opt/sublime_text_3
                # Unlink /usr/bin/sublime
                printf "Removing Sublime Text 3 symlink\n"
                sudo unlink /usr/bin/sublime
                # Remove the .desktop file
                printf "Deleting Sublime Text 3 menu association\n"
                sudo rm /usr/share/applications/sublime.desktop
                # Remove all packages and configuration files in the home
                # directory
                printf "Removing Sublime Text 3 package and configuration file in the home directory\n"
                rm -fr $HOME/.config/sublime-text-3/
                # Remove all packages and configuration files in the root
                # directory
                printf "Removing Sublime Text 3 package and configuration file in the root directory\n"
                sudo rm -fr /root/.config/sublime-text-3/

                # It???s not clear to me if the following step is necessary. Maybe
                # such an entry was made in old versions.
                # Answer was given by WebbyIT here:
                # https://askubuntu.com/questions/327747/how-to-remove-sublime-from-ubuntu-12-04/327752#327752
                # sudo sed -i 's/sublime\.desktop/gedit.desktop/g' /usr/share/applications/defaults.list
        else
            printf "Please enter i, I, u or U. Restarting script!\n"
            bash sublimetext-install.sh
        fi
else
    printf "Please enter st2 or st3. Restarting script!\n"
    bash sublimetext-install.sh
fi
