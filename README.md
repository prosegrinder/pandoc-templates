# Pandoc Templates

An opinionated set of Pandoc templates and scripts for converting markdown to DOCX manuscripts
that adhere to [William Shunn's Proper Manuscript Format](https://www.shunn.net/format/)
guidelines using [Pandoc](https://pandoc.org).

## Getting Started

These templates and scripts aim to be easy to install and use, and consistent across Windows, Mac, and Linux. I generally use Mac and Linux at home, so Windows scripts may lag behind those.

### Requirements

* [Pandoc](https://pandoc.org) version 2.0 or greater.

### Pandoc

See the Pandoc site for [full installation](https://pandoc.org/installing.html) instructions. For Linux, I strongly suggest using [LinuxBrew](http://linuxbrew.sh/) instead of your distribution's package manager for the same reason given in the Pandoc installation instructions. Install LinuxBrew and follow the instructions for installing on Mac via HomeBrew. Versions packaged by your distribution may be too old.

### Markdown

These templates only work for short and long fiction written in Markdown. See [Sustainable Authorship in Plain Text using Pandoc and Markdown](https://programminghistorian.org/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown#philosophy) if you're interested in my motivation. I hope one day soon publishers in the fiction markets will prefer submissions in Markdown over DOCX as it minimized the burden of typsetting on the author and is relatively easy to convert to many other formats (e.g. using Pandoc).

## Installation

Once you have [Pandoc](https://pandoc.org) set up, you'll need to copy these files to your local machine.

### Install via Download

If you're not familiar with ```git```, no big deal. Just download the [latest release](https://github.com/prosegrinder/pandoc-templates/releases/latest) and extract it to any directory you like.

### Install via Git

If you're ```git``` savvy, clone this repository:

```bash
git clone https://github.com/prosegrinder/pandoc-templates.git
```

## Usage

Once you have the templates installed locally, you'll need to make sure your source Markdown document
has the proper frontmatter.

### Frontmatter

These templates assume the following frontmatter in at least one of the markdown files. The following
is from the guidelines.md file used to test Shunn's Short Story Format:

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

Optional properties for the frontpage:

```yaml
subtitle: Optional field
abstract: |-
  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nam libero justo laoreet sit amet cursus. Etiam erat velit scelerisque in dictum non consectetur a. Duis tristique sollicitudin nibh sit amet commodo nulla.
```

### `md2short.sh`

The script simplifies the process of converting a short story in markdown to a Microsoft Word
DOCX file in [William Shunn's Short Story Format](https://format.ms/story.html):

For Mac & Linux:

```bash
md2short.sh --output DOCX [--overwrite] [--modern] FILES

  -o DOCX               --output=DOCX
    Write the output to DOCX. Passed straight to pandoc as-is.
  -x                    --overwrite
    If output FILE exists, overwrite without prompting.
  -m                    --modern
    Use Shunn modern manuscript format (otherwise use Shunn classic)
  FILES
    One (1) or more Markdown file(s) to be converted to DOCX.
    Passed straight to pandoc as-is.
```

For example:

```bash
$PANDOC_TEMPLATES_HOME/bin/md2short.sh --output $HOME/somecoolstory.docx --overwrite $HOME/somecoolstory.md
```

For Windows (using PowerShell 5.0 or greater): **under revision**

```powershell
.\bin\md2short.ps1 -overwrite -modern -output $env:USERPROFILE/Documents/short-out-ps.docx './test/short/guidelines.md'
```

### `md2long.sh`

The script simplifies the process of converting a novel in markdown to a Microsoft Word
DOCX file in [William Shunn's Novel Format](https://format.ms/novel.html):

For Mac & Linux:

```bash
md2long.sh --output DOCX [--overwrite] FILES

  -o DOCX               --output=DOCX
    Write the output to DOCX.
    Passed straight to pandoc as-is.
  -x                    --overwrite
    If output FILE exists, overwrite without prompting.
  FILES
    One (1) or more Markdown file(s) to be converted to DOCX.
    Passed straight to pandoc as-is.
```

For example:

```bash
$PANDOC_TEMPLATES_HOME/bin/md2long.sh --output $HOME/somecoolstory.docx --overwrite $HOME/manuscript/ch*.md
```

For Windows (using PowerShell 5.0 or greater): **under revision**

### Paragraph Breaks

Use an empty paragraph to create a space between two scenes. An empty paragraph can be created by escaping a space character:

```

\ 

```

## Credits

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
