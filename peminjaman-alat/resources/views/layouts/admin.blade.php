
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="./assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="{{ asset('assets/argon-dashboard-master/assets/img/favicon.png')}}">
  <title>
    Argon Dashboard 2 by Creative Tim
  </title>
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="{{ asset('assets/argon-dashboard-master/assets/css/nucleo-icons.css') }}" rel="stylesheet" />
  <link href="{{ asset('assets/argon-dashboard-master/assets/css/nucleo-svg.css') }}" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  {{-- <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script> --}}
  <link href="{{ asset('assets/argon-dashboard-master/assets/css/nucleo-svg.css')}}" rel="stylesheet" />
  <!-- CSS Files -->
  <link id="pagestyle" href="{{ asset('assets/argon-dashboard-master/assets/css/argon-dashboard.css?v=2.0.4')}}" rel="stylesheet" />
  <link rel="stylesheet" href="{{ asset('assets/fontawesome/css/all.css') }}">
</head>


<body class="g-sidenav-show   bg-gray-100">
  <div class="min-height-300 bg-primary position-absolute w-100"></div>
    @include('admin.partials.sidebar')
  <main class="main-content position-relative border-radius-lg ">
    <!-- Navbar -->
    @include('admin.partials.navbar')
    <!-- End Navbar -->
    <div class="container-fluid py-4">
      @yield('content')
      @include('admin.partials.footer')
    </div>
  </main>

  @if(session('success'))
    <div class="toast-container position-fixed top-0 end-0 p-3">
        <div class="toast align-items-center text-bg-success border-0 show">
            <div class="d-flex">
                <div class="toast-body" style="color: white">
                    {{ session('success') }}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>
    @endif

    @if(session('error'))
    <div class="toast-container position-fixed top-0 end-0 p-3">
        <div class="toast align-items-center text-bg-danger border-0 show">
            <div class="d-flex">
                <div class="toast-body" style="color: white">
                    {{ session('error') }}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>
    @endif
    <style>
.pagination .page-link {
    border-radius: 8px;
    margin: 0 4px;
}

.pagination .page-item.active .page-link {
    background-color: #5e72e4; /* warna argon */
    border-color: #5e72e4;
    color: white
}
</style>

  <!--   Core JS Files   -->
  <script src="{{ asset('assets/argon-dashboard-master/assets/js/core/popper.min.js')}}"></script>
  <script src="{{ asset('assets/argon-dashboard-master/assets/js/core/bootstrap.min.js')}}"></script>
  <script src="{{ asset('assets/argon-dashboard-master/assets/js/plugins/perfect-scrollbar.min.js')}}"></script>
  <script src="{{ asset('assets/argon-dashboard-master/assets/js/plugins/smooth-scrollbar.min.js')}}"></script>
  <script src="{{ asset('assets/argon-dashboard-master/assets/js/plugins/chartjs.min.js')}}"></script>
  <script>
    var ctx1 = document.getElementById("chart-line").getContext("2d");

    var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

    gradientStroke1.addColorStop(1, 'rgba(94, 114, 228, 0.2)');
    gradientStroke1.addColorStop(0.2, 'rgba(94, 114, 228, 0.0)');
    gradientStroke1.addColorStop(0, 'rgba(94, 114, 228, 0)');
    new Chart(ctx1, {
      type: "line",
      data: {
        labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
          label: "Mobile apps",
          tension: 0.4,
          borderWidth: 0,
          pointRadius: 0,
          borderColor: "#5e72e4",
          backgroundColor: gradientStroke1,
          borderWidth: 3,
          fill: true,
          data: [50, 40, 300, 220, 500, 250, 400, 230, 500],
          maxBarThickness: 6

        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        interaction: {
          intersect: false,
          mode: 'index',
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              padding: 10,
              color: '#fbfbfb',
              font: {
                size: 11,
                family: "Open Sans",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              color: '#ccc',
              padding: 20,
              font: {
                size: 11,
                family: "Open Sans",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
        },
      },
    });
  </script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="{{ asset('assets/argon-dashboard-master/assets/js/argon-dashboard.min.js?v=2.0.4')}}"></script>

  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
document.querySelectorAll('.form-delete').forEach(form => {
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        Swal.fire({
            title: 'Yakin mau hapus?',
            text: 'Data tidak bisa dikembalikan!',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#198754',
            cancelButtonColor: '#dc3545',
            confirmButtonText: 'Ya, hapus!',
            cancelButtonText: 'Batal'
        }).then((result) => {
            if (result.isConfirmed) {
                form.submit();
            }
        });
    });
});
</script>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const input = document.getElementById('gambarTambahAlat');
    const img = document.getElementById('previewTambahAlat');
    const text = document.getElementById('previewText');

    if (!input) return;

    input.addEventListener('change', function () {
        const file = this.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function (e) {
            img.src = e.target.result;
            img.classList.remove('d-none');
            text.classList.add('d-none');
        };
        reader.readAsDataURL(file);
    });
});

document.addEventListener('DOMContentLoaded', function () {
    const input = document.getElementById('gambarEditAlat');
    const img = document.getElementById('previewEditAlat');
    const text = document.getElementById('previewEditText');

    if (!input) return;

    input.addEventListener('change', function () {
        const file = this.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function (e) {
            img.src = e.target.result;
            img.classList.remove('d-none');
            text.classList.add('d-none');
        };
        reader.readAsDataURL(file);
    });
});
</script>

</body>
</html>
