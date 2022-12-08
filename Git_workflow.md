## 1.configure
```git bash
git config --global user.name "Richard1iu"
git config --global user.email "ly159632874@163.com"
git config --list 
```
## set proxy if you are scientifc surfing
```bash
# cancel all proxy 
git config --global --unset http.proxy
git config --global --unset https.proxy

# cancel SSL verification
git config --global http.sslVerify "false" 

# set the https proxy
git config --global http.proxy 127.0.0.1:7890
git config --global https.proxy 127.0.0.1:7890

```

## glimpse the config
git status
git config -l --global

## fullstory of initiation
```
git init
git add README.md
git add --all
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/richard1iu/shell_script.git
git pull --rebase origin main
git push -u origin main
```
