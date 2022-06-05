class Token {
  String _token =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbWhhem5pZkBnbWFpbC5jb20iLCJleHAiOjE2NTQzOTQ3NjgsImlhdCI6MTY1NDM3Njc2OH0.7OjD81-Zl6Zvn5dDVjIEVlYCc0YOjhDMyzPljt-CX2h5f4pvdwICawGsPjfIpjxl0y-QiIGUYKodGrSHFg_ibg";

  set toke(String token) {
    _token = "Bearer " + token;
  }

  String get token => _token;
}
