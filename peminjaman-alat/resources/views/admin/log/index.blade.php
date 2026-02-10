{{-- <h2>Log Aktivitas Sistem</h2>

<form method="GET" action="">
    <input type="text" name="nama" placeholder="Cari nama user" value="{{ request('nama') }}">

    <select name="role">
        <option value="">-- Semua Role --</option>
        <option value="admin" {{ request('role')=='admin'?'selected':'' }}>Admin</option>
        <option value="petugas" {{ request('role')=='petugas'?'selected':'' }}>Petugas</option>
        <option value="peminjam" {{ request('role')=='peminjam'?'selected':'' }}>Peminjam</option>
    </select>

    <input type="date" name="tanggal" value="{{ request('tanggal') }}">

    <button type="submit">Filter</button>
    <a href="/admin/log-aktivitas">Reset</a>
</form>
<a href="{{ route('admin.logcache.index') }}">
    📦 Lihat Log Arsip
</a>

<hr>

<table border="1" cellpadding="8">
    <thead>
        <tr>
            <th>No</th>
            <th>Waktu</th>
            <th>Nama User</th>
            <th>Role</th>
            <th>Aksi</th>
            <th>Deskripsi</th>
            <th>Aksi</th>
        </tr>
    </thead>
    <tbody>
        @forelse ($log as $item)
            <tr>
                <td>{{ $log->firstItem() + $loop->index }}</td>
                <td>{{ $item->created_at }}</td>
                <td>{{ $item->nama_user }}</td>
                <td>{{ ucfirst($item->role) }}</td>
                <td>{{ $item->aktivitas }}</td>
                <td>{{ $item->keterangan }}</td>
                <td>
                    <form action="{{ route('admin.log.destroy', $item->id_log) }}"
                          method="POST"
                          onsubmit="return confirm('Apakah yakin ingin menghapus log aktivitas ini?')">
                        @csrf
                        @method('DELETE')
                        <button type="submit" style="color:red">
                            Hapus
                        </button>
                    </form>
                </td>
            </tr>
        @empty
            <tr>
                <td colspan="6">Tidak ada data log</td>
            </tr>
        @endforelse
    </tbody>
</table>
<div style="margin-top:15px">
    {{ $log->links() }}
</div> --}}

@extends('layouts.admin')
@section('title','Data Peminjam Aktif')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
                <h6>
                    Log Aktivitas Sistem
                    <span class="badge badge-sm bg-gradient-success" style="margin-left: 70%">
                        <a href="{{ route('admin.logcache.index') }}" style="color: white">
                            <i class="fa-solid fa-box-open" style="color: #ffffff;"></i>        Lihat Log Arsip
                        </a>
                    </span>
                </h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Waktu</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama User</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Role</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aksi</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Deskripsi</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aksi</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($log as $item)
                    <tr>
                      <td>
                        <div class="d-flex px-3 py-1">
                          <div class="d-flex">
                            {{ $log->firstItem() + $loop->index }}
                          </div>
                        </div>
                      </td>
                      <td>
                        {{ $item->created_at }}
                      </td>
                      <td class="align-middle text-sm">
                        {{ $item->nama_user }}
                      </td>
                      <td class="align-middle text-center">
                        {{ ucfirst($item->role) }}
                      </td>
                      <td class="align-middle text-center">
                        {{ $item->aktivitas }}
                      </td>
                      <td class="align-middle text-sm">
                        {{ $item->keterangan }}
                      </td>
                      <td>
                        <form action="{{ route('admin.log.destroy', $item->id_log) }}" method="POST" style="display:inline" class="d-inline form-delete">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="border: none; background: none;" class="border-none"><i class="fa-solid fa-trash text-danger"></i></button>
                        </form>
                      </td>
                    </tr>
                    @endforeach
                  </tbody>
                </table>
                <div class="d-flex justify-content-center mt-4">
                    {{ $log->appends(request()->query())->links('pagination::bootstrap-5') }}
                </div>
              </div>
            </div>
        </div>
     </div>
</div>
@endsection
