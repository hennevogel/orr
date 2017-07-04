# orr - openSUSE RVM replacement
A command-line tool command-line tool which allows you to easily install,
manage, and work with multiple ruby environments on openSUSE Distributions.

This is an application heavily inspired by [RVM](https://rvm.io/), in fact it
tries to mimic the RVM behaviour and command-line options so it can serve,
for the most basic use cases, as RVM replacement.

## Installation
`orr` is only usefull for the openSUSE/SUSE Linux Enterprise Distributions.
You can install it with zypper.

```
zypper in orr
```

## Contribute
See CONTRIBUTING.md

## Requirements
`orr` makes use of the fabolous...

* [clamp](https://github.com/mdub/clamp) for the ruby command-line app
* [update-alternatives](https://wiki.debian.org/DebianAlternatives) for switching links
* [zypper](https://github.com/openSUSE/zypper) for installing packages
* [docker](https://www.docker.com/) (for the development environment)
