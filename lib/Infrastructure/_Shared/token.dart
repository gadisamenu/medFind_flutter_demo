class Token {
  String _token =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbWhhem5pZkBnbWFpbC5jb20iLCJleHAiOjE2NTQ0MzYyMjksImlhdCI6MTY1NDQxODIyOX0.BWGM7ONW27fOhEEwcT_aaUIIPoJIAAEEfIBI_E_F3TZAwsLHOsny_kPUWgEOAeRjnegjPdu1dqZNbISRkCcwUA";

  set toke(String token) {
    _token = "Bearer " + token;
  }

  String get token => _token;
}
