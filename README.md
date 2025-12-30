# Chezmoi

This dotfiles config is managed by [chezmoi](https://www.chezmoi.io/reference/).

## Sandbox testing

Run:
```sh
docker build -t chezmoi-test .
docker run --rm -it chezmoi-test 

# Inside the container
chezmoi init --apply ~/temp_dotfiles
```
