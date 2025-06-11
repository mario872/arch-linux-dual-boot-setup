echo "Note: This script needs attendance to be run"

echo "## Installing Bambu Studio ##"
yay -Sy bambustudio-bin --noconfirm --sudoloop
echo "## Bambu Studio was installed successfully ##"

echo "## Installing Opera ##"
yay -Sy opera --noconfirm --sudoloop
echo "## Opera was installed successfully ##"

echo "## Installing dosfstools and ntfs-3g##"
sudo pacman -Sy dosfstools ntfs-3g --noconfirm
echo "## dosfstools and ntfs-3g was installed successfully ##"

echo "## Installing esptool ##"
sudo pacman -Sy esptool --noconfirm
echo "## esptool was installed successfully ##"

echo "## Installing visual studio code ##"
yay -Sy visual-studio-code-bin --noconfirm --sudoloop
echo "## Visual Studio Code was installed successfully ##"

echo "## Installing gnome tweaks  and gnome extensions ##"
sudo pacman -Sy gnome-tweaks gnome-extensions --noconfirm
echo "## Gnome Tweaks and Gnome Extensions was installed successfully ##"

echo "## Installing ollama ##"
sudo pacman -Sy ollama --noconfirm
echo "## Ollama was installed successfully ##"

echo "## Installing p3x-onenote ##"
sudo snap install p3x-onenote
echo "## p3x-onenote was installed successfully ##"

echo "## Installing teams for linux ##"
sudo snap install teams-for-linux
echo "## Teams for Linux was installed successfully ##"

echo "## Installing thonny ##"
yay -Sy thonny --noconfirm --sudoloop
echo "## Thonny was installed successfully ##"

echo "## Installing wine ##"
yay -Sy wine --noconfirm --sudoloop
echo "## Wine was installed successfully ##"

echo "## Install appimagelauncher ##"
yay -Sy appimagelauncher --noconfirm --sudoloop
echo "## Appimagelauncher was installed successfully ##"

echo "## Installing RPi-Imager ##"
sudo pacman -Sy rpi-imager --noconfirm
echo "## RPi-Imager was installed successfully ##"

echo "## Installing KiCad ##"
sudo pacman -Sy kicad --noconfirm
sudo pacman -Sy --asdeps kicad-library kicad-library-3d --noconfirm
echo "## KiCad was installed successfully ##"