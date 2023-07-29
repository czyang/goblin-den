# goblin-den
My personal blog using goblin as the generator

## Auto fetch and gen blog
```bash
mv ./goblin-wizard.service /etc/systemd/system/

sudo systemctl start goblin-wizard
sudo systemctl enable goblin-wizard
```