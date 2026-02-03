@php
  $segment  = request()->segment(2);
  $segment2 = request()->segment(3);

  $pages = [
    'user' => 'Data User',
    'alat' => 'Data Alat',
    'kategori' => 'Data Kategori',
    'log-aktivitas' => 'Log Aktivitas',
    'log-cache' => 'Log Arsip',
  ];

  if ($segment === 'peminjaman') {
      if ($segment2 === 'aktif') {
          $title = 'Peminjaman Aktif';
      } elseif ($segment2 === 'selesai') {
          $title = 'Peminjaman Selesai';
      } else {
          $title = 'Peminjaman';
      }
  } else {
      $title = $pages[$segment] ?? 'Dashboard';
  }
@endphp

<div class="container-fluid py-3 px-4">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0">
      <li class="breadcrumb-item text-sm">
        <a class="opacity-5 text-white" href="{{ url('/admin') }}">
          Pages
        </a>
      </li>
      <li class="breadcrumb-item text-sm text-white active">
        {{ $title }}
      </li>
    </ol>

    <h6 class="font-weight-bolder text-white mb-0">
      {{ $title }}
    </h6>
  </nav>
</div>


<nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl " id="navbarBlur" data-scroll="false">
      <div class="container-fluid py-0 px-0">
        <div class="collapse navbar-collapse mt-sm-0 me-md-0 me-sm-4" id="navbar">
           <div class="ms-md-auto pe-md-3">
              <form method="GET" action="" class="d-flex align-items-center gap-2">

                <!-- SEARCH -->
                <div class="input-group input-group-sm" style="width: 220px;">
                  <span class="input-group-text">
                    <i class="fas fa-search"></i>
                  </span>
                  <input type="text"
                         name="search"
                         class="form-control"
                         placeholder="Cari..."
                         value="{{ request('search') }}">
                </div>

                <!-- ROLE -->
               @if(in_array($segment, ['kategori']))
                 <!--Empty-->
                  @elseif(in_array($segment, ['alat']))
                    <select name="id_kategori"
                            class="form-select form-select-sm"
                            style="width: 160px;"
                            onchange="this.form.submit()">
                        <option value="">Semua Kategori</option>
                        @foreach ($kategori as $k)
                            <option value="{{ $k->id_kategori }}"
                                {{ request('id_kategori') == $k->id_kategori ? 'selected' : '' }}>
                                {{ $k->nama_kategori }}
                            </option>
                        @endforeach
                    </select>
                @elseif(in_array($segment, ['peminjaman']))
                <select name="id_alat"
                            class="form-select form-select-sm"
                            style="width: 160px;"
                            onchange="this.form.submit()">
                        <option value="">Semua Alat</option>
                        @foreach ($alat as $k)
                            <option value="{{ $k->id_alat }}"
                                {{ request('id_alat') == $k->id_alat ? 'selected' : '' }}>
                                {{ $k->nama_alat }}
                            </option>
                        @endforeach
                    </select>
                    <select name="status"
                                class="form-select form-select-sm"
                                style="width: 140px;"
                                onchange="this.form.submit()">
                          <option value="">Semua status</option>
                          @if(in_array($segment2, ['aktif']))
                                <option value="menunggu" {{ request('status')=='menunggu' ? 'selected' : '' }}>Menunggu</option>
                                <option value="dipinjam" {{ request('status')=='dipinjam' ? 'selected' : '' }}>dipinjam</option>
                            @else
                                <option value="ditolak" {{ request('status')=='ditolak' ? 'selected' : '' }}>Ditolak</option>
                                <option value="dikembalikan" {{ request('status')=='dikembalikan' ? 'selected' : '' }}>Dikembalikan</option>
                          @endif
                    </select>
                @else
                    <select name="role"
                                class="form-select form-select-sm"
                                style="width: 140px;"
                                onchange="this.form.submit()">
                          <option value="">Semua Role</option>
                          <option value="admin" {{ request('role')=='admin' ? 'selected' : '' }}>Admin</option>
                          <option value="petugas" {{ request('role')=='petugas' ? 'selected' : '' }}>Petugas</option>
                    </select>
                @endif

                <!-- FROM DATE -->
                <input type="date"
                       name="from"
                       class="form-control form-control-sm"
                       style="width: 150px;"
                       value="{{ request('from') }}">

                <!-- TO DATE -->
                <input type="date"
                       name="to"
                       class="form-control form-control-sm"
                       style="width: 150px;"
                       value="{{ request('to') }}">

                <!-- SUBMIT -->
                <button class="btn btn-sm btn-white" style="margin-top: 15px; padding: 8px; width: 80px;">
                  <i class="fas fa-filter me-1"></i> Filter
                </button>

                <!-- RESET -->
                <a href="{{ url()->current() }}"
                   class="btn btn-sm btn-outline-secondary bg-white" style="margin-top: 15px">
                  Reset
                </a>

              </form>
            </div>
        </div>
      </div>
    </nav>
