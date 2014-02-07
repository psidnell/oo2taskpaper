# oo2taskpaper

This is an [OmniOutliner](http://www.omnigroup.com/omnioutliner) plugin that adds a new "TaskPaper (text)" option to the export menu.

## Why?

While I love editing and arranging in OmniOutliner, if I want to email someone else my outline I've found pasting the OO content into an email usually causes catastrophic indenting and layout problems. On the other hand TP seems to get it right every time. Thus a convenient route OO->TP->Mail is pretty useful to me at least.

## Installation

1. Download the [zip](https://github.com/psidnell/oo2taskpaper/archive/master.zip) and open it.
2. Double click on the TaskPaper.ooxsl bundle and OmniOutliner 4 should offer to install it.

## Known Limitations

- Formatting is stripped since there is no representation of this in TaskPaper.
- Only the first column is exported.
- OO entries with children become TP projects, whereas those without become tasks.