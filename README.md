# Personal Dotfiles for Magic Shellbook

This is a collection of my personal dotfiles for my Magic Shellbook. See more about the Magic Shellbook [here]().

```sh
./install.sh
```

If the location of the dotfiles is not the default `~/.dotfiles`, then update the `DOTFILES_DIR` variable in `.pam_environment` to the correct location.

## How to customize
1. Fork this repo
2. Edit the files in the `dotfiles` directory
3. Update the `install.sh` script to copy the files to the correct location
4. Use with `./install.sh` or [The Magic Shellbook](https://github.com/KyleTryon/Ansible-Magic-Shellbook)

## Why not use templates?
Given that Ansible is being used, you may wonder why I didn't use Jinja2 templates directly in Ansible. While that is an option, by keeping the dotfiles in a separate repo and in a "live" state, if and when the dotfiles need to be updated, the changes can be made in production and then pushed back to the repo.
This also makes the Ansible playbooks much simpler, as it ignores confguration.
