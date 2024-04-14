#!/bin/sh

API_URL="https://api.github.com/repos/SinzMise/artalk-deploy/releases/latest"
DOWNLOAD_URL=$(curl -s $API_URL | jq -r ".assets[] | select(.name == \"Artalk-freebsd-amd64.tar.gz\") | .browser_download_url")
curl -L $DOWNLOAD_URL -o ./bak/artalk-freebsd-amd64.tar.gz
tar -xzvf ./data/artalk-freebsd-amd64.tar.gz && cp -f ./data/artalk ./artalk && rm ./data/artalk-freebsd-amd64.tar.gz && chmod +x artalk

if [ -f "./data/ip2region.xdb" ]; then
    rm ./data/artalk
    rm ./data/artalk.yml
    echo "Artalk-FreeBSD最新版本已经下载覆盖完成！"
else
    curl -L https://github.com/lionsoul2014/ip2region/raw/master/data/ip2region.xdb -o ./data/ip2region.xdb
    cp -f ./data/artalk.yml ./artalk.yml
    nohup ./artalk server > /dev/null 2>&1 &
    rm ./data/artalk
    rm ./data/artalk.yml
    clear
    echo "已生成配置文件，请修改端口！"
    echo
    echo "使用命令 vim artalk.yml 修改artalk.yml文件"
    echo
    echo "将 port: 23366中的 23366 修改成你放行的端口即可"
    echo
    echo "接着按 Esc 键退出插入模式，再按 : 键进入命令模式，并输入 wq 再回车，保存并退出"
    echo
    echo "再使用命令 cd .. 回到上级目录"
    echo
fi
