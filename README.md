# SNS 방식의 게시판

## 기본 UI 화면 관련 파일

### main.jsp

- 로그인 전 메인 화면입니다. 사이트에 올라온 모든 글이 뜹니다.
  ![](./Screenshot/1.png)

### main_after_login.jsp

- 로그인 후 메인 화면입니다. 로그인 후 할수 있는 기능들이 추가됩니다.
  ![](./Screenshot/2.png)

### default.css

- 모든 화면의 css 정보를 담고 있습니다.

### detailed_article.jsp

- 글 세부보기 페이지로 더보기로 가려진 부분들을 볼 수 있습니다. 하나의 글만 뜹니다.
  ![](./Screenshot/3.png)

## 회원 관련 파일

### user_add.jsp

- 회원가입버튼 클릭시 연결되는 페이지로 신규 회원 정보등을 입력할 수 있습니다.
  ![](./Screenshot/4.png)
  ![](./Screenshot/20.png)

### user_add_do.jsp

- db에 신규 회원정보를 입력하는 기능을 합니다. 입력받은 id가 기존 db에 있는 것과 동일하면 경고창이 뜨고 등록되지 않습니다.
  ![](./Screenshot/19.png)

### user_modify.jsp

- 회원정보 수정 페이지로 로그인 된 상태에서 메뉴의 회원정보 수정버튼을 통해 접근할 수 있으며 양식은 user_add.jsp와 같습니다. 입력칸에 기존 회원 정보가 미리 입력됩니다.
  ![](./Screenshot/5.png)

### user_modify_do.jsp

- 수정된 회원정보를 db에 업데이트 하는 기능을 합니다.

### login.jsp

- main.jsp에서 로그인창에 아이디 비밀번호를 입력받은 후 로그인 버튼을 누르면 연결되는 페이지입니다. db의 유저정보와 일치하면 로그인 됩니다. 로그인 후 main_after_login.jsp로 연결됩니다.
  ![](./Screenshot/6.png)
  ![](./Screenshot/7.png)

### logout.jsp

- 로그아웃하는 기능입니다. 로그아웃 이후 main.jsp로 연결됩니다.

## 게시글 관련 파일

### input.jsp

- 로그인후 메뉴의 글 작성 버튼으로 들어올수 있습니다. 글 작성과 파일을 첨부 할수 있습니다.
  ![](./Screenshot/8.png)
  ![](./Screenshot/21.png)

### input_do.jsp

- 작성된 글을 db에 올리는 기능을 합니다.

### modify.jsp

- 작성된 글을 수정하는 페이지입니다. 양식은 input.jsp와 같고 입력칸에 기존 글의 정보가 미리 입력되어있습니다.
  ![](./Screenshot/9.png)

### modify_do.jsp

- 수정된 글을 db에 업데이트 하는 기능을 합니다.

### delete_file_do.jsp

- 게시글 수정 페이지에서 첨부된 파일 목록에서 삭제 버튼을 누르면 연결되며 첨부파일일 하나를 삭제하는 기능을 합니다.

### delete_do.jsp

- 게시글을 삭제하는 기능을 합니다.
  ![](./Screenshot/15.png)

## 댓글 관련 파일

### comment_add_do.jsp

- 글 세부보기페이지에서 접근할 수 있고 입력된 댓글을 db에 저장하는 기능을 합니다.
  ![](./Screenshot/10.png)

### comment_modify.jsp

- 댓글 수정 버튼을 누를 때 연결되고 댓글을 수정할 수 있습니다.
  ![](./Screenshot/11.png)

### comment_modify_do.jsp

- 수정된 댓글을 db에 업데이트 하는 기능을 합니다.

### comment_delete_do.jsp

- 댓글을 삭제하는 기능을 합니다.
  ![](./Screenshot/12.png)

## 검색 관련 파일

### search.jsp

- 게시글에 관한 검색을 하는 기능을 합니다. 로그인 여부와 상관없이 접근 가능합니다.
  ![](./Screenshot/13.png)

### search_do.jsp

- 입력된 검색어에 따른 결과를 보여주는 페이지입니다.
  ![](./Screenshot/14.png)

## 인기글 관련 파일

### popular.jsp

- 모든 게시글들 좋아요, 조회수, 댓글 수 순으로 정렬해 볼 수 있는 페이지입니다.
  ![](./Screenshot/16.png)

## 좋아요 관련 파일

### likes_do.jsp

- 게시글에 좋아요를 누르면 db에 좋아요를 저장하는 기능을 합니다. 로그인되어있지 않으면 좋아요를 누를수 없습니다.
  ![](./Screenshot/17.png)

## 내가 쓴 글 모음 관련 파일

### myboard.jsp

- 로그인된 상태에서 내가쓴 게시글을 모아서 정렬해 볼 수 있는 페이지입니다.
  ![](./Screenshot/18.png)
