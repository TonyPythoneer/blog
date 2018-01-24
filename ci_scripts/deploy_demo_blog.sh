#!/usr/bin/env bash
cd ./public

REPOSITORY="TonyPythoneer/blog.git"
TARGET_BRANCH="gh-pages"

CURRENT_DATE=`date +"%Y-%m-%d %T %:z"`
COMMIT_MESSAGE="Site updated ${CURRENT_DATE}"

git init
git config user.name "${AUTHOR_NAME}"
git config user.email "${AUTHOR_EMAIL}"
git add --all .
git commit -m "${COMMIT_MESSAGE}"
git push --force --quiet https://${GITHUB_TOKEN}@github.com/${REPOSITORY} master:${TARGET_BRANCH}