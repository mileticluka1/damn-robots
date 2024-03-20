# Damn Robots
Smaller project inspired by Portswigger Web Security Academy Path Traversal labs.\n
Project started as basic sensitive file disclosure scanner but I wanted to implement my knowledge in encoding algorithms combined with web application penetration testing.

# Requirements (gems)
```
net-http
```

# Usage
Point with this program was to be proof of concept so I made it's usage very simple:\n
`ruby main.rb https://example.com/` in case of scanning the index page. Important part is `/` at the ending.\n
`ruby main.rb https://example.com/viewer.php?fileview=` for path traversal through the file viewers. Link must end with `=`
## Arguments
With argument `--wordlist` you specify text file that contains wordlist with custom payloads.\n
With argument `--skip-default-payloads` you skip built-in payloads and go straight to wordlist running.

# How it works
Step 1 (default): Checks for the most common misconfiguration files\n
Step 2 (default): Runs the path traversal payloads (gets /etc/passwd)\n
Step 3 (default): Runs the path traversal obfuscation payloads (gets /etc/passwd)\n
Step 4 (optional): Runs the custom wordlist that includes custom payloads throught the argument `--wordlist`\n
\n
Incorrect usage:\n
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
