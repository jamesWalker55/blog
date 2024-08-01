SERVE_PORT := "54244"

serve:
    hugo server --port "{{SERVE_PORT}}"

# Usage:
# just new hello-world
new stem:
    hugo new content "content/blog/{{stem}}.md"
