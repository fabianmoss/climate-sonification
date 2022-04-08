#! /bin/bash -

# Wrapping the instructions for wget from https://disc.gsfc.nasa.gov/data-access#mac_linux_wget

# Create .netrc file with credentials
if [[ ! -e $HOME/.netrc ]]; then
    touch /$HOME.netrc

    read -p "Enter your Earthdata User ID: " uid
    read -p "Enter your Earthdata User password: " pword

    echo "machine urs.earthdata.nasa.gov login $uid password $pword" >> $HOME/.netrc

    chmod 0600 .netrc
fi

# Create cookie file
if [[ ! -e $HOME/.urs_cookies ]]; then
    touch $HOME/.urs_cookies
fi

# Bulk download
read -p "Select a frequency (can take a looong time to download) [daily/monthly]: " freq

if [[ ! -e $PWD/data/urls_$freq.txt ]]; 
    then
        echo "URL list not in data directory. Download list of ULRs first.";
    else
        cd "$PWD/data/$freq/"
        wget --load-cookies ~/.urs_cookies --save-cookies ~/.urs_cookies --auth-no-challenge=on --keep-session-cookies -i "../urls_$freq.txt"
fi

echo "Everything should be set up."