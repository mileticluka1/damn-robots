# Damn Robots
Smaller project inspired by Portswigger Web Security Academy Path Traversal labs.
Project started as basic sensitive file disclosure scanner but I wanted to implement my knowledge in encoding algorithms combined with web application penetration testing.

# Requirements (gems)
```
open-uri
net-http
```

# Usage
Point with this program was to be proof of concept so I made it's usage very simple:
`ruby main.rb https://example.com/` in case of scanning the index page. Important part is `/` at the ending.
`ruby main.rb https://example.com/viewer.php?fileview=` for path traversal through the file viewers. Link must end with `=`

Incorrect usage:
```
ruby main.rb https://example.com
ruby main.rb https://example.com/index.html
ruby main.rb https://example.com/viewer.php?fileview=23.jpg
ruby main.rb https://example.com/viewer.php?fileview
ruby main.rb https://example.com/viewer.php
```

# TOOL IS STILL IN DEVELOPMENT

In case of encountering any errors or having any advancement ideas contact me through my protonmail or linkedin.

```
#include <stdio.h>

int main() {
    printf("HACK THE PLANET\n");
    return 0;
}
```
