import 'package:stacked_services/stacked_services.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'id_ID': {
          "info": "Informasi",
          "error": "Opss...",
          "confirm": "Konfirmasi",
          "retry": "Coba lagi",
          "close": "Tutup",
          "ok": "OK",
          "yes": "Ya",
          "no": "Tidak",
          "change_pwd_title": "Ubah Password",
          "change_pwd_subtitle": "Masukkan password lama kamu terlebih dahulu",
          "change_pwd_btn": "Simpan",
          "forgot_pwd_title": "Lupa Password",
          "forgot_pwd_subtitle":
              "Kamu akan menerima 4 digit kode melalui email, untuk selanjutnya akan di verifikasi.\n\nSilahkan masukkan Email kamu",
          "forgot_pwd-btn": "Kirim OTP",
          "otp_title": "Konfirmasi OTP",
          "otp_subtitle": "Kode OTP telah dikirim ke %s",
          "otp_footer": "Kode ini akan kadaluarsa dalam",
          "otp_footer2": "Tidak menerima kode ? ",
          "otp_resend": "Kirim ulang",
          "reset_pwd_title": "Reset Password",
          "reset_pwd_subtitle": "Silahkan masukkan password baru kamu",
          "reset_pwd_btn": "Simpan",
          "signin_title": "Selamat Datang",
          "signin_subtitle": "Silahkan masuk menggunakan akun kamu",
          "signin_btn": "Sign In",
          "signup_title": "Form Registrasi",
          "signup_subtitle": "Silahkan lengkapi form di bawah ini",
          "signup_btn": "Registrasi",
          "username": "Email / Username",
          "forgot_password": "Lupa Sandi ?",
          "not_have_account": "Belum punya akun?, yuk daftar ",
          "password_confirm": "Konfirmasi Password",
          "password_confirm-not-match": "Password Konfirmasi tidak sama !",
          "fullname": "Nama Lengkap",
          "phone": "Nomor Telepon",
          "required": "Harap di isi !",
          "have_account": "Sudah punya akun?, login ",
          "here": "disini",
          "do-you-want-try-again": "Kamu ingin mencoba lagi ?",
          "please-re-login":
              "Sepertinya kamu pernah login di device yang berbeda.\nApakah kamu mau login ulang disini ?",
          "do-you-want-quit": "Apakah kamu ingin keluar ?",
          "do-you-want-logout": "Apakah kamu ingin logout ?",
          "another-login-device":
              "Kamu baru saja login di perangkat [%s] yang lain.",
          "do-you-want-re-login": "Apakah kamu ingin login ulang ?",
          "error_api_cancel": "Permintaan ke Server API dibatalkan",
          "error_api_conntimeout": "Batas waktu koneksi ke Server API habis",
          "error_api_recvtimeout": "Batas waktu terima ke Server API habis",
          "error_api_sendtimeout": "Batas waktu kirim ke Server API habis",
          "error_api_response":
              "Balasan dari Server API tidak valid, dengan Status Code: %s",
          "error_api_other":
              "Koneksi ke Server API gagal, karena tidak ada koneksi internet",
          "error_firebase_login":
              "Mohon maaf, login (firebase) sedang bermasalah. Silahkan coba beberapa saat lagi !",
          "error_firebase_email-already-in-use":
              "Email Account yang anda masukkan sudah terdaftar, silahkan gunakan email yang lain.",
          "error_firebase_invalid-email":
              "Email anda tidak valid, gunakan email yang valid.",
          "error_firebase_operation-not-allowed":
              "The authentication is not enabled on Firebase. Please enable the Authentitcation type on Firebase",
          "error_firebase_weak-password":
              "Password terlalu sederhana. Gunakan password yang rumit.",
          "error_firebase_wrong-password":
              "Password yang anda masukkan salah. Silahkan masukkan ulang password yang benar.",
          "error_firebase_network-request-failed":
              "Terjadi kesalahan jaringan (seperti waktu habis, koneksi terputus, atau host tidak dapat dijangkau).",
          "error_firebase_default":
              "Ada yang salah di Server (firebase) kami. Silahkan coba beberapa saat lagi !",
          "error_validate_password": "Password tidak valid.",
          "invalid_token": "Token tidak valid",
          "insert_success": "Tambah data berhasil",
          "update_success": "Rubah data berhasil",
          "delete_success": "Hapus data berhasil",
          "insert_failed": "Tambah data gagal !\r\n%s",
          "update_failed": "Rubah data gagal !\r\n%s",
          "delete_failed": "Hapus data gagal !\r\n%s",
          "delete_confirm": "Anda yakin ingin hapus data ?",
          "check_username_password": "Masukkan username/email dan password",
          "check_username": "Masukkan Username/Email",
          "check_password": "Masukkan Password",
          "check_fullname": "Masukkan Nama Lengkap",
          "check_phone": "Masukkan No WhatsApp",
          "check_gender": "Masukkan Jenis Kelamin",
          "check_dateOfBirth": "Masukkan Tanggal Lahir",
          "check_address": "Masukkan Alamat",
          "success_signin": "Login berhasil",
          "success_signup": "Registrasi berhasil",
          "info_data_empty": "Data tidak ditemukan",
        },
        'en_US': {
          "info": "Information",
          "error": "Opss...",
          "confirm": "Confirmation",
          "retry": "Retry",
          "close": "Close",
          "ok": "OK",
          "yes": "Yes",
          "no": "No",
          "change_pwd_title": "Change Password",
          "change_pwd_subtitle": "Please enter your old password",
          "change_pwd_btn": "Submit",
          "forgot_pwd_title": "Forgot Password",
          "forgot_pwd_subtitle":
              "You will receive 4 digits code via email, for further verification.\n\nPlease enter your e-mail",
          "forgot_pwd-btn": "Send OTP",
          "otp_title": "OTP Confirmation",
          "otp_subtitle": "OTP Code has been sent to %s",
          "otp_footer": "This code will be expired in",
          "otp_footer2": "Don't receive the Code ? ",
          "otp_resend": "Re-send",
          "reset_pwd_title": "Reset Password",
          "reset_pwd_subtitle": "Please enter your new password",
          "reset_pwd_btn": "Submit",
          "signin_title": "Welcome",
          "signin_subtitle": "Please sign to your account",
          "signin_btn": "Sign In",
          "signup_title": "Sign Up",
          "signup_subtitle": "Please complete the form below",
          "signup_btn": "Register",
          "username": "Email / Username",
          "forgot_password": "Forgot Password ?",
          "not_have_account": "Don't have an account yet?, let's Sign Up ",
          "password_confirm": "Password Confirm",
          "password_confirm-not-match": "Password Confirm not match !",
          "fullname": "Full Name",
          "phone": "Phone Number",
          "required": "Please fill this column !",
          "have_account": "Do you have Account?, login ",
          "here": "here",
          "do-you-want-try-again": "Do you want to try again ?",
          "please-re-login":
              "Looks like you've logged in on a different device.\nPlease Re-Login ?",
          "do-you-want-quit": "Do you want to quit ?",
          "do-you-want-logout": "Do you want to logout ?",
          "another-login-device":
              "You just logged in on another [%s] device.\nDo you want to re-login ?",
          "do-you-want-re-login": "Do you want to re-login ?",
          "error_api_cancel": "Request to API server was cancelled",
          "error_api_conntimeout": "Connection timeout with API server",
          "error_api_recvtimeout":
              "Receive timeout in connection with API server",
          "error_api_sendtimeout": "Send timeout in connection with API server",
          "error_api_response": "Received invalid status code: %s",
          "error_api_other":
              "Connection to API Server failed due to internet connection",
          "error_firebase_login":
              "We could not log into your account at this time. Please try again.",
          "error_firebase_email-already-in-use":
              "An account already exists for the email you\'re trying to use. Login instead.",
          "error_firebase_invalid-email":
              "The email you\'re using is invalid. Please use a valid email.",
          "error_firebase_operation-not-allowed":
              "The authentication is not enabled on Firebase. Please enable the Authentitcation type on Firebase",
          "error_firebase_weak-password":
              "Your password is too weak. Please use a stronger password.",
          "error_firebase_wrong-password":
              "You seemed to have entered the wrong password. Double check it and try again.",
          "error_firebase_network-request-failed":
              "A network error (such as timeout, interrupted connection or unreachable host) has occurred.",
          "error_firebase_default":
              "Something went wrong on our side. Please try again",
          "error_validate_password": "The current password is not valid.",
          "invalid_token": "Invalid token",
          "insert_success": "Adding data success",
          "update_success": "Update data success",
          "delete_success": "Data has been Deleted",
          "insert_failed": "Adding data failed !\r\n%s",
          "update_failed": "Update data failed !\r\n%s",
          "delete_failed": "Delete data failed !\r\n%s",
          "delete_confirm": "Are you sure to Delete ?",
          "check_username_password": "Input username/email and password",
          "check_username": "Input Username/Email",
          "check_password": "Input Password",
          "check_fullname": "Input Full Name",
          "check_phone": "Input WhatsApp Number",
          "check_gender": "Input the gender",
          "check_dateOfBirth": "Input Date of Birth",
          "check_address": "Input Address",
          "success_signin": "Login success",
          "success_signup": "Registration success",
          "info_data_empty": "Data is not found",
        },
      };
}