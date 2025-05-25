# Examples of Git Hooks

## Overview
Git hooks are Git's in-built method of triggering scripts based on actions. This repo's purpose is to provide an overview of the different types of git hooks and example use cases.

## Implementation
Hooks are stored in .git/hooks folder. 
By default .git/hooks will be populated with example hooks, if you want to enable them:
1. Remove the ".sample" suffix from the file name
2. Make the hook executable using: `chmod +x .git/hooks/hook-name`
3. Run `npm i` to install them

## Different Types of Hooks
### pre-commit
Analyses staged code

Example Use Cases: 
- blocking certain code (e.g console.log)
- checking file size or lines of code exceeds limit
- formatting code
- running linters
- running unit tests

[prevent-console-logs](hooks/examples/pre-commit.prevent-console-logs):
Checks if any staged files contain "console.log", if so, cancels the commit and tells the user what file and line the log is on.

![pre-commit example - prevent console logs](screenshots/prevent-console-logs.png)

[limit-line-number](hooks/examples/pre-commit.limit-line-number):
Checks if any staged files contain more than a specified line number, if so, cancels the commit and tells the user what files exceed the limit

![pre-commit example - limit line number](screenshots/limit-line-number.png)

### commit-msg
Runs after commit command, can change the contents of a commit message.

Example Use Cases: 
- Adding ticket number to commit msg
- Enforcing commit message format - blocking vague messages (e.g. fix)

[include-ticket-number](hooks/examples/commit-msg.include-ticket-number):
Add ticket numbers to commit messages if they are missing, prevents commits to branches without ticket numbers in their name. This means direct commits to master will be prevented. 

![commit-msg example - include ticket number](screenshots/include-ticket-number.png)

> [!NOTE]
> **pre-commit** and **commit-msg** hooks can be bypassed with `git commit --no-verify`

### pre-push
Looks at all commits since the last push (not just the last staged)

Example Use Cases: 
- run the app for testing
- check if secrets are staged for push

### pre-merge-commit post-merge

Example Use Cases: 
- notify team via slack

## Committing Hooks

Git hooks are ignored by default. If you want to commit them, follow these steps: 

1. Create a `hooks/` directory in your repository to store the hooks:
   ```bash
   mkdir hooks
   ```
2. Add hooks to version control:
   ```bash
    git add hooks/commit-msg
    git commit -m "Add commit-msg hook"
    ```
3. Create a setup-hooks.sh script to install the hooks:
    ```bash
    #!/bin/bash
    cp hooks/* .git/hooks/
    chmod +x .git/hooks/*
    npm i
    ```
4. Make the script executable:
    ```bash
    chmod +x setup-hooks.sh
    ```
5. Run the script:
    ```bash
    ./setup-hooks.sh
    ```
> [!NOTE]
> Optional: Add a script to your package.json, so you can run it with `npm run setup` instead
> 
> ```json
> "scripts": {
>   "setup": "./setup-hooks.sh"
> }
> ```



## Alternative: Using a Git Hook Manager (Husky)
For Node.js projects, you can use [Husky](https://typicode.github.io/husky/) to manage Git hooks more easily. Husky automatically sets up Git hooks when you install it and manages them through your package.json.
To install and initialise husky in your project, run:

```bash
npm install husky --save-dev
npx husky install
```

You can then store hooks in .husky/hooks and they will be installed the next time you run `npm i`. You can commit husky files directly with no need to copy them to the .git/hooks folder.  

## Resources

- [Customizing Git Hooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)
- [Git Repo - Git Hook Templates ](https://github.com/git/git/tree/master/templates/hooks)
