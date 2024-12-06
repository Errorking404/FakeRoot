#!/bin/bash                                           
# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Banner
echo -e "${GREEN}"
echo "  ______                     "
echo " |  ____|                    "
echo " | |__   _ __ _ __ ___  _ __ "
echo " |  __| | '__| '__/ _ \| '__|"
echo " | |____| |  | | | (_) | |   "
echo " |______|_|  |_|  \___/|_|   "
echo -e "${NC}"

while true; do
  
  echo -e "${GREEN}"
  for ((i=0; i<=10; i++)); do
    echo -ne "\rLoading [$i/10]..."
    sleep 0.5
  done
  echo -e "${NC}"

  sleep 2s

  echo -e "Installing all system requirements......."
  sleep 1.5s
  apt update && apt upgrade -y
  apt install git proot -y
  apt install proot-distro -y
  apt install espeak -y
  apt install bash -y
  echo -e "Installation Completed."
  espeak "Installation Completed"
  sleep 4s
espeak "Welcome to Error FakeRoot"
  timeout 2 cmatrix

  echo -e "Choose a distro for fakeroot::"

  # Updated list of supported distributions
  distros=("Alpine" "Arch Linux" "Artix Linux" "Chimera Linux" "Debian" "Debian (bullseye)" "deepin" "Fedora" "Manjaro" "OpenKylin" "OpenSUSE" "Pardus" "Ubuntu" "Ubuntu (22.04)" "Void Linux")

  # Display menu in a table format
  echo -e "${BLUE}"
  echo "+-----------------------+"
  echo "|  Distro Selection    |"
  echo "+-----------------------+"
  for i in "${!distros[@]}"; do
    echo "|  $((i+1)). ${distros[$i]}  |"
  done
  echo "|  $((${#distros[@]} + 1)). Main Menu       |"
  echo "+-----------------------+"
  echo -e "${NC}"

  sleep 2s
  
  while true; do
    read -p "Enter the number of your chosen distro: " choice
    
    if [[ $choice =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#distros[@]} )); then
      selected_distro=${distros[$((choice-1))]}
      break
    elif [[ $choice == $((${#distros[@]} + 1)) ]]; then
      echo "Going back..."
      break 2
    else
      echo "Invalid choice. Please try again."
    fi
  done

  if [[ $choice != $((${#distros[@]} + 1)) ]]; then

    selected_distro_lower=$(echo "$selected_distro" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

    proot-distro install $selected_distro_lower
    espeak "Installing the disro"
    login_file="Start_${selected_distro// /_}.sh"
    echo "#!/bin/bash" > $login_file
    echo "proot-distro login $selected_distro_lower" >> $login_file
    chmod +x $login_file
     espeak "Installation Complete. Check below line for more details"
    echo "Installation complete! You can login to your $selected_distro environment by running ./${login_file}"
  fi
done
