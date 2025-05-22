# Examples of Git Hooks

## Overview
Git hooks are Git's in-built method of triggering scripts based on actions. This repo's purpose is to provide an overview of the different types of git hooks and example use cases.

## Implementation
Hooks are stored in .git/hooks folder. 
By default .git/hooks will be populated with example hooks, if you want to enable them:
1. Remove the ".sample" suffix from the file name
2. Make the hook executable using: `chmod +x .git/hooks/hook-name`
3. Run `npm i` to install them

## Examples
### pre-commit
Looks at staged code
- formatting code
- running linters
- running unit tests
- checking file size or lines of code (could enforce a per file limit)
- blocking certain code (e.g console.log)

[prevent-console-logs](hooks/examples/pre-commit.prevent-console-logs):
Checks if any staged files contain "console.log", if so, cancels the commit and tells the user what file and line the log is on
![pre-commit example - prevent console logs](screenshots/prevent-console-logs.png)

### commit-msg
Runs after commit command, can change the contents of a commit message.
- Adding ticket number to commit msg
- Enforcing commit message format - blocking vague messages (e.g. fix)

[include-ticket-number](hooks/examples/commit-msg.include-ticket-number):
Add ticket numbers to commit messages if they are missing, prevents commits to branches without ticket numbers in their name. This means direct commits to master will be prevented. 

Note: pre-commit and commit-msg can be bypassed with `git commit --no-verify`

### pre-push
Looks at all commits since the last push (not just the last staged)
- run the app for test
- check if secrets are staged for push

### pre-merge-commit post-merge
- notify team via slack

## Committing Hooks

Git hooks are ignored by default. If you want to commit them, follow these steps: 

1. Create a `hooks/` directory in your repository to store the hooks:
   ```bash
   mkdir hooks
   ```
2. Move your hook scripts (e.g., commit-msg) to the hooks directory:
   ```bash
    mv .git/hooks/commit-msg hooks/
    ```
3. Add hooks to version control:
   ```bash
    git add hooks/commit-msg
    git commit -m "Add commit-msg hook"
    ```
4. Create a setup-hooks.sh script to install the hooks:
    ```bash
    #!/bin/bash
    cp hooks/* .git/hooks/
    chmod +x .git/hooks/*
    ```
5. Make the script executable:
    ```bash
    chmod +x setup-hooks.sh
    ```
6. Run the script to install the hooks:
    ```bash
    ./setup-hooks.sh
    ```

## Alternative: Using Husky
For Node.js projects, you can use [Husky](https://typicode.github.io/husky/) to manage Git hooks more easily. Husky automatically sets up Git hooks when you install it and manages them through your package.json. To install:

```bash
npm install husky --save-dev
npx husky install
```

You can then store hooks in .husky and they will automatically be installed the next time you run `npm i`. You can commit husky files directly with no need to copy them to the .git/hooks folder.  

## Resources

- [Customizing Git Hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [Git Repo - Git Hook Templates ](https://github.com/git/git/tree/master/templates/hooks)
