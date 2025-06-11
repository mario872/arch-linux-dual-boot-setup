echo "Note: This script needs attendance to be run"

echo "## Installing YAY ##"
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
echo "## Yay was installed successfully ##"

echo "## Installing Snap"
yay -Sy snapd
echo "## Snap was installed successfully ##"

echo "## Installing Flatpak ##"
sudo pacman -Sy flatpak
echo "## Flatpak was installed successfully ##"

echo "## Installing 7zip ##"
sudo pacxman -Sy 7zip
echo "## 7zip was installed successfully ##"

echo "## Installing chromium ##"
sudo pacman -Sy chromium
echo "## Chromium was installed successfully ##"

echo "## Installing docker and docker-compose ##"
sudo pacman -Sy docker docker-compose
echo "## Docker and docker-compose was installed successfully ##"

echo "## Installing ffmpeg ##"
sudo pacman -Sy ffmpeg
echo "## Ffmpeg was installed successfully ##"

echo "## Installing wget ##"
sudo pacman -Sy wget
echo "## Wget was installed successfully ##"