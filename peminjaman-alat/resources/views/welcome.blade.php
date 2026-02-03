<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign in</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    {{-- Bootstrap --}}
    <link rel="stylesheet" href="{{ asset('assets/bootstrap/css/bootstrap.min.css') }}">

    {{-- Font Awesome --}}
    <link rel="stylesheet" href="{{ asset('assets/fontawesome/css/all.min.css') }}">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f6f8fa;
        }

        .login-card {
            max-width: 380px;
            width: 100%;
        }

        .btn-social {
            border: 1px solid #d0d7de;
            background: #fff;
            font-weight: 500;
        }

        .btn-social:hover {
            background: #f6f8fa;
        }

        .dark-mode {
            background-color: #0d1117 !important;
            color: #c9d1d9;
        }

        .dark-mode .card {
            background-color: #161b22;
            border-color: #30363d;
        }

        .dark-mode input {
            background-color: #0d1117;
            border-color: #30363d;
            color: #c9d1d9;
        }
        .dark-mode .form-label {
            color: #c9d1d9;
        }

        .dark-mode .btn-social {
            background-color: #0d1117;
            border-color: #30363d;
            color: #c9d1d9;
        }

        .dark-mode .btn-social:hover {
            background-color: #161b22;
        }

        .dark-mode a {
            color: #58a6ff;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center vh-100">

<div class="login-card text-center">

    {{-- Dark Mode Toggle --}}
    <div class="text-end mb-2">
        <button class="btn btn-sm btn-outline-secondary" onclick="toggleDarkMode()">
            <i class="fa-solid fa-moon"></i>
        </button>
    </div>

    {{-- Logo --}}
    <div class="fs-1 mb-2"><i class="fa-solid fa-screwdriver-wrench text-success text-sm opacity-10"></i></div>
    <h4 class="mb-3">Masuk Ke Aplikasi</h4>

    {{-- ERROR --}}
    @if(session('error'))
        <div class="alert alert-danger py-2">
            {{ session('error') }}
        </div>
    @endif

    {{-- LOGIN FORM --}}
    <div class="card shadow-sm mb-3">
        <div class="card-body text-start">

            <form method="POST" action="/login">
                @csrf

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" required>
                </div>

                <div class="mb-3">
                    <div class="d-flex justify-content-between">
                        <label class="form-label">Password</label>
                        <a href="#" class="small">Forgot password?</a>
                    </div>
                    <input type="password" name="password" class="form-control" required>
                </div>

                <button class="btn btn-success w-100">Sign in</button>
            </form>

        </div>
    </div>

    {{-- DIVIDER --}}
    <div class="text-muted small mb-2">or</div>

    {{-- SOCIAL LOGIN (UI ONLY) --}}
    <div class="d-grid gap-2 mb-3">
        <button class="btn btn-social">
            <i class="fa-brands fa-google me-2 text-danger"></i> Continue with Google
        </button>

        <button class="btn btn-social">
            <i class="fa-brands fa-twitter me-2 text-info"></i> Continue with Twitter
        </button>

        <button class="btn btn-social">
            <i class="fa-brands fa-facebook me-2 text-primary"></i> Continue with Facebook
        </button>
    </div>

    {{-- FOOTER --}}
    <div class="small">
        New here? <a href="#">Create an account</a>
    </div>

</div>

{{-- Bootstrap JS --}}
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function toggleDarkMode() {
        document.body.classList.toggle('dark-mode');
    }
</script>

</body>
</html>
