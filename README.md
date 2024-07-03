# Parch Zram by Sohrab Behdani ([**@behdanisohrab**](https://github.com/behdanisohrab/parch-zram)), inspierd by RPI_ZRAM 
This script will enable ZRAM on a Raspberry Pi or any other personal computer

# Parch Zram
Script to dynamically enable ZRAM on a Raspberry Pi or other Linux system.

Automatically detects the number of CPU cores to allocate to ZRAM computation, disables existing swap and enables ZRAM swap.


## Quick Installer
Install Parch Zram from your Raspberry Pi's shell promt:

### on Parch Linux or any other Arch-based linux distribution

```bash
git clone https://github.com/behdanisohrab/parch-zram
cd parch-zram
makepkg -sic
sudo systemctl enable parch-zram.service
```

### on non-arch based linux distribution

```bash
git clone https://github.com/behdanisohrab/parch-zram
cd parch-zram
sudo chmod +x install.sh
sudo ./install.sh
```


## Donation

You can donate to me for this project in IRR from the link below:

<div class="daramet-embed-donate" id="1208"><script src="https://daramet.com/embed/script.js"></script></div>


