# goblin-den
My personal blog using goblin as the generator

# Install Goblen
https://github.com/czyang/goblin

## Auto fetch and gen blog
```bash
cp ./goblin-wizard.service /etc/systemd/system/

sudo systemctl start goblin-wizard
sudo systemctl enable goblin-wizard

systemctl daemon-reload

sudo systemctl restart goblin-wizard
sudo systemctl status goblin-wizard

```
