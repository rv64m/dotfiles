# enable proxy
function wsl_proxy
    set current_ip (cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
    set -Ux http_proxy http://$current_ip:17890
    set -Ux https_proxy http://$current_ip:17890

    echo "Proxy enabled. HTTP_PROXY=$http_proxy, HTTPS_PROXY=$https_proxy"
end


# disable proxy
function wsl_unproxy
    set -e http_proxy
    set -e https_proxy
end

function wsl_git_proxy
    set current_ip (cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
    git config --global http.proxy socks5://$current_ip:17890
    git config --global https.proxy socks5://$current_ip:17890

    echo "Git proxy enabled. HTTP_PROXY=$http_proxy, HTTPS_PROXY=$https_proxy"
end

function wsl_ungit_proxy
    git config --global --unset http.proxy
    git config --global --unset https.proxy

    echo "Git proxy disabled."
end
