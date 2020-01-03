[yard1/steamcmd_gmail](https://hub.docker.com/repository/docker/yard1/steamcmd_gmail)
===================

Steamcmd with Steam Guard support by using GMail API.

This Docker image is used as a build stage of [Yard1/pdx-steam-workshop-publisher-action](https://github.com/Yard1/pdx-steam-workshop-publisher-action).

# Overview

This Docker container allows for automatic SteamCMD login for accounts with email Steam Guard enabled. It uses Google API to read the Steam Guard code from the given GMail account, and automatically inputs it into SteamCMD when asked.

# Getting Google API credentials

Create empty credential file.

```bash
touch gmail_credentials.json
```

Get Google API client secret file from https://developers.google.com/gmail/api/quickstart/go and save it as `client_secret.json`, placing it in working directory.

Run steamcmd_gmail, logging in with your account details.

```bash
docker run -it --rm -v gmail_credentials.json:/credential.json client_secret.json:/client_secret.json fank/steamcmd-gmail +login <username> <password> +quit
```

steamcmd_gmail will ask you to approve the application in your Google Account. Afterwards, the credential data will be written to `gmail_credentials.json`.

Those two files can then be used for running [Yard1/pdx-steam-workshop-publisher-action](https://github.com/Yard1/pdx-steam-workshop-publisher-action).

MAKE SURE TO KEEP YOUR CREDENTIAL DATA FROM BOTH FILES SAFE AND SECURE. IT CAN BE USED TO CAUSE HARM TO YOUR GOOGLE ACCOUNT.

## Credits

Forked from [Fank/docker-steamcmd-gmail](https://github.com/Fank/docker-steamcmd-gmail) under MIT License (see LICENSE file for details).