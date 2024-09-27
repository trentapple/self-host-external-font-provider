# Self-Host External Font Provider

Convert from Google Fonts to locally self-hosted font files (see [awesome-privacy](https://github.com/Lissy93/awesome-privacy)).

*Please ensure the license terms for the font allows this before proceeding.* (*_TINLA_*)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Example](#example)
- [Contributing](#contributing)
- [License](#license)

## Overview

This project provides a script to convert Google Fonts or other external font providers into locally hosted font files. This enhances privacy, performance, and independence from external services. 

## Features

- Automatically detect and download fonts from Google Fonts.
- Save fonts locally into a specified directory.
- Update HTML files to reference local fonts instead of external URLs.
- Supports protocol-neutral URLs.
- Simple and easy to use with a single command.

## Installation

Clone the repository on the local machine:

```sh
git clone https://github.com/trentapple/self-host-external-font-provider.git
cd self-host-external-font-provider
chmod u+x ./convert.sh
```

*Ensure the execution environment has `curl` installed. If not, install it using the system package manager (such as `sudo apt install -y curl` on Debian flavors).*

## Usage

Run the script with the path to your HTML file (*Note:* Please backup important files first):

```
./convert.sh path/to/your/file.html [/optional/font/directory]
```

* `path/to/your/file.html`: The HTML file containing the Google Fonts link.
* `/optional/font/directory`: (Optional) Directory to save the fonts. Defaults to a fonts directory relative to the HTML file.

### Explanation of steps:

* Detect the Google Fonts URL in your HTML file. (**Please do yourself a favor and back up all files _before_ proceeding with running any scripts!**)
* Download the necessary font files.
* Update your HTML file to reference the downloaded font files.

## Example

Given an HTML file index.html with the following Google Fonts link:

```
<link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
```

#### Run the script:

`./convert.sh index.html`

#### The script will:

* Create a fonts directory (relative to the path of index.html) if it does not already exist
* Download the Roboto font files.
* Persistently cache the font files within the fonts directory.
* Write a fonts.css file in the fonts directory (used for including the fonts in HTML / markup)
* Update index.html to reference the local fonts.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for consideration of any improvements or defect fixes.

* Fork the repository.
* Create a new branch (git checkout -b feature-branch).
* Commit your changes (git commit -am 'Add new feature').
* Push to the branch (git push origin feature-branch).
* Create a new Pull Request.

## License

See repository license defails (TL;DR GNU GPL v3)
