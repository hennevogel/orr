# Contributing to `orr`
Our Free Software project is open to contributions. We welcome everyone
who wants to contribute in any way! Read this guide on how to do that.

In particular, this project seeks the following types of contributions:

* code: Contribute your developer expertise and help us expand `orr`.
  Fix bugs, implement features or re-factor for improved quality!
* documentation: Document how one can use `orr`, how it works internall
  or how you can extend it.

## Development Environment
We are using [docker](https://www.docker.com/) to create our development environments.

1. Install [docker](https://docs.docker.com/get-started/)
1. Clone this code repository:
    ```
    git clone https://github.com/hennevogel/orr.git
    ```
1. Start the development environment container with:
    ```
    rake suitup
    ```
1. Run `orr` from the git checkout:

    ```
    ./orr
    ```
1. Changed something? Test your changes!:

    ```
    rake ohno
    ```

## How to contribute code
* Prerequisite: familiarity with [GitHub Pull Requests](https://help.github.com/articles/using-pull-requests) and issues.
* Fork the repository and make a pull-request with your changes
* We automatically run our test suite and other automated test on every pull-request, all test have to pass
* Additionally one of the `orr` maintainers will review your pull-request
  * If you are already a contributor and you get a positive review, you can merge your pull-request yourself
  * If you are not already a contributor, a contributor will merge your pull-request after a positive review 
  * If you get a negative review please address the mentioned issues or ask for help if you need it

**Note**: Reviewing your pull-request might take some time, as we are all volunteers.

## Labels for issues and pull-requests 
...and what they mean!

1. **Bug**: A problem in the application, something is wrong and needs to be fixed. Ideally the issue includes details on how to reproduce the bug
1. **Feature**: New functionality for the app. Ideally the issue includes a detailed description how this should work and especially why it is usefull
1. **Junior**: Easy to address tasks for beginners or people unfamiliar with the application.
1. **Refactorization**: Code needs to be re-written to do things in a simpler/saner way!
1. **Research**: Ideas to explore and form an opinion about

## Code of Conduct
`orr` is part of the openSUSE project. We follow all the [openSUSE Guiding Principles!](http://en.opensuse.org/openSUSE:Guiding_principles) If you think someone doesn't do that, please let the [openSUSE Board](mailto:board@opensuse.org) know!
