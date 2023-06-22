#!/bin/bash

OS=$(lsb_release -si)
VERSION=$(lsb_release -sr)

if [[ $OS == "Ubuntu" && $VERSION < "18.04" ]]; then
    read -p "Внимание: Установка Viper4Linux на Ubuntu ниже версии 18.04 может привести к проблемам, установки либо в работоспособности Viper! Вы хотите продолжить? (y/n): " choice
    if [[ $choice != "y" && $choice != "Y" ]]; then
        echo "Установка отменена..."
        exit 0
    fi
fi


clear
echo "Пожалуйста подождите пока скрипт установит Viper4Linux..."
sleep 5
sudo apt install libqt5multimedia5 libqt5xml5 libqt5svg5 qtbase5-dev libqt5core5a libqt5widgets5 libqt5gui5 libqt5core5a libgl1-mesa-dev libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev gstreamer1.0-plugins-bad libgstreamer-plugins-bad1.0-dev -y
sudo apt install build-essential git cmake libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev gstreamer1.0-tools -y
sudo apt install make cmake wget -y
sudo apt install pulseaudio pavucontrol -y

clear

cd ~
git clone https://github.com/Audio4Linux/Viper4Linux.git
git clone https://github.com/Audio4Linux/gst-plugin-viperfx
git clone https://github.com/vipersaudio/viperfx_core_binary.git

clear

cd gst-plugin-viperfx
cmake .
make
clear
echo "(sudo) Копирование libgstviperfx.so в /usr/lib/x86_64-linux-gnu/gstreamer-1.0..."
sudo cp libgstviperfx.so /usr/lib/x86_64-linux-gnu/gstreamer-1.0/

cd ~
echo "(sudo) Копирование libviperfx_x64_linux.so в /lib..."
sudo cp viperfx_core_binary/libviperfx_x64_linux.so /lib/libviperfx.so

cd ~
echo "Удаление хлама..."
rm -rf viperfx_core_binary gst-plugin-viperfx

cd Viper4Linux
echo "Копирование viper4linux в  ~/.config..."
cp -r viper4linux ~/.config
echo "Копирование viper в  ~/bin..."
cp viper ~/bin
echo "Копирование viper в /usr/local/bin..."
sudo cp viper /usr/local/bin
echo "Удаление хлама..."
rm -rf Viper4Linux
clear

echo "Cкачивание DEB пакета в домашнюю директорию..."
wget -P ~/ https://raw.githubusercontent.com/ThePBone/PPA-Repository/master/viper4linux-gui_2.2-43.deb
echo "Установка Viper4Linux приложения..."
cd ~
sudo dpkg -i viper4linux-gui_2.2-43.deb
echo "Удаление хлама..."
rm viper4linux-gui_2.2-43.deb
clear
echo "Установка Viper4Linux завершена! Поздравляем!"
sleep 5
exit 0