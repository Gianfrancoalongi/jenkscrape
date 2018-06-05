# jenkscrape
Jenkins Scraper For Penetration Testing

Jenkins Scraper is an automatic tool to quickly traverse vast amounts of possibly accessable Jenkins Console Outputs.
If during an engagement you find yourself being able to list jenkins jobs, and you think there might be credentials in there, then this tool is for you!

Right now this proof of concept only supports unauthed jenkin API calls, next step will be to support authtokens.

Depends on JQ - you should get that installed for command line JSON parsing
```
apt-get install jq
```

This runs  perfectly well in a small console window - just run it and supply hostname or IP-address of your jenkins.

```
Usage: ./jenskcrape.bash IPORNAMETOYOURJENKINS



     ██╗███████╗███╗   ██╗██╗  ██╗███████╗ ██████╗██████╗  █████╗ ██████╗ ███████╗
     ██║██╔════╝████╗  ██║██║ ██╔╝██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
     ██║█████╗  ██╔██╗ ██║█████╔╝ ███████╗██║     ██████╔╝███████║██████╔╝█████╗  
██   ██║██╔══╝  ██║╚██╗██║██╔═██╗ ╚════██║██║     ██╔══██╗██╔══██║██╔═══╝ ██╔══╝  
╚█████╔╝███████╗██║ ╚████║██║  ██╗███████║╚██████╗██║  ██║██║  ██║██║     ███████╗
 ╚════╝ ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝

                                                                 by maraud3r
[*] Scraping will be stored in /tmp/tmp.1HTFmkGLFI
[*] Collecting job list...............DONE
[*] Scraping jobs.....................DONE
[*] Sorting and fixing up output......DONE

```

You will find the scrapes in the named directory as /tmp/tmp.1HTFmkGLFI/scrapings.res - it will be sorted, and containing no duplicates.
All pulled data is removed during the process to avoid bloating your system during scraping.
