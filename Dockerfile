# 安装Gopls
FROM golang:1.18.2-alpine AS gopls


ENV GOPROXY https://goproxy.cn,https://goproxy.io,https://mirrors.aliyun.com/goproxy,direct


RUN sed -i "s/dl-cdn\.alpinelinux\.org/mirrors.ustc.edu.cn/" /etc/apk/repositories
RUN go install golang.org/x/tools/gopls@latest





# 打包真正的镜像
FROM storezhang/alpine


LABEL author="storezhang<华寅>"
LABEL email="storezhang@gmail.com"
LABEL qq="160290688"
LABEL wechat="storezhang"
LABEL description="Gopls镜像，对外提供功能"


# 复制文件
COPY --from=gopls /usr/local/go/bin/go /usr/local/go/bin/go
COPY --from=gopls /go/bin/gopls /usr/bin/gopls
COPY docker /


# 增加执行权限
RUN set -ex \
  \
  \
  \
  # 增加执行权限
  && chmod +x /etc/s6/gopls/* \
  && chmod +x /usr/bin/restart \
  \
  \
  \
  && rm -rf /var/cache/apk/*


# 配置环境变量
ENV PORT 7374
ENV PATH ${PATH}:/usr/local/go/bin
ENV GOPATH /var/lib/go
ENV GO111MODULE on
ENV GOPROXY https://goproxy.cn,https://mirrors.aliyun.com/goproxy,direct

# 开放端口
EXPOSE ${PORT}
