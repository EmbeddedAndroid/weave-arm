FROM forcedinductionz/aarch64-centos7-datacenter:latest
COPY libpcap.a /usr/lib64/libpcap.a
RUN yum clean all && yum install -y golang git libpcap glibc-static libpcap-devel python-requests time file
ENV GOPATH=/go/
RUN go get github.com/golang/lint/golint github.com/fzipp/gocyclo github.com/client9/misspell/cmd/misspell
RUN go clean -i net && go install -tags netgo std
RUN go install -tags netgo std
COPY build.sh /
ENTRYPOINT ["sh", "/build.sh"]
