$comment = Read-Host -Prompt 'Input commit comment'
git add "."
git pull origin main
git commit -m "project updated"
git push --progress