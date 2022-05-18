# 最新版パッケージ利用のため Arch Linux を利用
FROM lopsided/archlinux:latest

# ビルド高速化のため国内のアップデートサーバを指定
RUN (case $(uname -m) in \
  aarch*|arm*) \
    echo 'Server = https://jp.mirror.archlinuxarm.org/$arch/$repo' \
  ;; \
  x86_64) \
    echo 'Server = https://mirrors.edge.kernel.org/archlinux/$repo/os/$arch' \
  ;; \
  esac) > /etc/pacman.d/mirrorlist

# パッケージのインストール
RUN pacman -Syu --noconfirm \
  && pacman -S --noconfirm \
    awk \
    gnome-keyring \
    grep \
    mysql-workbench \
    noto-fonts \
    noto-fonts-cjk \
  && pacman -Scc --noconfirm

# デバッグ用: プロファイルのインストール
RUN cp /etc/skel/{.bash_logout,.bash_profile,.bashrc} /root

# 起動用スクリプトのインストール
COPY ./resources/docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
