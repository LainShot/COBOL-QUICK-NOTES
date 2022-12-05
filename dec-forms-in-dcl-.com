$ INIT_FORMS

$ window = CREATE_WINDOW(200, 200, 400, 300, "Login")
$ form = CREATE_FORM(window, 10, 10, 380, 280)

$ username_field = CREATE_STRING(form, "Username:", 20, 20, 150, 25)
$ password_field = CREATE_STRING(form, "Password:", 20, 60, 150, 25)
$ login_button = CREATE_BUTTON(form, "Login", 20, 100, 150, 25)

$ loop:
$    ! Check if the user clicked the login button
$    if LOGIN_BUTTON_PRESSED(login_button) then goto handle_login
$    goto loop

$ handle_login:
$    ! Get the user's input
$    username = GET_STRING(username_field)
$    password = GET_STRING(password_field)

$    ! Handle the login attempt
$    ! ...

$    exit
