# jenkscrape
Jenkins Scraper For Penetration Testing

Jenkins Scraper is an automatic tool to quickly traverse vast amounts of possibly accessable Jenkins Console Outputs.
If during an engagement you find yourself being able to list jenkins jobs, and you think there might be credentials in there, then this tool is for you!

Right now this proof of concept only supports unauthed jenkin API calls, next step will be to support authtokens.

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
