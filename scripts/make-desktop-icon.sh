#!/bin/bash

SERVICE_NAME=mysql-workbench

here=$(cd "$(dirname "$0")"; pwd)
root=$(cd "$here/.."; pwd)

container_name=mysql-workbench-icon-tmp-$RANDOM
tmpdir=$(mktemp -d)

trap 'rm -rf "'"$tmpdir"'"; docker stop "'"$container_name"'"' EXIT

docker compose --project-directory "$root" run --rm --name "$container_name" --entrypoint "" -d "$SERVICE_NAME" /bin/bash

for size in 16 24 32 48 64 96 128; do
  docker cp "$container_name:/usr/share/icons/hicolor/${size}x$size/apps/mysql-workbench.png" "$tmpdir/$size.png"
  xdg-icon-resource install --size "$size" "$tmpdir/$size.png" mysql-workbench
done

cat "$root/resources/mysql-workbench.desktop.template" | sed -E 's|%PATH%|'"$root"'|g' > "$tmpdir/mysql-workbench.desktop"
xdg-desktop-icon install "$tmpdir/mysql-workbench.desktop"
