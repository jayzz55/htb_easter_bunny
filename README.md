HTB Easter Bunny

This repo documents my own personal learning and solution to [Hack The Box - Easter Bunny's challenge](https://app.hackthebox.com/challenges/311).

# Solution
See Google Slide: https://docs.google.com/presentation/d/1vezZB0UmdvH2aryh-fL0vdWEOqYf23hDRZmiEqNVttQ/edit?usp=sharing

The diagram used in the presentation slide can be found in:
* https://excalidraw.com/#json=aAd4MERdmVlMpIXx-JLjc,TNTdfl37D79yg5zL-jfbww
* "htb-easter-bunny.excalidraw" file in this repo.

# Running the attack
1. From the main directory of this project, run and expose the local server
    * run `ruby -rwebrick -e'WEBrick::HTTPServer.new(Port: 8080, DocumentRoot: ".").start'`
    * Expose the local server to the public internet via https://localhost.run/
2. In the main directory of this project, update the `HTB_URL` and `ATTACKER_SERVER` within "hack.rb"
  * `HTB_URL`  is either the URL from the hack the box website or `localhost:1337` if run locally. Follow below step to run the web app locally:
    * `cd` into "web_easterbunny" and run `./build-docker.sh` to start the Easter Bunny web application.
3. run `ruby hack.rb`
