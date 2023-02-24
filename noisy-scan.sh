echo "Make sure to set your 'rhost' enviroment variable to the target ip."

#Initial port scan and formatting into temporary file
nmap -p- -T5 $rhost | awk '{print $1}' | grep "/tcp" | cut -d "/" -f 1 > temp-ports.txt
cat temp-ports.txt | tr '\n' ',' > ports.txt
rm temp-ports.txt

#Exporting ports environment variable to the list of ports on rhost
export ports=$(cat ports.txt)
rm ports.txt

#Final aggressive scan on all discovered ports, output to results.txt file
nmap -p $ports -A $rhost -oN results.txt
