  <aside class="sidenav bg-white navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-4 " id="sidenav-main">
    <div class="sidenav-header">
      <i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
      <a class="navbar-brand m-0" href=" https://demos.creative-tim.com/argon-dashboard/pages/dashboard.html " target="_blank">
        <img src="{{ asset('assets/argon-dashboard-master/assets/img/logo-ct-dark.png')}}" class="navbar-brand-img h-100" alt="main_logo">
        <span class="ms-1 font-weight-bold">Peminjaman Alat</span>
      </a>
    </div>
    <hr class="horizontal dark mt-0">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link {{ request()->is('petugas') ? 'active' : '' }}" href="/petugas">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-house-chimney text-primary text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Dashboard</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ request()->is('petugas/alat') ? 'active' : '' }}" href="/petugas/alat">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                 <i class="fa-solid fa-screwdriver-wrench text-success text-sm opacity-10"></i>
             </div>
            <span class="nav-link-text ms-1">Data Alat</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ Route::is('petugas.peminjaman') ? 'active' : '' }}" href="/petugas/peminjaman">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-people-carry-box text-sm opacity-10" style="color: #FFD43B;"></i>
            </div>
            <span class="nav-link-text ms-1">Setujui Peminjaman</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ Route::is('petugas.peminjaman.aktif') ? 'active' : '' }}" href="/petugas/peminjaman-aktif">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-user-clock text-sm opacity-10" style="color: #00ff1e;"></i>
            </div>
            <span class="nav-link-text ms-1" style="font-size: 13px">Pengembalian Peminjaman</span>
          </a>
        </li>
        <li class="nav-item">
         <a class="nav-link {{ Route::is('petugas.peminjaman.selesai') ? 'active' : '' }}" href="/petugas/peminjaman-selesai">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-user-check text-sm opacity-10" style="color: #00aafe;"></i>
            </div>
            <span class="nav-link-text ms-1">Peminjaman Selesai</span>
          </a>
        </li>
        <li class="nav-item">
         <a class="nav-link {{ Route::is('petugas.laporan') ? 'active' : '' }}" href="/petugas/laporan">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-user-check text-sm opacity-10" style="color: #00aafe;"></i>
            </div>
            <span class="nav-link-text ms-1">Cetak Laporan</span>
          </a>
        </li>
        {{-- <li class="nav-item">
          <a class="nav-link {{ request()->is('admin/alat*') ? 'active' : '' }}" href="/admin/alat">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-screwdriver-wrench text-success text-sm opacity-10"></i>
            </div>
            <span class="nav-link-text ms-1">Data Alat</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ request()->is('admin/peminjaman/aktif*') ? 'active' : '' }}" href="/admin/peminjaman/aktif">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-user-clock text-sm opacity-10" style="color: #ff7300;"></i>
            </div>
            <span class="nav-link-text ms-1">Peminjaman Aktif</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ request()->is(patterns: 'admin/peminjaman/selesai*') ? 'active' : '' }}" href="/admin/peminjaman/selesai">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-user-check text-sm opacity-10" style="color: #2bff00;"></i>
            </div>
            <span class="nav-link-text ms-1">Peminjaman Selesai</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link {{ request()->is(patterns: 'admin/log-aktivitas*') ? 'active' : '' }}" href="/admin/log-aktivitas">
            <div class="icon icon-shape icon-sm border-radius-md text-center me-2 d-flex align-items-center justify-content-center">
                <i class="fa-solid fa-clipboard-list text-sm opacity-10" style="color: #c200db;"></i>
            </div>
            <span class="nav-link-text ms-1">Log Aktivitas</span>
          </a>
        </li> --}}
      </ul>
    </div>
    <div class="sidenav-footer mx-3 ">
      <div class="card card-plain shadow-none" id="sidenavCard">
        <div class="card-body text-center p-3 w-100 pt-0">
        </div>
      </div>
      <br>
        <a href="/" class="btn btn-dark btn-sm w-100 mb-3">
            Keluar
             <i class="fa-solid fa-right-from-bracket" style="color: #ffffff;"></i>
        </a>
      <a class="btn btn-primary btn-sm mb-0 w-100" href="" type="button">Upgrade to pro</a>
    </div>
  </aside>
