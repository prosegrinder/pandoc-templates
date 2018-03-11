# Pandoc Templates

An opinionated set of Pandoc templates and scripts for converting markdown to DOCX manuscripts that adhere to [William Shunn's Proper Manuscript Format](https://www.shunn.net/format/) guidelines using [Pandoc](https://pandoc.org).

## Getting Started

These templates and scripts aim to be easy to install and use, and consistent across Windows, Mac, and Linux. I generally use Mac and Linux at home, so Windows scripts may lag behind those.

### Pandoc

These templates rely on [Pandoc](https://pandoc.org) v2.0 or greater, which is available on Windows, Mac, and Linux. See the Pandoc site for [full installation](https://pandoc.org/installing.html) instructions. For Linux, I strongly suggest using [LinuxBrew](http://linuxbrew.sh/) instead of your distribution's package manager for the same reason given in the Pandoc installation instructions. Versions packaged by your distribution may be too old.

### Markdown

These templates are only for short and long fiction written in Markdown. See [Sustainable Authorship in Plain Text using Pandoc and Markdown](https://programminghistorian.org/lessons/sustainable-authorship-in-plain-text-using-pandoc-and-markdown#philosophy) if you're interested in my motivation. I hope one day soon publishers in the fiction markets will begin accepting submissions in Markdown format.

## Installation

Once you have [Pandoc](https://pandoc.org) set up, you'll need to copy these files to your local machine.

### Git

If you're ```git``` savvy, clone this repository:

```bash
git clone https://github.com/prosegrinder/pandoc-templates.git
```

### Download

If you're not familiar with ```git```, no big deal. Just download the [latest release](https://github.com/prosegrinder/pandoc-templates/releases/latest) and extract it to any directory you like.

## Usage

Once you have the files locally,

[Shunn's Short Story Format](https://www.shunn.net/format/story.html) is a generally acceptable format for submitting short stories to markets.

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

```bash
$PANDOC_TEMPLATES_HOME/bin/shunshort.sh /some/cool/story.md /some/cool/story.docx
```

 That's it!

## Built With

* [Pandoc](https://pandoc.org): Document Conversion Utility
* [William Shunn](https://www.shunn.net/format/): Formatting Guidelines
* [Markdown](https://daringfireball.net/projects/markdown/): A Plain Text Formatting Syntax

## Contributing

When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.

In general:

* Use the standard Pull Request process.
* Be respectful of yourself and others.
* Have fun!

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/prosegrinder/pandoc-templates/tags).
