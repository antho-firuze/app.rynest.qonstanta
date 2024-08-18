const int err_token_invalid = 9000;
const int err_token_expired = 9001;
const int err_member_not_in_schedule = 8000;
const int err_member_schedule_expired = 8001;
const int err_tryout_not_started = 8002;
const List<int> mustLogin = [err_token_invalid, err_token_expired];
const List<int> mustLogout = [
  err_member_not_in_schedule,
  err_member_schedule_expired
];
