# Installation and discovery

The package is intended for local installation from this marketplace checkout.
The reversible filesystem smoke copies both plugin roots into a temporary,
namespaced install directory:

```text
bash scripts/check_installation.sh
```

This smoke removes only its own temporary directory. It does not publish,
modify a user's plugin installation, create repositories, or run Shimmy
bootstrap. Host application installation and app-server discovery are separate
checks and must be reported as such.
