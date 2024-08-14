# toggle_github_account

Quickly toggle between two GitHub accounts using SSH keys.

> You many need to remove all GitHub credentials from your MacOS Keychain, VSCode, GitHub Desktop, or other git apps before the SSH keys will work as expected.

## Creating SSH Keys

You will need to create SSH keys for both your personal GitHub account and work account.

```
ssh-keygen -t rsa -C "YOUR_PERSONAL_ACCOUNT" -f ~/.ssh/id_rsa_personal
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in .ssh/id_rsa_personal
Your public key has been saved in .ssh/id_rsa_personal.pub
```

You will see your fingerprint and a RSA image.

Repeat the above for the work account:

```
ssh-keygen -t rsa -C "YOUR_WORK_ACCOUNT" -f ~/.ssh/id_rsa_work
```

### Start the ssh-agent

`eval "$(ssh-agent -s)"`

### Add SSH keys to the ssh-agent

`ssh-add ~/.ssh/id_rsa_personal`

`ssh-add ~/.ssh/id_rsa_work`

### Update the .ssh/config

Use an editor of your choice to update the .ssh/config.

```
nano ~/.ssh/config
```

Update the config with your ssh values:

```
Host github.com-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_personal
Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa_work
```

## Adding SSH Keys To GitHub Accounts

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

## Reset a Repository Origin

When cloning repositories you will need to use the SSH option. For repositories that have already been cloned you may need to reset a repository's origin to now use SSH. You may receive a 404 unauthorized response when attempting to push otherwise.

```
git remote set-url origin git@github.com:username/repository.git
```

## Setup

Either hardcode your account details into the script, or setup environment variables using a .env file.

## Using the Toggle

You can either add the _toggle_github_account.sh_ file to a specific directory or to your PATH.

You can then call invoke the script:

```
./toggle_github_account.sh work
```

```
./toggle_github_account.sh personal
```

## Check the Correct User Account is Active

```
git config --global user.name
git config user.name
```
