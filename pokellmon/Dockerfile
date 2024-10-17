FROM ubuntu

RUN apt-get update &&\
    apt-get install -y sbcl curl rlwrap build-essential time && \
    cd /tmp && curl -O http://tenet.dl.sourceforge.net/project/sbcl/sbcl/2.4.9/sbcl-2.4.9-source.tar.bz2 && tar jxvf sbcl-2.4.9-source.tar.bz2 && cd /tmp/sbcl-2.4.9 && sh ./make.sh  && sh ./install.sh && rm -rf /tmp/sbcl* &&\
    apt-get remove -y sbcl && \
    cd /tmp && curl -O https://beta.quicklisp.org/quicklisp.lisp && echo "(load \"quicklisp.lisp\") (quicklisp-quickstart:install :path \"/opt/quicklisp\") (ql::without-prompting (ql:add-to-init-file))" | sbcl && cp $HOME/.sbclrc /etc/sbclrc &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /pokellmon

COPY . .

RUN chmod +x run.sh

ENTRYPOINT ["/pokellmon/run.sh"]
