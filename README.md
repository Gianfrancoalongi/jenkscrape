# jenkscrape
Jenkins Scraper For Penetration Testing

Jenkins Scraper automatically traverses all visible jobs and scrapes them for interesting stuff.
Right now only unauthed params, next step will be to support authtokens.

Depends on JQ - you should get that installed for command line JASON parsing

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
[*] Scraping jobs.............[324/1145]
```
