#!/usr/bin/env bash
# Id$ nonnax 2022-04-09 14:58:51 +0800
ls *.s?ss | fzf --preview='cat {} && echo '---------' && ./sass.rb {} | bat -p -l scss --color=always'
# ls *.s?ss | fzf --preview='paste <(cat {}) <(./sass.rb {} | bat -p -l scss --color=always)'
# ls *.s?ss | fzf --preview='paste <(cat {}) <(./sass.rb {})'
