#ws_pty.js가 copy되어 있는 이미지를 가져온다.
FROM polhub/ws-base:s1001

# 기존 환경 변수 및 사용자 설정을 유지할 수 있습니다.
ENV stage=stage_ls
ARG stage=stage_ls

# 사용자 추가
RUN useradd -ms /bin/bash $stage
RUN echo "$stage:0000" | chpasswd

#접속시 출력 화면 파일 복사
COPY start.sh /home/$stage/
WORKDIR /home/$stage
RUN echo | cat start.sh >> .bashrc
RUN rm -rf start.sh

# 소유권 변경
RUN chown -R $stage /home/$stage

# 사용자 변경
USER $stage

#ls 문제작성
RUN mkdir /home/$stage/$stage
WORKDIR /home/$stage/$stage
RUN touch file1234.txt

WORKDIR /usr/agent

# 웹소켓 서버 실행 명령. 'ws_pty.js'는 웹소켓 서버의 메인 파일이라고 가정합니다.
CMD ["node", "app.js"]
