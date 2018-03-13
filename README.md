# Pandoc Templates

An opinionated set of Pandoc templates and scripts for converting markdown to DOCX manuscripts that adhere to [William Shunn's Proper Manuscript Format](https://www.shunn.net/format/) guidelines using [Pandoc](https://pandoc.org).

## Getting Started

These templates and scripts aim to be easy to install and use, and consistent across Windows, Mac, and Linux. I generally use Mac and Linux at home, so Windows scripts may lag behind those.

### Requirements

* [Pandoc](https://pandoc.org) version 2.0 or greater.

### Pandoc

See the Pandoc site for [full installation](https://pandoc.org/installing.html) instructions. For Linux, I strongly suggest using [LinuxBrew](http://linuxbrew.sh/) instead of your distribution's package manager for the same reason given in the Pandoc installation instructions. Install LinuxBrew and follow the instructions for installing on Mac via HomeBrew. Versions packaged by your distribution may be too old.

### Markdown

These templates only work for short and long fiction written in Markdown. See [Sustainable Authorship in Plain Text using Pandoc and Markdown](https://programminghistorian.org/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown#philosophy) if you're interested in my motivation. I hope one day soon publishers in the fiction markets will prefer submissions in Markdown over DOCX as it minimized the burden of typsetting on the author and is relatively easy to convert to many other formats (vis a vi.

## Installation

Once you have [Pandoc](https://pandoc.org) set up, you'll need to copy these files to your local machine.

### via Download

If you're not familiar with ```git```, no big deal. Just download the [latest release](https://github.com/prosegrinder/pandoc-templates/releases/latest) and extract it to any directory you like.

### via Git

If you're ```git``` savvy, clone this repository:

```bash
git clone https://github.com/prosegrinder/pandoc-templates.git
```

## Usage

Once you have the templates installed locally, you'll need to make sure your source Markdown document has the proper frontmatter.

### Frontmatter

These templates assume the following frontmatter in every markdown file. The following is from the guidelines.md file used to test Shunn's Short Story Format:

```yaml
title: "Proper Manuscript Format"
short_title: "Format"
author: "by William Shunn"
author_lastname: "Shunn"
contact_name: "William Shunn"
contact_address: "12 Courier Lane"
contact_city_state_zip: "Pica's Font, NY 10010"
contact_phone: "(212) 555-1212"
contact_email: "format@shunn.net"
```

### Shunn Short

The script takes two arguments, the name of input markdown file, and the name of the resulting DOCX file.

For Mac & Linux:

```bash
$PANDOC_TEMPLATES_HOME/bin/shunnshort.sh /some/cool/story.md /some/cool/story.docx
```

For Windows (using PowerShell 5.0 or greater):

```powershell
$PANDOC_TEMPLATES_HOME\bin\shunnshort.ps1 C:\some\cool\story.md C:\some\cool\story.docx
```



 That's it!

## Built With

* [Pandoc](https://pandoc.org): Document Conversion Utility
* [William Shunn](https://www.shunn.net/format/): Formatting Guidelines
* [Markdown](https://daringfireball.net/projects/markdown/): A Plain Text Formatting Syntax

## Contributing

When contributing to this repository, please first open an issue to discuss the changes you wish to make.

In general:

* Use the standard Pull Request process.
* Be respectful of yourself and others.
* Have fun!

## Versioning

This project uses [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/prosegrinder/pandoc-templates/tags).
