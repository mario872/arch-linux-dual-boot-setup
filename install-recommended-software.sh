echo "Note: This script needs attendance to be run"

echo "## Installing YAY ##"
sudo pacman -S --needed git base-devel  --noconfirm
git clone https://aur.archlinux.org/yay.git
cd yay
yes | makepkg -si
cd ..
echo "## Yay was installed successfully ##"

echo "## Installing Snap"
yay -Sy snapd  --noconfirm --sudoloop
sudo systemctl enable --now snapd.socket
echo "## Snap was installed successfully ##"

echo "## Installing Flatpak ##"
sudo pacman -Sy flatpak  --noconfirm
echo "## Flatpak was installed successfully ##"

echo "## Installing 7zip ##"
sudo pacxman -Sy 7zip  --noconfirm
echo "## 7zip was installed successfully ##"

echo "## Installing chromium ##"
sudo pacman -Sy chromium --noconfirm
echo "## Chromium was installed successfully ##"

echo "## Installing docker and docker-compose ##"
sudo pacman -Sy docker docker-compose  --noconfirm
echo "## Docker and docker-compose was installed successfully ##"

echo "## Installing ffmpeg ##"
sudo pacman -Sy ffmpeg  --noconfirm
echo "## Ffmpeg was installed successfully ##"

echo "## Installing wget ##"
sudo pacman -Sy wget  --noconfirm
echo "## Wget was installed successfully ##"