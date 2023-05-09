![](/demo.png)

> A welcome message every time you log into your Raspberry pi

# Installation

```
curl -sL https://raw.githubusercontent.com/Kikobeats/pi-welcome/master/welcome.sh > $HOME/.welcome
chmod +x $HOME/.welcome
echo "./.welcome" >> .profile
```